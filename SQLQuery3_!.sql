USE library_DB_app

CREATE TABLE KitapTurleri (
    TurId INT PRIMARY KEY IDENTITY(1,1),
    TurAdi NVARCHAR(100) NOT NULL
);

CREATE TABLE Kitaplar (
    KitapId INT PRIMARY KEY IDENTITY(1,1),
    Ad NVARCHAR(200) NOT NULL,
    Yazar NVARCHAR(100) NOT NULL,
    BasimYili INT,
    ISBN NVARCHAR(20),
    TurId INT,
    FOREIGN KEY (TurId) REFERENCES KitapTurleri(TurId)
);
ALTER TABLE Kitaplar
ADD YazarId INT;


CREATE TABLE Uyeler (
    UyeId INT PRIMARY KEY IDENTITY(1,1),
    Ad NVARCHAR(100) NOT NULL,
    Soyad NVARCHAR(100) NOT NULL,
    Telefon NVARCHAR(15),
    Email NVARCHAR(100)
);
ALTER TABLE Uyeler
ADD Cinsiyet NVARCHAR(10) CHECK (Cinsiyet IN ('Erkek', 'Kadın', 'Diğer'));
ALTER TABLE Uyeler
ADD Birthdate DATE;


CREATE TABLE OduncAlma (
    OduncId INT PRIMARY KEY IDENTITY(1,1),
    KitapId INT NOT NULL,
    UyeId INT NOT NULL,
    OduncTarihi DATE NOT NULL,
    TeslimTarihi DATE NOT NULL,
    Durum BIT NOT NULL DEFAULT 0,
    FOREIGN KEY (KitapId) REFERENCES Kitaplar(KitapId),
    FOREIGN KEY (UyeId) REFERENCES Uyeler(UyeId)
);

CREATE TABLE Adresler (
    AdresId INT PRIMARY KEY IDENTITY(1,1),
    UyeId INT NOT NULL, -- Uyeler tablosuyla ilişki
    Adres NVARCHAR(255) NOT NULL, -- Adres bilgisi
    Sehir NVARCHAR(100) NOT NULL, -- Şehir bilgisi
    PostaKodu NVARCHAR(20), -- Posta kodu
    FOREIGN KEY (UyeId) REFERENCES Uyeler(UyeId) -- Uyeler tablosuyla ilişkilendirildi
);

CREATE TABLE Yazarlar (
    YazarId INT PRIMARY KEY IDENTITY(1,1),
    Ad NVARCHAR(100) NOT NULL,
    Soyad NVARCHAR(100) NOT NULL,
    DogumTarihi DATE,
    Ulke NVARCHAR(100),
    Bio NVARCHAR(MAX)
);
ALTER TABLE Kitaplar
ADD CONSTRAINT FK_Kitaplar_Yazarlar
FOREIGN KEY (YazarId) REFERENCES Yazarlar(YazarId);

