# Soru 3.3 - Yapay Zeka Cozumunun Analizi ve Elestirisi

### 1. Yapay Zekaya Sorulan Istek ve Urettigi Kod:
Soru 3.3 icin yapay zekaya tablo semasini verip en cok kayda sahip uyeyi getirmesini istedigimde su sorguyu verdi:

```sql
SELECT u.ad, COUNT(k.kayit_id) AS kayit_sayisi
FROM uyeler u
JOIN kayitlar k ON u.uye_id = k.uye_id
GROUP BY u.uye_id, u.ad
ORDER BY kayit_sayisi DESC
LIMIT 1;
```

### 2. Kendi Deneyimim ve Elestirilerim:
Bu sorguyu veritabaninda calistirdigimda hatasiz calisti ve bana tek bir uye getirdi. Ancak ciktisini inceledigimde iki onemli kusur tespit ettim:

Birincisi, yapay zekanin kullandigi LIMIT 1 mantigi beraberlik (tie) durumunu tamamen bozmaktadir. Eger veritabaninda en yuksek kayit sayisina sahip birden fazla uye varsa, bu sorgu sadece birini ekrana basar ve diger uyeleri gormezden gelir. Bizim yazdigimiz CTE yapisinda ise MAX() degeri dinamik alindigi icin zirvedeki tum uyeler listelenir.

Ikincisi, yapay zeka INNER JOIN kullanmistir. Hicbir derse kaydolmamis uyeler elenir; bu yuzden LEFT JOIN kullanmak mantiken daha guvenli bir aliskanliktir.

Sonuc olarak CTE ile yazdigimiz cozum hem adim adim cok daha rahat okunuyor hem de beraberlik durumlarinda kesinlikle veri kaybi yasatmiyor.

### 3. Hatasiz Duzeltilmis Hali:
```sql
SELECT u.ad, COUNT(k.kayit_id) AS kayit_sayisi
FROM uyeler u
JOIN kayitlar k ON u.uye_id = k.uye_id
GROUP BY u.uye_id, u.ad
HAVING COUNT(k.kayit_id) = (
    SELECT MAX(sayi) 
    FROM (
        SELECT COUNT(kayit_id) AS sayi 
        FROM kayitlar 
        GROUP BY uye_id
    ) AS t
);
```
