-- file: db/data.sql

-- insert some sample data
INSERT INTO users (email, username) VALUES ('user1@example.com', 'user1');
INSERT INTO users (email, username) VALUES ('user2@example.com', 'user2');
INSERT INTO users (email, username) VALUES ('user3@example.com', 'user3');

INSERT INTO posts (user_id, title, content, views) VALUES (1, 'Title1', 'User content1', 1);
INSERT INTO posts (user_id, title, content, views) VALUES (2, 'Title2', 'User content2', 2);
INSERT INTO posts (user_id, title, content, views) VALUES (3, 'Title3', 'User content3', 3);