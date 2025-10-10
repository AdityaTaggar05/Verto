CREATE TABLE refresh_tokens (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	uid UUID REFERENCES users(id) ON DELETE CASCADE,
	token text NOT NULL,
	expires_at timestamp NOT NULL,
	created_at timestamp NOT NULL DEFAULT NOW(),
	revoked bool NOT NULL DEFAULT false
);