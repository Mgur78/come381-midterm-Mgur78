# COME381 — Ödev 3 Raporu (`odev-3`)

## 1. Veri ve Sorgular (`sorgular.sql` & `sorgular_cikti.txt`)
- `kafe` veritabanı üzerinde Q1–Q6 sorguları çalıştırılmış ve ham çıktılar `odev-3/sorgular_cikti.txt` dosyasına kaydedilmiştir.
- Sorgular müşteri, ürün ve sipariş kayıtlarının filtrelenmesi, sıralanması ve özetlenmesi amacıyla hazırlanmıştır.

## 2. NULL Deneyi (`null_deneyi.md`)
- `COUNT(*)` tüm satırları sayarken `COUNT(phone)` yalnızca `NULL` olmayan telefon numaralarını sayar.
- `AVG(age)` `NULL` yaş değerlerini hariç tutarak ortalama alırken `SUM(age) / COUNT(*)` tüm satırları paydaya katar (`age` değerleri boş/NULL olduğunda sonuç da `NULL` dönebilir).

## 3. Değiştir ve Geri Al / Transaction (`dml.sql` & `dml_cikti.txt`)
- `BEGIN` bloğu içinde `UPDATE product` ile kategori fiyat güncellemesi test edilmiştir.
- Var olmayan `999` numaralı ürün için `INSERT INTO order_item` denemesi `23503` yabancı anahtar (foreign key) kısıt hatası üretmiştir.
- `ROLLBACK` komutu çalıştırılarak yapılan tüm değişiklikler geri alınmış ve tablo durumu korunmuştur; tüm çıktılar `odev-3/dml_cikti.txt` dosyasına aktarılmıştır.
