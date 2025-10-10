CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE users (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	first_name varchar(20) NOT NULL,
	last_name varchar(20) NOT NULL,
	username varchar(20) NOT NULL,
	email varchar(50) NOT NULL,
	pass_hash text NOT NULL,
	coins int NOT NULL DEFAULT 0,
	level int NOT NULL DEFAULT 1,
	xp int NOT NULL DEFAULT 0,
	created_at timestamp NOT NULL DEFAULT NOW(),
	
	last_login timestamp
);