# Silme Politikası (on\_delete.md)

|Foreign Key|Ebeveyn -> Çocuk|Seçimin|Neden|Diğer seçenek neden olmadı|
|-|-|-|-|-|
|k\_group\_class\_trainer|rainer -> group\_class|RESTRICT|Eğitmenin verdiği ders kayıtları silinmeden eğitmen kaydının silinmesini engeller.|CASCADE geçmiş ders kayıtlarını iz bırakmadan silerdi.|
|k\_class\_enrollment\_member|member -> class\_enrollment|CASCADE|Üye silindiğinde o üyeye ait aktif ders kayıtlarının kalması anlamlı değildir.|RESTRICT üye silme işlemini kayıtlar yüzünden kilitlerdi.|
|k\_class\_enrollment\_class|group\_class -> class\_enrollment|RESTRICT|Kayıtlı öğrencisi bulunan bir dersin yanlışlıkla silinmesini önler.|CASCADE ders silinince öğrenci kayıtlarını haber vermeden silerdi.|

## RESTRICT ile NO ACTION Arasındaki Fark

RESTRICT foreign key kontrolünü deyim (statement) sonunda ve ertelenemez biçimde denetlerken, NO ACTION varsayılan olarak kontrolü transaction sonuna kadar erteleyebilir (deferrable) ve satır bazında işlem sonunda kontrol eder.

CASCADE Kanıtı (
k\_class\_enrollment\_member)
---

Silme öncesi satır sayıları (SELECT count(*) FROM member; ve SELECT count(*) FROM class\_enrollment;):

* member: 2 satır
* class\_enrollment: 1 satır (üye 1 için kayıt)

DELETE FROM member WHERE member\_id = 1; çalıştırıldıktan sonraki satır sayıları:

* member: 1 satır
* class\_enrollment:   satır (ilişkili kayıt otomatik silindi)

