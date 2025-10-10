CREATE TABLE sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  host_id UUID REFERENCES users(id),
  start_time timestamp NOT NULL,
  price int NOT NULL,
  is_booked boolean NOT NULL DEFAULT FALSE,
  created_at timestamp NOT NULL DEFAULT NOW()
);