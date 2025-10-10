CREATE TYPE item_category as ENUM ('skin', 'weapon', 'pet', 'armor');
CREATE TYPE item_rarity as ENUM ('common', 'rare', 'epic', 'legendary');

CREATE TABLE avatar_items (
	id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
	name varchar(20) NOT NULL,
	category item_category NOT NULL,
	rarity item_rarity NOT NULL DEFAULT 'common',
	price int NOT NULL,
	level_required int NOT NULL DEFAULT 1,
	image_url text NOT NULL,
	created_at timestamp NOT NULL DEFAULT NOW()
);