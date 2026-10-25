-- Soru 4.1
SELECT 
    s.ad AS salon_adi, 
    d.ad AS ders_adi, 
    d.ucret,
    RANK() OVER (PARTITION BY s.salon_id ORDER BY d.ucret DESC) AS ucret_sirasi
FROM dersler d
JOIN salonlar s ON d.salon_id = s.salon_id;

-- Soru 4.2
WITH sirali_dersler AS (
    SELECT 
        s.ad AS salon_adi, 
        d.ad AS ders_adi, 
        d.ucret,
        RANK() OVER (PARTITION BY s.salon_id ORDER BY d.ucret DESC) AS sira
    FROM dersler d
    JOIN salonlar s ON d.salon_id = s.salon_id
)
SELECT salon_adi, ders_adi, ucret
FROM sirali_dersler
WHERE sira = 1;

-- Soru 4.3
WITH aylik_kayitlar AS (
    SELECT 
        EXTRACT(MONTH FROM tarih)::int AS ay,
        COUNT(*) AS kayit_sayisi
    FROM kayitlar
    GROUP BY EXTRACT(MONTH FROM tarih)::int
)
SELECT 
    ay,
    kayit_sayisi,
    kayit_sayisi - LAG(kayit_sayisi) OVER (ORDER BY ay) AS fark
FROM aylik_kayitlar
ORDER BY ay;