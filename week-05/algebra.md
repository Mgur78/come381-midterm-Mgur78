\# İlişkisel Cebir ve İlişkisel Hesap (algebra.md)



\## D1 — Kapasitesi 20'den büyük grup derslerinin adları

\- \*\*İlişkisel Cebir:\*\* $\\pi\_{\\text{title}}(\\sigma\_{\\text{capacity} > 20}(\\text{group\\\_class}))$

\- \*\*Sonuç:\*\* `Mat Pilates Aksam`, `Spinning Sprint`, `Vinyasa Akis`

\- \*\*DISTINCT Notu:\*\* Ders başlıkları tekil olduğu için `DISTINCT` gerekli değildir.



\## D2 — Her kaydın üye adı ve ders adı

\- \*\*İlişkisel Cebir:\*\* $\\pi\_{\\text{full\\\_name}, \\text{title}}(\\text{member} \\bowtie\_{\\text{member.member\\\_id} = \\text{class\\\_enrollment.member\\\_id}} \\text{class\\\_enrollment} \\bowtie\_{\\text{class\\\_enrollment.class\\\_id} = \\text{group\\\_class.class\\\_id}} \\text{group\\\_class})$

\- \*\*Sonuç:\*\* `seed.sql` verisindeki 8 kayıt satırı (üye adı ve ders adı eşleşmeleri).

\- \*\*DISTINCT Notu:\*\* Her kayıt satırının kendi eşleşmesini göstermesi amaçlandığı için `DISTINCT` gerekmez.



\## D3 — 'Pilates' veya 'Spinning' dersine kayıtlı üyeler

\- \*\*İlişkisel Cebir:\*\* $\\pi\_{\\text{full\\\_name}}(\\sigma\_{\\text{category} = \\text{'Pilates'}}(\\text{group\\\_class}) \\bowtie \\text{class\\\_enrollment} \\bowtie \\text{member}) \\cup \\pi\_{\\text{full\\\_name}}(\\sigma\_{\\text{category} = \\text{'Spinning'}}(\\text{group\\\_class}) \\bowtie \\text{class\\\_enrollment} \\bowtie \\text{member})$

\- \*\*Sonuç:\*\* `Elif Kaya`, `Burak Demir`, `Selin Yilmaz`

\- \*\*DISTINCT Notu:\*\* `UNION` küme birleşimi gibi çalışarak mükerrer satırları elediği için ayrıca `DISTINCT` zorunlu değildir.



\## D4 — Hiçbir derse kaydolmamış üyeler (`EXCEPT` ve `NOT EXISTS`)

\- \*\*İlişkisel Cebir:\*\* $\\pi\_{\\text{member\\\_id}, \\text{full\\\_name}}(\\text{member}) - \\pi\_{\\text{member\\\_id}, \\text{full\\\_name}}(\\text{member} \\bowtie \\text{class\\\_enrollment})$

\- \*\*Sonuç:\*\* `5 | Deniz Arslan`, `6 | Ece Sahin` (hem `EXCEPT` hem `NOT EXISTS` aynı sonucu verir).

\- \*\*DISTINCT Notu:\*\* `EXCEPT` ve `NOT EXISTS` satır/anahtar bazında filtrelediği için `DISTINCT` gerekmez.



\## D5 — Aynı tarihte (`enrolled\_at`) kayıt olmuş farklı üye çiftleri

\- \*\*İlişkisel Cebir:\*\* $\\pi\_{e\_1.\\text{member\\\_id}, e\_2.\\text{member\\\_id}, e\_1.\\text{enrolled\\\_at}}(\\rho\_{e\_1}(\\text{class\\\_enrollment}) \\bowtie\_{e\_1.\\text{enrolled\\\_at} = e\_2.\\text{enrolled\\\_at} \\land e\_1.\\text{member\\\_id} < e\_2.\\text{member\\\_id}} \\rho\_{e\_2}(\\text{class\\\_enrollment}))$

\- \*\*Sonuç:\*\* `(1, 2, 2026-05-20)`, `(1, 3, 2026-05-21)`

\- \*\*DISTINCT Notu:\*\* `e1.member\_id < e2.member\_id` koşulu aynı-üye ve simetrik çiftleri eler.



\## D6 — 'Pilates' kategorisindeki TÜM derslere kaydolmuş üyeler

\- \*\*İlişkisel Cebir:\*\* $\\pi\_{\\text{member\\\_id}, \\text{full\\\_name}}(\\text{member}) \\div \\pi\_{\\text{class\\\_id}}(\\sigma\_{\\text{category} = \\text{'Pilates'}}(\\text{group\\\_class}))$

\- \*\*Sonuç:\*\* `1 | Elif Kaya` (`Burak Demir` yalnızca 1 Pilates dersine kayıtlı olduğu için elenir).

\- \*\*Tercih Gerekçesi:\*\* İç içe iki `NOT EXISTS` ifadesini seçtim çünkü tüm derslere kayıtlı olma tümevarım kuralını `COUNT` karşılaştırmalarına göre daha doğrudan ifade eder.

\- \*\*DISTINCT Notu:\*\* `member` satırları üzerinden varlık kontrolü yapıldığı için `DISTINCT` gerekmez.



\## İlişkisel Hesap (Tuple Relational Calculus — D1)

\- $\\{ t.\\text{title} \\mid \\text{group\\\_class}(t) \\land t.\\text{capacity} > 20 \\}$

