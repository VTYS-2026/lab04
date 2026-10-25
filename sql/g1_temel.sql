-- Soru 1.1
SELECT ad, dogum_yili
FROM uyeler
WHERE dogum_yili >= 2000;

-- Soru 1.2
SELECT MIN(ucret) AS en_dusuk, MAX(ucret) AS en_yuksek, SUM(ucret) AS toplam
FROM dersler;

-- Soru 1.3
SELECT brans, COUNT(*) AS egitmen_sayisi
FROM egitmenler
GROUP BY brans
ORDER BY egitmen_sayisi DESC;

-- Soru 1.4
SELECT s.ad, COUNT(*) AS ders_sayisi
FROM salonlar s
JOIN dersler d ON s.salon_id = d.salon_id
GROUP BY s.salon_id, s.ad
HAVING COUNT(*) > 3;