INSERT INTO Uyeler (Ad, Soyad, Telefon, Email, Cinsiyet, Birthdate) VALUES
('Ali', 'Yılmaz', '05321234567', 'ali@gmail.com', 'Erkek', '1990-01-15'),
('Ayşe', 'Demir', '05334567890', 'ayse@gmail.com', 'Kadın', '1985-05-10'),
('Mehmet', 'Çelik', '05431234567', 'mehmet@gmail.com', 'Erkek', '1988-09-25'),
('Fatma', 'Şahin', '05534567890', 'fatma@gmail.com', 'Kadın', '1992-03-14'),
('Ahmet', 'Kaya', '05321238945', 'ahmet@gmail.com', 'Erkek', '1995-11-20'),
('Zeynep', 'Arslan', '05321345678', 'zeynep@gmail.com', 'Kadın', '1999-08-07'),
('Hasan', 'Kurt', '05324567891', 'hasan@gmail.com', 'Erkek', '1984-07-12'),
('Elif', 'Polat', '05531234569', 'elif@gmail.com', 'Kadın', '1997-06-18'),
('Emre', 'Öz', '05437894561', 'emre@gmail.com', 'Erkek', '1983-02-02'),
('Melike', 'Yıldız', '05324321567', 'melike@gmail.com', 'Kadın', '1996-12-22'),
('Kerem', 'Ekinci', '05325678912', 'kerem@gmail.com', 'Erkek', '1993-04-17'),
('Gamze', 'Koç', '05524357812', 'gamze@gmail.com', 'Kadın', '1998-10-05'),
('Burak', 'Güler', '05328765432', 'burak@gmail.com', 'Erkek', '1994-09-03'),
('Merve', 'Aksoy', '05329984561', 'merve@gmail.com', 'Kadın', '1991-01-09'),
('Hakan', 'Şimşek', '05431237891', 'hakan@gmail.com', 'Erkek', '1987-05-25'),
('Derya', 'Taş', '05529984321', 'derya@gmail.com', 'Kadın', '1995-07-13'),
('Eren', 'Acar', '05327895641', 'eren@gmail.com', 'Erkek', '1982-11-11'),
('Büşra', 'Kılıç', '05329985674', 'busra@gmail.com', 'Kadın', '1993-06-06'),
('Cem', 'Aslan', '05431238976', 'cem@gmail.com', 'Erkek', '1986-03-29'),
('Selin', 'Ersoy', '05534567821', 'selin@gmail.com', 'Kadın', '2000-12-30');


INSERT INTO Yazarlar (Ad, Soyad, DogumTarihi, Ulke, Bio) VALUES
('Orhan', 'Pamuk', '1952-06-07', 'Türkiye', 'Nobel ödüllü Türk yazar.'),
('Elif', 'Şafak', '1971-10-25', 'Türkiye', 'Uluslararası tanınmış kadın yazar.'),
('Sabahattin', 'Ali', '1907-02-25', 'Türkiye', 'Edebiyatın önemli isimlerinden biri.'),
('Ahmet', 'Ümit', '1960-09-30', 'Türkiye', 'Polisiye türünde ünlü yazar.'),
('Fyodor', 'Dostoyevski', '1821-11-11', 'Rusya', 'Dünya edebiyatının en büyük yazarlarından.'),
('Victor', 'Hugo', '1802-02-26', 'Fransa', 'Les Misérables yazarı.'),
('Haruki', 'Murakami', '1949-01-12', 'Japonya', 'Çağdaş edebiyatın önemli ismi.'),
('Gabriel', 'García Márquez', '1927-03-06', 'Kolombiya', 'Yüzyıllık Yalnızlık yazarı.'),
('Franz', 'Kafka', '1883-07-03', 'Çekya', 'Dava gibi eserlerin yazarı.'),
('Jane', 'Austen', '1775-12-16', 'İngiltere', 'Gurur ve Önyargı yazarı.');


INSERT INTO Yazarlar (Ad, Soyad, DogumTarihi, Ulke, Bio) VALUES
('J.K.', 'Rowling', '1965-07-31', 'İngiltere', 'Harry Potter serisinin yazarı.'),
('George', 'Orwell', '1903-06-25', 'İngiltere', '1984 ve Hayvan Çiftliği gibi eserlerin yazarı.'),
('Agatha', 'Christie', '1890-09-15', 'İngiltere', 'Polisiye roman türünün kraliçesi.'),
('Stephen', 'King', '1947-09-21', 'ABD', 'Korku ve gerilim türünde önemli bir yazar.');

-- Tarih ve Felsefe türünde yazarlara ekleme
INSERT INTO Yazarlar (Ad, Soyad, DogumTarihi, Ulke, Bio) VALUES
('Yuval Noah', 'Harari', '1976-02-24', 'İsrail', 'Tarih ve insanlık üzerine popüler eserler yazarı.'),
('Will', 'Durant', '1885-11-05', 'ABD', 'Felsefe ve tarih üzerine önemli eserler yazmış bir yazar.'),
('Bertrand', 'Russell', '1872-05-18', 'İngiltere', 'Felsefe, mantık ve matematikte önemli bir düşünür.'),
('Edward', 'Gibbon', '1737-05-08', 'İngiltere', 'Roma İmparatorluğu tarihine dair önemli eserler yazarı.');


