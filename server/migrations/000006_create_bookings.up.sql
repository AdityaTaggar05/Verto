CREATE TABLE bookings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id UUID REFERENCES sessions(id),
  booked_by UUID REFERENCES users(id),
  booked_at timestamp NOT NULL DEFAULT NOW()
);