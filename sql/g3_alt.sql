-- Soru 3.1: Ücreti ortalama ders ücretinin üzerinde olan derslerin adı ve ücreti
SELECT ad, ucret
FROM dersler
WHERE ucret > (SELECT AVG(ucret) FROM dersler);

-- Soru 3.2: Yüzme branşındaki eğitmenlerin verdiği derslerin adları
SELECT ad
FROM dersler
WHERE egitmen_id IN (
    SELECT egitmen_id 
    FROM egitmenler 
    WHERE brans = 'Yüzme'
);

-- Soru 3.3: WITH (CTE) zorunlu: en çok kayda sahip üyenin adı ve kayıt sayısı
WITH uye_kayit_sayilari AS (
    SELECT u.uye_id, u.ad, COUNT(k.kayit_id) AS kayit_sayisi
    FROM uyeler u
    LEFT JOIN kayitlar k ON u.uye_id = k.uye_id
    GROUP BY u.uye_id, u.ad
)
SELECT ad, kayit_sayisi
FROM uye_kayit_sayilari
WHERE kayit_sayisi = (SELECT MAX(kayit_sayisi) FROM uye_kayit_sayilari);