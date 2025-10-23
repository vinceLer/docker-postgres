-- Create table if it doesn't exist
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50) UNIQUE
);

-- Insert users if they don't exist, update name if email exists
INSERT INTO users (name, email)
VALUES
    ('Alice', 'alice@example.com'),
    ('Bob', 'bob@example.com'),
    ('Franck', 'franck@example.com'),
    ('Diana', 'diana@example.com')
ON CONFLICT (email) DO UPDATE
SET name = EXCLUDED.name;

-- Display all users
SELECT * FROM users;
