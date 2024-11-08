--запросы в случае отсутствия всего (индексы + мат пред) или
-- когда индексы только
explain analyze select * from post as p
left join ban as b on p.id = b.post_id 
where (b.id isnull or b.end_date <= now()) and private = false  
order by publication_date desc;

explain analyze select * from smesharik as s
left join ban as b on s.id = b.smesharik_id 
where (b.id isnull or b.end_date <= now())   
order by last_active desc;

explain analyze select * from "comment" as c
left join ban as b on c.id = b.comment_id 
where (b.id isnull or b.end_date <= now())   
order by c.creation_date desc;

explain analyze select * from "comment" as c left join
ban as b on c.id = b.comment_id 
where (b.comment_id isnull or b.end_date <=now()) and
(c.comment_id isnull or EXISTS (
    SELECT 1 
    FROM public."comment" AS sub_c 
    WHERE (post_id notnull) and sub_c.id = c.comment_id
))
order by c.creation_date ;


-- запросы когда есть мат представление + индексы
explain analyze select * from post as p
left join post_ban as b on p.id = b.id 
where (b.id isnull or b.end_date <= now()) and private = false  
order by publication_date desc;

explain analyze select * from smesharik as s
left join smesharik_ban as b on s.id = b.id 
where (b.id isnull or b.end_date <= now())  
order by last_active desc;

explain analyze select * from "comment" as c
left join comment_ban as b on c.id = b.id 
where (b.id isnull or b.end_date <= now())   
order by creation_date desc;

explain analyze select * from "comment" as c left join
comment_ban cb on c.id = cb.id 
where (cb.id isnull or cb.end_date <=now()) and
(comment_id isnull or EXISTS (
    SELECT 1 
    FROM public."comment" AS sub_c 
    WHERE (post_id notnull) and sub_c.id = c.comment_id
))
order by creation_date 




--isnert'ы
explain analyze INSERT INTO smesharik (name, login, password, salt, email, role, is_online)
VALUES 
    ('Nusha', 'nusha_login', 'password_hash_1', 'salt1', 'nusha@example.com', 'user', true);
 
   
explain analyze INSERT INTO post (author_id, is_draft, text, private, path_to_image)
VALUES 
    (1, false, 'This is a public post by Nusha', false, '/images/nusha1.png');
   
   
explain analyze INSERT INTO comment (smesharik_id, post_id, text)
VALUES 
    (2, 1, 'Great post, Nusha!');
   
   
explain analyze INSERT INTO ban (reason, smesharik_id, post_id, comment_id, end_date)
VALUES 
    ('Violation of community guidelines', 500000, NULL, NULL, CURRENT_TIMESTAMP + interval '1 ms')  
   