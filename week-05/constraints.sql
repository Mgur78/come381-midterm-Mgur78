-- Üyenin ad soyad bilgisi boş bırakılamaz.
ALTER TABLE member ALTER COLUMN full_name SET NOT NULL;

-- Üyenin e-posta adresi boş bırakılamaz.
ALTER TABLE member ALTER COLUMN email SET NOT NULL;

-- Üyenin kayıt tarihi boş bırakılamaz.
ALTER TABLE member ALTER COLUMN join_date SET NOT NULL;

-- Eğitmenin adı, uzmanlık alanı ve saatlik ücreti boş bırakılamaz.
ALTER TABLE trainer ALTER COLUMN full_name SET NOT NULL;
ALTER TABLE trainer ALTER COLUMN specialty SET NOT NULL;
ALTER TABLE trainer ALTER COLUMN hourly_rate SET NOT NULL;

-- Grup dersinin başlığı, kategorisi, kapasitesi, başlangıç ve bitiş tarihi ile ücreti boş bırakılamaz.
ALTER TABLE group_class ALTER COLUMN trainer_id SET NOT NULL;
ALTER TABLE group_class ALTER COLUMN title SET NOT NULL;
ALTER TABLE group_class ALTER COLUMN category SET NOT NULL;
ALTER TABLE group_class ALTER COLUMN capacity SET NOT NULL;
ALTER TABLE group_class ALTER COLUMN session_date SET NOT NULL;
ALTER TABLE group_class ALTER COLUMN session_end_date SET NOT NULL;
ALTER TABLE group_class ALTER COLUMN fee SET NOT NULL;

-- Kayıt satırında üye, ders ve kayıt tarihi boş bırakılamaz.
ALTER TABLE class_enrollment ALTER COLUMN member_id SET NOT NULL;
ALTER TABLE class_enrollment ALTER COLUMN class_id SET NOT NULL;
ALTER TABLE class_enrollment ALTER COLUMN enrolled_at SET NOT NULL;

-- Her üyenin e-posta adresi sistemde tekil olmalıdır.
ALTER TABLE member ADD CONSTRAINT uq_member_email UNIQUE (email);

-- Bir üye aynı grup dersine birden fazla kez kaydolamaz.
ALTER TABLE class_enrollment ADD CONSTRAINT uq_class_enrollment_member_class UNIQUE (member_id, class_id);

-- Grup dersi kapasitesi en az 1 olmalıdır.
ALTER TABLE group_class ADD CONSTRAINT chk_group_class_capacity_positive CHECK (capacity > 0);

-- Eğitmen saatlik ücreti negatif olamaz.
ALTER TABLE trainer ADD CONSTRAINT chk_trainer_hourly_rate_nonneg CHECK (hourly_rate >= 0);

-- Ders ücreti negatif olamaz.
ALTER TABLE group_class ADD CONSTRAINT chk_group_class_fee_nonneg CHECK (fee >= 0);

-- Üye durumu yalnızca tanımlı geçerli değerlerden biri olabilir.
ALTER TABLE member ADD CONSTRAINT chk_member_status_valid CHECK (status IN ('active', 'suspended', 'closed'));

-- Ders bitiş tarihi başlangıç tarihinden önce olamaz.
ALTER TABLE group_class ADD CONSTRAINT chk_group_class_date_order CHECK (session_end_date >= session_date);

-- Tanımlıysa promosyon indirimi negatif olamaz ve ders ücretini aşamaz.
ALTER TABLE group_class ADD CONSTRAINT chk_group_class_discount_valid CHECK (promo_discount IS NULL OR (promo_discount >= 0 AND promo_discount <= fee));

-- İsimli foreign key tanımları
ALTER TABLE group_class DROP CONSTRAINT IF EXISTS group_class_trainer_id_fkey;
ALTER TABLE group_class ADD CONSTRAINT fk_group_class_trainer FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE class_enrollment DROP CONSTRAINT IF EXISTS class_enrollment_member_id_fkey;
ALTER TABLE class_enrollment ADD CONSTRAINT fk_class_enrollment_member FOREIGN KEY (member_id) REFERENCES member(member_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE class_enrollment DROP CONSTRAINT IF EXISTS class_enrollment_class_id_fkey;
ALTER TABLE class_enrollment ADD CONSTRAINT fk_class_enrollment_class FOREIGN KEY (class_id) REFERENCES group_class(class_id) ON DELETE RESTRICT ON UPDATE CASCADE;
