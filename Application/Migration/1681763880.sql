CREATE TABLE questions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    question TEXT NOT NULL,
    answer TEXT NOT NULL
);
