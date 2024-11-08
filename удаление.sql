DROP TABLE IF EXISTS smesharik CASCADE;
DROP TABLE IF EXISTS application_for_treatment CASCADE;
DROP TABLE IF EXISTS application_for_treatment_propensity CASCADE;
DROP TABLE IF EXISTS ban CASCADE;
DROP TABLE IF EXISTS carrot CASCADE;
DROP TABLE IF EXISTS comment CASCADE;
DROP TABLE IF EXISTS complaint CASCADE;
DROP TABLE IF EXISTS friend CASCADE;
DROP TABLE IF EXISTS notification CASCADE;
DROP TABLE IF EXISTS post CASCADE;
DROP TABLE IF EXISTS post_trigger_word CASCADE;
DROP TABLE IF EXISTS comment_trigger_word CASCADE;
DROP TABLE IF EXISTS propensity CASCADE;
DROP TABLE IF EXISTS trigger_word CASCADE;

drop sequence if exists application_for_treatment_id_seq;
drop sequence if exists application_for_treatment_propensity_id_seq;
drop sequence if exists ban_id_seq;
drop sequence if exists carrot_id_seq;
drop sequence if exists comment_id_seq;
drop sequence if exists comment_trigger_word_id_seq;
drop sequence if exists complaint_id_seq;
drop sequence if exists friend_id_seq;
drop sequence if exists notification_id_seq;
drop sequence if exists post_id_seq;
drop sequence if exists post_trigger_word_id_seq;
drop sequence if exists propensity_id_seq;
drop sequence if exists smesharik_id_seq;
drop sequence if exists trigger_word_id_seq;


drop type if exists smesharik_role cascade;
drop type if exists friend_status cascade;
drop type if exists general_status cascade;
drop type if exists violation_type cascade;

DROP FUNCTION IF EXISTS update_last_active() CASCADE;
DROP FUNCTION IF EXISTS cancel_application_on_delete() CASCADE;
drop function if exists create_application_for_threatment() cascade;
drop function if EXISTS update_material_views_ban() CASCADE;

drop materialized view if exists smesharik_ban cascade;
drop materialized view if exists post_ban cascade;
drop materialized view if exists comment_ban cascade;
