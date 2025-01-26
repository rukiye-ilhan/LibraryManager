SELECT * FROM Uyeler
SELECT * FROM Yazarlar
SELECT * FROM Kitaplar
SELECT * FROM KitapTurleri
SELECT * FROM OduncAlma
SELECT * FROM Adresler
--Türlerine göre kitap sayısı
SELECT K.Yazar, COUNT(K.TurId) as Türdeki_Kitap_Sayıları FROM Kitaplar K 
JOIN KitapTurleri KT ON K.TurId=KT.TurId
GROUP BY Yazar
ORDER BY 1 DESC

SELECT KT.TurAdi, K.Ad, K.Yazar
FROM Kitaplar K
JOIN KitapTurleri KT ON K.TurId = KT.TurId
GROUP BY KT.TurAdi, K.Ad, K.Yazar;


SELECT * FROM Yazarlar
SELECT * FROM Kitaplar
SELECT * FROM Uyeler
SELECT * FROM OduncAlma
SELECT * FROM KitapTurleri

SELECT * FROM Adresler
--Her  üyenin aldığı kitap sayısını ve türlere göre dağılımını listeleyin
SELECT U.Ad, U.Soyad, TurAdi, COUNT(K.Ad) Uyenin_aldığı_kitap_sayısı FROM Uyeler U 
JOIN OduncAlma OA ON U.UyeId=OA.UyeId
JOIN Kitaplar K ON K.KitapId=OA.KitapId
JOIN KitapTurleri KT ON KT.TurId=K.TurId
GROUP BY TurAdi, U.Ad,U.Soyad 
--Teslim tarihi geçmiş olan kitapları listeleme
SELECT U.Ad +' ' +U.Soyad AS UyeAdSoyad,
K.Ad AS KitapAdı,
OA.TeslimTarihi,
DATEDIFF(DAY,OA.TeslimTarihi,GETDATE()) AS GecikmeSüresi
FROM OduncAlma OA 
JOIN Uyeler U ON U.UyeId=OA.UyeId
JOIN Kitaplar K ON K.KitapId=OA.KitapId
WHERE OA.Durum=0 AND OA.TeslimTarihi < GETDATE()
ORDER BY GecikmeSüresi DESC
--Bunlar kitapları teslim etmişler ancak geç teslim etmişler  yukardaki sorguda ise hala teslim etmemişler
SELECT U.Ad +' ' +U.Soyad AS UyeAdSoyad,
K.Ad AS KitapAdı,
OA.TeslimTarihi,
DATEDIFF(DAY,OduncTarihi, OA.TeslimTarihi) AS GecikmeSüresi
FROM OduncAlma OA 
JOIN Uyeler U ON U.UyeId=OA.UyeId
JOIN Kitaplar K ON K.KitapId=OA.KitapId
WHERE OA.Durum=1 AND DATEDIFF(DAY,OduncTarihi, OA.TeslimTarihi) >= 15
ORDER BY GecikmeSüresi DESC
--En çok kitap alan üye 
SELECT TOP 1
U.Ad+ ' ' + U.Soyad AS UyeAdSoyad,
COUNT(OA.OduncId) AS AlınanKitapSayısı
FROM Uyeler U 
JOIN OduncAlma OA ON U.UyeId=OA.UyeId
GROUP BY U.Ad, U.Soyad 
ORDER BY AlınanKitapSayısı,1 ASC

SELECT 
    MAX(AlinanKitapSayisi) AS MaxKitapSayisi,
    MIN(AlinanKitapSayisi) AS MinKitapSayisi,
    AVG(AlinanKitapSayisi * 1.0) AS AvgKitapSayisi
FROM (
    SELECT 
        U.UyeId,
        COUNT(OA.OduncId) AS AlinanKitapSayisi
    FROM Uyeler U
    LEFT JOIN OduncAlma OA ON U.UyeId = OA.UyeId
    GROUP BY U.UyeId
) AS KitapIst;

