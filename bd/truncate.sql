-- previous> file: spec/seeds_users.sql

--current: file: db/truncate.sql
TRUNCATE TABLE users RESTART IDENTITY;

INSERT INTO users (id, email, username) VALUES (1, 'test1@example.com', 'user1');
INSERT INTO users (id, email, username) VALUES (2, 'test2@example.com', 'user2');


