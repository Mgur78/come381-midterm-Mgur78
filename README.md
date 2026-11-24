# COME381 Vize Projesi — Spor Salonu ve Ders Kayıt Sistemi

Bu proje, spor salonu üyelerinin eğitmenler tarafından verilen grup derslerine kaydını ve ders ücretlendirmesini yönetmek için tasarlanmıştır. Üyeler ile grup dersleri arasındaki çoktan çoğa (M:N) ilişkiyi normalize etmek ve kayıt tarihini ayrı tutabilmek için class_enrollment ara tablosu oluşturuldu. Her grup dersinin tek bir eğitmen tarafından verilmesi modellemesiyle group_class tablosuna trainer_id yabancı anahtarı eklendi. Tüm birincil anahtarlar PostgreSQL IDENTITY sütunlarıyla otomatik üretilecek şekilde kurgulandı.
