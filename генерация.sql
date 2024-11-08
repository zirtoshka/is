create or replace procedure generate_smesharik( count int ) language plpgsql as
$$
begin
    insert into smesharik (
		"name",
		login,
		"password",
		salt,
		email,
		"role",
		is_online,
		last_active
	) 
	select
		substr(md5(random()::text), 1, 25),
		substr(md5(random()::text), 1, 25),
		substr(md5(random()::text), 1, 128),
		substr(md5(random()::text), 1, 16),
		substr(md5(random()::text), 1, 16) || '@yandex.ru'::text,
		case 
			when (floor(random()*3)::int) = 0 then 'user'::smesharik_role
			when (floor(random()*3)::int) = 1 then 'doctor'::smesharik_role
			else 'admin'::smesharik_role
		end ,
		(floor(random()*2)::int) ::boolean,
		CURRENT_TIMESTAMP + interval '1 ms' * n
	from generate_series(1, count) as n;

	insert into post (
		author_id,
		is_draft,
		"text",
		private,
		path_to_image,
		publication_date,
		creation_date
	) select 
			s.id, 
			(floor(random()*2)::int) ::boolean,
			substr(md5(random()::text), 1, 2000), 
			(floor(random()*2)::int) ::boolean,
			substr(md5(random()::text), 1, 50), 
			CURRENT_TIMESTAMP + interval '1 ms' * s.id , 
			CURRENT_TIMESTAMP + interval '1 ms' * s.id 
			from smesharik as s;
	--comm on post
	insert into comment (
		smesharik_id,
		post_id,
		comment_id,
		"text",
		creation_date
	) select 
			s.id, 
			p.id,
			null,
			substr(md5(random()::text), 1, 300), 
			CURRENT_TIMESTAMP + interval '1 ms' * s.id 
			from smesharik as s 
			left join post as p on p.author_id=s.id;
	--comm on comm
	insert into comment (
		smesharik_id,
		post_id,
		comment_id,
		"text",
		creation_date
	) select 
			c.smesharik_id, 
			null,
			c.id,
			substr(md5(random()::text), 1, 300), 
			CURRENT_TIMESTAMP + interval '1 ms' * c.smesharik_id
			from comment as c;

	--ban smesharik
	insert into ban (
		reason,
		smesharik_id,
		post_id,
		comment_id,
		creation_date,
		end_date
	) select 
			substr(md5(random()::text), 1, 300), 
			s.id, 
			null,
			null,
			CURRENT_TIMESTAMP + interval '1 ms' * s.id,
			CURRENT_TIMESTAMP + interval '1 ms' * s.id
			from smesharik as s;

	--ban post
	insert into ban (
		reason,
		smesharik_id,
		post_id,
		comment_id,
		creation_date,
		end_date
	) select 
			substr(md5(random()::text), 1, 300), 	
			null,
			p.id,
			null,
			CURRENT_TIMESTAMP + interval '1 ms' * p.id,
			CURRENT_TIMESTAMP - interval '1 ms' * p.id
			from post as p;

	--ban comment
	insert into ban (
		reason,
		smesharik_id,
		post_id,
		comment_id,
		creation_date,
		end_date
	) select 
			substr(md5(random()::text), 1, 300), 
			null,
			null,
			c.id,
			CURRENT_TIMESTAMP + interval '1 ms' * c.id,
			CURRENT_TIMESTAMP - interval '1 ms' * c.id
			from comment as c;
		
end;
$$;

-- выставить необходимое кол-во записей в смешариках,
-- от которых будут созданы все остальные
call generate_smesharik(1000000);