CREATE TABLE ratings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id UUID REFERENCES sessions(id) ON DELETE CASCADE,
  hosted_by UUID REFERENCES users(id),
  rated_by UUID REFERENCES users(id),
  rating int NOT NULL CHECK (rating >= 1 AND rating <= 5),
  created_at timestamp NOT NULL DEFAULT NOW()
);