\# week-05 Çalıştırma ve Notlar



\## 1. Çalıştırma Sırası (Windows -U postgres)



```powershell

psql -U postgres -d come381 -f sql/schema.sql

psql -U postgres -d come381 -f week-05/constraints.sql

psql -U postgres -d come381 -f week-05/violations.sql

psql -U postgres -d come381 -f week-05/seed.sql

psql -U postgres -d come381 -f week-05/algebra.sql