INSERT INTO KitapTurleri (TurAdi) VALUES
('Roman'), ('Polisiye'), ('Bilim Kurgu'), ('Tarih'), ('Felsefe');

INSERT INTO Kitaplar (Ad, Yazar, BasimYili, ISBN, TurId, YazarId) VALUES
('Kırmızı Saçlı Kadın', 'Orhan Pamuk', 2016, '9789750836113', 1, 1),
('Aşk', 'Elif Şafak', 2009, '9786051111076', 1, 2),
('Kürk Mantolu Madonna', 'Sabahattin Ali', 1943, '9786053600615', 1, 3),
('Beyoğlu Rapsodisi', 'Ahmet Ümit', 2003, '9789751410885', 2, 4),
('Suç ve Ceza', 'Fyodor Dostoyevski', 1866, '9786053608598', 1, 5),
('Sefiller', 'Victor Hugo', 1862, '9786052990533', 1, 6),
('1Q84', 'Haruki Murakami', 2009, '9786053603593', 3, 7),
('Yüzyıllık Yalnızlık', 'Gabriel García Márquez', 1967, '9789750812200', 1, 8),
('Dava', 'Franz Kafka', 1925, '9786053609618', 1, 9),
('Gurur ve Önyargı', 'Jane Austen', 1813, '9786053606242', 1, 10);

-- Tarih ve Felsefe türünde kitaplara ekleme
INSERT INTO Kitaplar (Ad, Yazar, BasimYili, ISBN, TurId, YazarId) VALUES
('Sapiens: İnsan Türünün Kısa Bir Tarihi', 'Yuval Noah Harari', 2011, 9780062316097, 4, 15),
('Tarihin Akışı', 'Will Durant', 1935, 9780671027032, 4, 16),
('Batı Felsefesinin Tarihi', 'Bertrand Russell', 1945, 9780671201586, 5, 17),
('Roma İmparatorluğu\nun Gerileyiş ve Çöküş Tarihi', 'Edward Gibbon', 1776, 9780140437645, 4, 18);

INSERT INTO Kitaplar ( Ad, Yazar, BasimYili, ISBN, TurId, YazarId) VALUES
('Kar', 'Orhan Pamuk', 2002, 9789750809999, 1, 1),
('Yeni Hayat', 'Orhan Pamuk', 1994, 9789750803058, 1, 1),
('Masumiyet Müzesi', 'Orhan Pamuk', 2008, 9789750812340, 1, 1);

INSERT INTO Kitaplar (Ad, Yazar, BasimYili, ISBN, TurId, YazarId) VALUES
('İçimizdeki Şeytan', 'Sabahattin Ali', 1940, 9786053600154, 1, 3),
('Değirmen', 'Sabahattin Ali', 1935, 9786053600201, 1, 3);

INSERT INTO Kitaplar ( Ad, Yazar, BasimYili, ISBN, TurId, YazarId) VALUES
('Karamazov Kardeşler', 'Fyodor Dostoyevski', 1880, 9786053600991, 1, 5),
('Budala', 'Fyodor Dostoyevski', 1869, 9786053601028, 1, 5),
('Yeraltından Notlar', 'Fyodor Dostoyevski', 1864, 9786053601203, 1, 5);

INSERT INTO Kitaplar ( Ad, Yazar, BasimYili, ISBN, TurId, YazarId) VALUES
('Notre Dame’ın Kamburu', 'Victor Hugo', 1831, 9786053602001, 1, 6),
('Bir İdam Mahkûmunun Son Günü', 'Victor Hugo', 1829, 9786053603002, 1, 6);

INSERT INTO Kitaplar (Ad, Yazar, BasimYili, ISBN, TurId, YazarId) VALUES
('Harry Potter ve Felsefe Taşı', 'J.K. Rowling', 1997, 9789750801002, 2, 11),
('Harry Potter ve Sırlar Odası', 'J.K. Rowling', 1998, 9789750802003, 2, 11),
('Harry Potter ve Azkaban Tutsağı', 'J.K. Rowling', 1999, 9789750803004, 2, 11);

