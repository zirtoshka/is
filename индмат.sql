CREATE INDEX ban_end_date_idx ON ban (end_date);

CREATE INDEX ban_smesharik_idx ON ban (smesharik_id);
CREATE INDEX ban_post_idx ON ban (post_id);

CREATE INDEX ban_comment_idx ON ban (comment_id);

create index smesharik_last_active_idx on smesharik (last_active);

CREATE INDEX post_publication_date_idx ON post (publication_date);

CREATE INDEX comment_creation_date_idx ON comment (creation_date);