--COUNT fonksiyonu, her üyenin OduncAlma tablosundaki ödünç işlem sayısını toplar.
--Her üyenin ödünç alma işlemleri arasındaki en yüksek OduncId değerini gösterir.
SELECT 
U.Ad+ ' ' + U.Soyad AS UyeAdSoyad,
COUNT(OA.OduncId) AS AlınanKitapSayısı,
MAX(OA.OduncId) AS MaxKitapSayısı,
MIN(OA.OduncId) AS MinkitapSayısı,
AVG(OA.OduncId) AS AvgKitapSayısı
FROM Uyeler U 
JOIN OduncAlma OA ON U.UyeId=OA.UyeId
GROUP BY U.Ad, U.Soyad 
ORDER BY 1,AlınanKitapSayısı DESC

--Kitap türlerine göre toplam gecikme sürelerini listeleyin
SELECT TurAdi,
SUM(DATEDIFF(DAY, OA.TeslimTarihi, GETDATE())) AS ToplamGecikmeSuresi
FROM Uyeler U 
JOIN OduncAlma OA ON U.UyeId=OA.UyeId
JOIN Kitaplar K ON K.KitapId=OA.KitapId
JOIN KitapTurleri KT ON KT.TurId=K.TurId
WHERE 
 OA.Durum = 0 AND OA.TeslimTarihi < GETDATE()
GROUP BY TurAdi

--Her üyenin Ortalama Teslim Süresi
SELECT 
    *
	
	FROM 
    OduncAlma o
JOIN 
    Uyeler u ON o.UyeId = u.UyeId
WHERE 
    o.Durum = 1 -- Teslim edilmiş kitaplar
GROUP BY 
    u.Ad, u.Soyad

	SELECT 
    u.Ad + ' ' + u.Soyad AS UyeAdSoyad,
    AVG(DATEDIFF(DAY, o.OduncTarihi, o.TeslimTarihi)) AS OrtalamaTeslimSuresi
FROM 
    OduncAlma o
JOIN 
    Uyeler u ON o.UyeId = u.UyeId
WHERE 
    o.Durum = 1 -- Teslim edilmiş kitaplar
GROUP BY 
    u.Ad, u.Soyad
ORDER BY 
    OrtalamaTeslimSuresi;

--Her yazarın yazdığı kitap sayısı 
SELECT Y.Ad,Y.Soyad, COUNT(*) AS YazdığıKitapSayısı FROM 
Yazarlar Y 
JOIN Kitaplar K ON Y.YazarId=K.YazarId
GROUP BY Y.Ad, Y.Soyad
ORDER BY YazdığıKitapSayısı DESC
--Kitapların basım yıllara göre dağılımı 
SELECT BasimYili, COUNT(*) AS BasılanKitapSayısı FROM 
Kitaplar K
GROUP BY BasimYili
ORDER BY BasimYili DESC
--Adres tablosunu kullanarak hangi şehirde en çok kitap alan üye bulunduğunu bulan sorgu
SELECT  Sehir,
COUNT(OA.OduncId) AS ToplamKitapSayısı
FROM OduncAlma OA
JOIN Adresler A ON OA.UyeId=A.UyeId
GROUP BY Sehir
ORDER BY 1 DESC,ToplamKitapSayısı DESC

--Hangi üyelerin hangi yazarların kitaplarını okuduğunu listeleme
SELECT 
U.Ad + ' ' + U.Soyad AS UyeAdSoyad,
Y.Ad + ' ' + Y.Soyad AS YazarAdSoyad,
COUNT(OA.OduncId) AS AlinanKitapSayisi 
FROM Uyeler U 
JOIN OduncAlma OA ON U.UyeId=OA.UyeId
JOIN Kitaplar K ON OA.KitapId=K.KitapId
JOIN Yazarlar Y ON K.YazarId=Y.YazarId
GROUP BY U.Ad,U.Soyad,Y.Ad,Y.Soyad
ORDER BY 
AlinanKitapSayisi DESC ,UyeAdSoyad DESC ;