INSERT INTO Kitaplar (Ad, Yazar, BasimYili, ISBN, TurId, YazarId) VALUES
( 'On Küçük Zenci', 'Agatha Christie', 1939, 9786053604001, 3, 12),
('Doğu Ekspresinde Cinayet', 'Agatha Christie', 1934, 9786053604002, 3, 12);


INSERT INTO Adresler (UyeId, Adres, Sehir, PostaKodu) VALUES
(1, 'Atatürk Mah. No:45', 'İstanbul', '34000'),
(1, 'Erenköy Mah. No:12', 'İstanbul', '34700'),
(2, 'Barbaros Mah. No:78', 'Ankara', '06000'),
(3, 'Çarşı Cad. No:89', 'İzmir', '35000'),
(4, 'Yenişehir Mah. No:14', 'Bursa', '16000'),
(4, 'Nilüfer Sok. No:23', 'Bursa', '16100'),
(5, 'Kocatepe Sok. No:7', 'Adana', '01000'),
(6, 'Bağlar Cad. No:33', 'Antalya', '07000'),
(7, 'Cumhuriyet Mah. No:10', 'Eskişehir', '26000'),
(8, 'Şehitler Cad. No:2', 'Gaziantep', '27000'),
(9, 'Kurtuluş Sok. No:5', 'Samsun', '55000'),
(10, 'Güzelyurt Cad. No:17', 'Trabzon', '61000'),
(10, 'Çarşı Mah. No:6', 'Trabzon', '61100'),
(11, 'Hürriyet Cad. No:11', 'Mersin', '33000'),
(12, 'Deniz Sok. No:8', 'Muğla', '48000'),
(13, 'Yıldız Mah. No:19', 'Hatay', '31000'),
(13, 'Güneş Cad. No:22', 'Hatay', '31100'),
(14, 'Zafer Sok. No:9', 'Konya', '42000'),
(15, 'İstiklal Cad. No:3', 'Malatya', '44000'),
(16, 'Bahar Mah. No:7', 'Kocaeli', '41000'),
(17, 'Çimen Sok. No:15', 'Aydın', '09000'),
(18, 'Orman Cad. No:10', 'Edirne', '22000'),
(19, 'Demokrasi Sok. No:20', 'Manisa', '45000'),
(20, 'Lale Cad. No:12', 'Tekirdağ', '59000'),
(20, 'Papatya Sok. No:14', 'Tekirdağ', '59100');

-- UyeId Foreign Key kısıtlamasını kaldır
ALTER TABLE OduncAlma
DROP CONSTRAINT FK_OduncAlma_UyeId;

-- KitapId Foreign Key kısıtlamasını kaldır
ALTER TABLE OduncAlma
DROP CONSTRAINT FK_OduncAlma_KitapId;
DELETE FROM OduncAlma;

INSERT INTO OduncAlma (KitapId, UyeId, OduncTarihi, TeslimTarihi, Durum) VALUES
-- Üye 1: Ali Yılmaz (Roman türünden ve farklı yazarlardan kitap aldı)
(13, 1, '2023-12-25', '2024-01-10', 1),
(3, 1, '2023-12-01', '2023-12-15', 1),

-- Üye 2: Ayşe Demir (Tarih ve Polisiye türlerinden kitap aldı)
(26, 2, '2023-12-05', '2023-12-20', 1),
(4, 2, '2023-12-15', '2023-12-30', 0),

-- Üye 3: Mehmet Çelik (Klasik ve Suç türlerinden kitap aldı)
(17, 3, '2023-12-10', '2023-12-25', 1),
(8, 3, '2023-12-12', '2023-12-26', 1),

-- Üye 4: Fatma Şahin (Felsefe ve Dünya Edebiyatı kitapları aldı)
(27, 4, '2023-12-01', '2023-12-15', 1),
(7, 4, '2023-11-20', '2023-12-10', 1),

