TRUNCATE TABLE class_enrollment, group_class, trainer, member RESTART IDENTITY CASCADE;

INSERT INTO member (full_name, email, status, join_date) VALUES
('Elif Kaya', 'elif.kaya@gym.local', 'active', '2026-01-05'),
('Burak Demir', 'burak.demir@gym.local', 'active', '2026-01-08'),
('Selin Yilmaz', 'selin.yilmaz@gym.local', 'active', '2026-01-11'),
('Can Ozturk', 'can.ozturk@gym.local', 'suspended', '2026-01-15'),
('Deniz Arslan', 'deniz.arslan@gym.local', 'active', '2026-02-01'),
('Ece Sahin', 'ece.sahin@gym.local', 'closed', '2026-02-10');

INSERT INTO trainer (full_name, specialty, hourly_rate) VALUES
('Kerem Aydin', 'Pilates', 950.00),
('Ceren Koc', 'Spinning', 850.00),
('Hakan Tas', 'Strength', 1100.00),
('Melis Kurt', 'Yoga', 750.00),
('Onur Yildiz', 'Boxing', 1000.00);

-- 'Pilates' kategorisinde 2 ders var (class_id 1 ve 2):
-- Elif Kaya (member_id 1) ikisine de katiliyor (tam aday).
-- Burak Demir (member_id 2) sadece 1. Pilates dersine katiliyor ('neredeyse' aday).
INSERT INTO group_class (trainer_id, title, category, capacity, session_date, session_end_date, fee, promo_discount) VALUES
(1, 'Reform Pilates Sabah', 'Pilates', 12, '2026-06-01', '2026-06-01', 400.00, 50.00),
(1, 'Mat Pilates Aksam', 'Pilates', 30, '2026-06-03', '2026-06-03', 350.00, NULL),
(2, 'Spinning Sprint', 'Spinning', 25, '2026-06-02', '2026-06-02', 300.00, 30.00),
(3, 'Barbell Temel', 'Strength', 16, '2026-06-04', '2026-06-04', 450.00, NULL),
(4, 'Vinyasa Akis', 'Yoga', 22, '2026-06-05', '2026-06-05', 320.00, 20.00),
(5, 'Boks Kondisyon', 'Boxing', 18, '2026-06-06', '2026-06-06', 380.00, NULL);

-- Deniz Arslan (5) ve Ece Sahin (6) hicbir derse kayitli degil (D4 adaylari).
INSERT INTO class_enrollment (member_id, class_id, enrolled_at) VALUES
(1, 1, '2026-05-20'),
(1, 2, '2026-05-21'),
(1, 3, '2026-05-22'),
(2, 1, '2026-05-20'),
(2, 3, '2026-05-22'),
(3, 2, '2026-05-21'),
(3, 4, '2026-05-23'),
(4, 5, '2026-05-24');
