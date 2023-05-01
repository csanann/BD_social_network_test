-- db/create_tables.sql
-- create the users table
CREATE TABLE users (
   id SERIAL PRIMARY KEY,
   email VARCHAR(100),
   username VARCHAR(100)
);

-- create the posts table
CREATE TABLE posts (
   id SERIAL PRIMARY KEY,
   user_id INTEGER,
   title VARCHAR(200),
   content TEXT,
   views INTEGER,
   constraint fk_user foreign key(user_id) references users(id) on delete cascade
);