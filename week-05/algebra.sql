-- D1: Kapasitesi 20'den buyuk grup derslerinin adlari
SELECT title
FROM group_class
WHERE capacity > 20;

-- D2: Her kaydin uye adi ve ders adi
SELECT m.full_name AS member_name, gc.title AS class_title
FROM class_enrollment ce
JOIN member m ON m.member_id = ce.member_id
JOIN group_class gc ON gc.class_id = ce.class_id;

-- D3: 'Pilates' veya 'Spinning' dersine kayitli uyeler (UNION)
SELECT DISTINCT m.full_name
FROM class_enrollment ce
JOIN member m ON m.member_id = ce.member_id
JOIN group_class gc ON gc.class_id = ce.class_id
WHERE gc.category = 'Pilates'
UNION
SELECT DISTINCT m.full_name
FROM class_enrollment ce
JOIN member m ON m.member_id = ce.member_id
JOIN group_class gc ON gc.class_id = ce.class_id
WHERE gc.category = 'Spinning';

-- D4a: Hicbir derse kaydolmamis uyeler (EXCEPT)
SELECT member_id, full_name
FROM member
EXCEPT
SELECT DISTINCT m.member_id, m.full_name
FROM member m
JOIN class_enrollment ce ON ce.member_id = m.member_id;

-- D4b: Hicbir derse kaydolmamis uyeler (NOT EXISTS)
SELECT m.member_id, m.full_name
FROM member m
WHERE NOT EXISTS (
    SELECT 1
    FROM class_enrollment ce
    WHERE ce.member_id = m.member_id
);

-- D5: Ayni katilim tarihinde (enrolled_at) kayit olmus farkli uye ciftleri (self-join)
SELECT e1.member_id AS member_1, e2.member_id AS member_2, e1.enrolled_at
FROM class_enrollment e1
JOIN class_enrollment e2
  ON e1.enrolled_at = e2.enrolled_at
 AND e1.member_id < e2.member_id;

-- D6: 'Pilates' kategorisindeki TUM derslere kaydolmus uyeler (NOT EXISTS division)
SELECT m.member_id, m.full_name
FROM member m
WHERE NOT EXISTS (
    SELECT 1
    FROM group_class gc
    WHERE gc.category = 'Pilates'
      AND NOT EXISTS (
          SELECT 1
          FROM class_enrollment ce
          WHERE ce.member_id = m.member_id
            AND ce.class_id = gc.class_id
      )
);
