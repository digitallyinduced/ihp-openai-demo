ALTER TABLE questions ADD COLUMN created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL;
CREATE INDEX questions_created_at_index ON questions (created_at);
