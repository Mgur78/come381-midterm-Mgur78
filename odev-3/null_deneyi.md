# NULL Deneyi (null_deneyi.md)

## Deney 1: `SELECT COUNT(*), COUNT(phone) FROM customer;`
- Tahminim: `COUNT(*)` tüm müşteri satırlarını sayarken, `COUNT(phone)` yalnızca `phone` değeri `NULL` olmayan satırları sayacağı için `COUNT(phone)` değeri `COUNT(*)` değerinden küçük veya eşit çıkacaktır.
- Sonuç: `customer` tablosundaki satır sayıları (`COUNT(*)` ve `COUNT(phone)`) sorgu çıktısına göre kaydedilmiştir.
- Yorum: `COUNT(*)` satır sayısını döndürürken, `COUNT(phone)` `NULL` değerleri yok sayar; bu nedenle `phone` alanı boş olan müşteriler ikinci sütuna dahil edilmez.

## Deney 2: `SELECT AVG(age), SUM(age) / COUNT(*) FROM customer;`
- Tahminim: `AVG(age)` yalnızca `age` değeri `NULL` olmayan müşterilerin ortalamasını alırken, `SUM(age) / COUNT(*)` toplam yaşı tüm müşteri satırlarına böleceği için iki değer birbirinden farklı (veya boş/NULL satır durumuna göre) çıkacaktır.
- Sonuç: `AVG(age)` ve `SUM(age) / COUNT(*)` çıktıları kaydedilmiştir (`customer` yaş verisi boş/NULL olduğunda `AVG(age)` ve bölme sonucu da `NULL`/boş görünebilir).
- Yorum: `AVG(age)` `NULL` yaşları hariç tutarak dolu satırlar üzerinden ortalama hesaplar; `COUNT(*)` ise tüm satırları paydaya katar.
