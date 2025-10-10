CREATE TABLE user_items (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	uid UUID REFERENCES users(id) ON DELETE CASCADE,
	item_id UUID REFERENCES avatar_items(id),
	equipped boolean NOT NULL DEFAULT FALSE,
	acquired_at timestamp NOT NULL DEFAULT NOW(),
	UNIQUE (uid, item_id)
);