-- Üye 5: Ahmet Kaya (Agatha Christie ve Victor Hugo kitapları aldı)
(25, 5, '2023-12-15', '2023-12-30', 0),
(19, 5, '2023-12-10', '2023-12-25', 1),

-- Üye 6: Zeynep Arslan (Farklı yazar ve türlerden kitaplar aldı)
(21, 6, '2023-12-12', '2023-12-26', 1),
(9, 6, '2023-11-15', '2023-11-30', 1),

-- Üye 7: Hasan Kurt (Roman türünden birden fazla kitap aldı)
(5, 7, '2023-12-01', '2023-12-15', 0),
(15, 7, '2023-12-05', '2023-12-20', 0),

-- Üye 8: Elif Polat (Tarih ve Dünya Edebiyatı türlerinden kitaplar aldı)
(29, 8, '2023-12-10', '2023-12-25', 1),
(6, 8, '2023-12-01', '2023-12-15', 0),

-- Üye 9: Emre Öz (Suç ve Polisiye türünden kitaplar aldı)
(22, 9, '2023-12-20', '2024-01-05', 1),
(14, 9, '2023-12-05', '2023-12-20', 0),

-- Üye 10: Melike Yıldız (Roman türünden kitaplar aldı)
(11, 10, '2023-12-15', '2023-12-30', 0),
(12, 10, '2023-12-10', '2023-12-20', 1),

-- Üye 11: Kerem Ekinci (Dünya Edebiyatı ve Suç kitapları aldı)
(16, 11, '2023-12-01', '2023-12-15', 1),
(23, 11, '2023-12-12', '2023-12-26', 1),

-- Üye 12: Gamze Koç (Polisiye ve Roman türlerinden kitaplar aldı)
(24, 12, '2023-12-05', '2023-12-20', 1),
(3, 12, '2023-11-25', '2023-12-15', 1),

-- Üye 13: Burak Güler (Roman ve Felsefe türlerinden kitaplar aldı)
(20, 13, '2023-12-01', '2023-12-15', 1),
(28, 13, '2023-12-12', '2023-12-26', 1),

-- Üye 14: Merve Aksoy (Dünya Edebiyatı ve Suç kitapları aldı)
(6, 14, '2023-11-10', '2023-11-25', 0),
(25, 14, '2023-12-05', '2023-12-20', 0),

-- Üye 15: Hakan Şimşek (Farklı yazar ve türlerden kitaplar aldı)
(1, 15, '2023-12-15', '2023-12-30', 1),
(14, 15, '2023-12-01', '2023-12-15', 1),

-- Üye 16: Derya Taş (Dünya Edebiyatı türünden kitap aldı)
(7, 16, '2023-12-05', '2023-12-20', 0),

-- Üye 17: Eren Acar (Roman ve Felsefe türlerinden kitaplar aldı)
(18, 17, '2023-12-10', '2023-12-25', 1),
(27, 17, '2023-12-15', '2023-12-30', 1),

-- Üye 18: Büşra Kılıç (Dünya Edebiyatı ve Polisiye türlerinden kitaplar aldı)
(8, 18, '2023-11-01', '2023-11-16', 1),
(24, 18, '2023-12-01', '2023-12-15', 0),

-- Üye 19: Cem Aslan (Roman ve Suç türünden kitaplar aldı)
(15, 19, '2023-12-10', '2023-12-25', 1),
(9, 19, '2023-11-20', '2023-12-10', 0),

-- Üye 20: Selin Ersoy (Tarih ve Roman türlerinden kitaplar aldı)
(26, 20, '2023-12-15', '2023-12-30', 1),
(2, 20, '2023-12-10', '2023-12-25', 1);


ALTER TABLE OduncAlma
ADD CONSTRAINT FK_OduncAlma_UyeId
FOREIGN KEY (UyeId) REFERENCES Uyeler(UyeId);

ALTER TABLE OduncAlma
ADD CONSTRAINT FK_OduncAlma_KitapId
FOREIGN KEY (KitapId) REFERENCES Kitaplar(KitapId);
