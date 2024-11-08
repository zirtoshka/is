create materialized view if not exists smesharik_ban as
select s.id, b.end_date from smesharik s 
left join ban as b on s.id = b.smesharik_id
where b.end_date > now();

create materialized view if not exists post_ban as
select p.id, b.end_date from post p 
left join ban as b on p.id = b.post_id
where b.end_date > now();

create materialized view if not exists comment_ban as
select c.id, b.end_date from "comment" c 
left join ban as b on c.id = b.comment_id
where b.end_date > now();

CREATE TRIGGER trigger_create_application_for_threatment
AFTER INSERT ON post_trigger_word
FOR EACH ROW
EXECUTE FUNCTION create_application_for_threatment();


CREATE OR REPLACE FUNCTION update_material_views_ban()
RETURNS TRIGGER AS $$
BEGIN
RAISE 
		NOTICE 'Refreshing smesharik_ban view';
        REFRESH MATERIALIZED VIEW smesharik_ban;
    
        REFRESH MATERIALIZED VIEW post_ban;
   
        REFRESH MATERIALIZED VIEW comment_ban;
  

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_update_bans
AFTER UPDATE OR insert or delete ON ban
FOR EACH statement
EXECUTE function  update_material_views_ban();