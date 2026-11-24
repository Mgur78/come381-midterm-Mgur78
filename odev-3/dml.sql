\set VERBOSITY verbose

BEGIN;

-- Önce: Sıcak İçecek fiyatları
SELECT product_id, name, price
FROM product
WHERE category = 'Sıcak İçecek'
ORDER BY product_id;

-- Komut 1: 'Sıcak İçecek' ürünlerinin fiyatını 5 TL artır
UPDATE product
SET price = price + 5
WHERE category = 'Sıcak İçecek';

-- Sonra: Sıcak İçecek fiyatları (hatadan önce, 5 TL artmış hal)
SELECT product_id, name, price
FROM product
WHERE category = 'Sıcak İçecek'
ORDER BY product_id;

-- Komut 2: Var olmayan 999 numaralı ürünü bir siparişe ekle (23503 hatası beklenir)
INSERT INTO order_item (order_id, product_id, quantity)
VALUES (1, 999, 1);

ROLLBACK;

-- ROLLBACK sonrası: Sıcak İçecek fiyatları (eski haline dönmüş olmalı)
SELECT product_id, name, price
FROM product
WHERE category = 'Sıcak İçecek'
ORDER BY product_id;