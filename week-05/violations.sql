\set VERBOSITY verbose

TRUNCATE TABLE class_enrollment, group_class, trainer, member RESTART IDENTITY CASCADE;

INSERT INTO member (full_name, email, status, join_date) VALUES
('Ali Kaya', 'ali.kaya@example.com', 'active', '2026-01-10'),
('Ayse Demir', 'ayse.demir@example.com', 'active', '2026-01-12');

INSERT INTO trainer (full_name, specialty, hourly_rate) VALUES
('Mert Yilmaz', 'Cardio', 800.00);

INSERT INTO group_class (trainer_id, title, category, capacity, session_date, session_end_date, fee, promo_discount) VALUES
(1, 'Sabah HIIT', 'Cardio', 20, '2026-05-01', '2026-05-01', 300.00, 50.00);

INSERT INTO class_enrollment (member_id, class_id, enrolled_at) VALUES
(1, 1, '2026-04-20');

-- T01 | uq_member_email | Beklenen: 23505
INSERT INTO member (full_name, email, status, join_date) VALUES ('Baska Ali', 'ali.kaya@example.com', 'active', '2026-02-01');

-- T02 | uq_class_enrollment_member_class | Beklenen: 23505
INSERT INTO class_enrollment (member_id, class_id, enrolled_at) VALUES (1, 1, '2026-04-21');

-- T03 | chk_group_class_capacity_positive | Beklenen: 23514
INSERT INTO group_class (trainer_id, title, category, capacity, session_date, session_end_date, fee) VALUES (1, 'Hatali Kapasite', 'Cardio', 0, '2026-05-02', '2026-05-02', 200.00);

-- T04 | chk_group_class_capacity_positive | Beklenen: OK (sinir: capacity = 1)
INSERT INTO group_class (trainer_id, title, category, capacity, session_date, session_end_date, fee) VALUES (1, 'Tek Kisilik Seans', 'Cardio', 1, '2026-05-03', '2026-05-03', 200.00);

-- T05 | chk_member_status_valid | Beklenen: 23514
INSERT INTO member (full_name, email, status, join_date) VALUES ('Zeynep Acar', 'zeynep@example.com', 'frozen_invalid', '2026-02-05');

-- T06 | chk_group_class_date_order | Beklenen: 23514
INSERT INTO group_class (trainer_id, title, category, capacity, session_date, session_end_date, fee) VALUES (1, 'Ters Tarih', 'Cardio', 10, '2026-05-10', '2026-05-08', 250.00);

-- T07 | chk_group_class_date_order | Beklenen: OK (sinir: ayni gun baslangic ve bitis)
INSERT INTO group_class (trainer_id, title, category, capacity, session_date, session_end_date, fee) VALUES (1, 'Ayni Gun Kamp', 'Cardio', 15, '2026-05-12', '2026-05-12', 250.00);

-- T08 | member.full_name NOT NULL | Beklenen: 23502
INSERT INTO member (full_name, email, status, join_date) VALUES (NULL, 'nullname@example.com', 'active', '2026-02-06');

-- T09 | fk_class_enrollment_member (INSERT olmayan uye) | Beklenen: 23503
INSERT INTO class_enrollment (member_id, class_id, enrolled_at) VALUES (999, 1, '2026-04-22');

-- T10 | fk_group_class_trainer (DELETE kaydi/dersi olan egitmen) | Beklenen: 23503
DELETE FROM trainer WHERE trainer_id = 1;

-- T11 | chk_group_class_discount_valid (NULL testi: NOT NULL olmayan CHECK kolonuna NULL) | Beklenen: OK
INSERT INTO group_class (trainer_id, title, category, capacity, session_date, session_end_date, fee, promo_discount) VALUES (1, 'Indirimsiz Ders', 'Cardio', 10, '2026-05-15', '2026-05-15', 300.00, NULL);
