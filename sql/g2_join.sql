-- Soru 2.1
SELECT u.ad, d.ad, k.tarih
FROM kayitlar k
JOIN uyeler u ON k.uye_id = u.uye_id
JOIN dersler d ON k.ders_id = d.ders_id;

-- Soru 2.2
SELECT d.ad, e.ad, s.ad
FROM dersler d
JOIN egitmenler e ON d.egitmen_id = e.egitmen_id
JOIN salonlar s ON d.salon_id = s.salon_id;

-- Soru 2.3
SELECT u.ad
FROM uyeler u
LEFT JOIN kayitlar k ON u.uye_id = k.uye_id
WHERE k.kayit_id IS NULL;

-- Soru 2.4
SELECT e.ad, COUNT(k.kayit_id) AS kayit_sayisi
FROM egitmenler e
JOIN dersler d ON e.egitmen_id = d.egitmen_id
JOIN kayitlar k ON d.ders_id = k.ders_id
GROUP BY e.egitmen_id, e.ad
ORDER BY kayit_sayisi DESC;