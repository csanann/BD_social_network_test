-- to create two tables --file spec/seeds_test.sql

TRUNCATE TABLE users RESTART IDENTITY;
TRUNCATE TABLE posts RESTART IDENTITY;

-- Insert some sample user records
INSERT INTO users (email, username) VALUES ('test1@example.com', 'test1');
INSERT INTO users (email, username) VALUES ('test2@example.com', 'test2');

-- Insert some sample post records
INSERT INTO posts (user_id, title, content, views) VALUES (1, 'My First Post', 'Hello, world!', 10);
INSERT INTO posts (user_id, title, content, views) VALUES (2, 'Another Post', 'This is another post.', 5);

-- psql -h 127.0.0.1 -d social_network_test -f spec/seeds_test.sql
