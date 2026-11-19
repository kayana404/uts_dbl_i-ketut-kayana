-- 1a--

CREATE DATABASE uts_dbl_2501010112;
USE uts_dbl_2501010112;

-- 1b--

CREATE TABLE destinasi (
    id_destinasi CHAR(4) PRIMARY KEY,
    nama_destinasi VARCHAR(50) NOT NULL,
    kabupaten VARCHAR(30) NOT NULL,
    harga_tiket INT NOT NULL
);

CREATE TABLE paket_tur (
    id_paket CHAR(4) PRIMARY KEY,
    nama_paket VARCHAR(50) NOT NULL UNIQUE,
    id_destinasi CHAR(4) NOT NULL,
    harga INT NOT NULL,
    durasi_jam INT NULL,
    FOREIGN KEY (id_destinasi) REFERENCES destinasi (id_destinasi)
);

CREATE TABLE wisatawan (
    id_wisatawan CHAR(5) PRIMARY KEY,
    nama VARCHAR(50) NOT NULL,
    asal_negara VARCHAR(30) NOT NULL,
    email VARCHAR(50) UNIQUE
);

CREATE TABLE pemesanan (
    id_pesan INT PRIMARY KEY,
    id_wisatawan CHAR(5) NOT NULL,
    id_paket CHAR(4) NOT NULL,
    tgl_tur DATE NOT NULL,
    jumlah_orang INT NOT NULL,
    STATUS VARCHAR(10) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (id_wisatawan) 
    REFERENCES wisatawan (id_wisatawan),
    FOREIGN KEY (id_paket) 
    REFERENCES paket_tur (id_paket)
);


-- 1c--

ALTER TABLE destinasi 
ADD COLUMN rating DECIMAL(2,1);


-- 2a--

INSERT INTO destinasi (id_destinasi, nama_destinasi, kabupaten, harga_tiket) 
VALUES ('D001','Tanah Lot','Tabanan',30000),
('D002','Ulun Danu Beratan','Tabanan',50000),
('D003','Tirta Empul','Gianyar',50000),
('D004','Goa Gajah','Gianyar',50000),
('D005','Desa Penglipuran','Bangli',25000),
('D006','Pura Besakih','Karangasem',60000),
('D007','Jatiluwih','Tabanan',50000);

INSERT INTO paket_tur (id_paket, nama_paket, id_destinasi, harga, durasi_jam) 
VALUES ('P001','Sunset Tanah Lot','D001',350000,5),
('P002','Bedugul Lake Tour','D002',450000,8),
('P003','Ubud Water Temple','D003',400000,6),
('P004','Ubud Heritage Walk','D004',300000,4),
('P005','Penglipuran Culture Trip','D005',375000,6),
('P006','Besakih Spiritual Journey','D006',500000,8),
('P007','Tanah Lot Photo Tour','D001',250000,3);

INSERT INTO wisatawan (id_wisatawan, nama, asal_negara, email) 
VALUES ('W0001','Made Ayu','Indonesia', 'made.ayu@mail.com'),
('W0002','John Smith','Australia','john.s@mail.com'),
('W0003','Sarah Lee','Singapura','sarah.lee@mail.com'),
('W0004','Kenji Tanaka','Jepang','kenji.t@mail.com'),
('W0005','Putu Arya','Indonesia','putu.arya@mail.com'),
('W0006','Emma Brown','Australia','emma.b@mail.com'),
('W0007','Li Wei','Tiongkok','li.wei@mail.com'),
('W0008','Komang Sari','Indonesia','komang.s@mail.com');

INSERT INTO pemesanan (id_pesan, id_wisatawan, id_paket, tgl_tur, jumlah_orang, STATUS) 
VALUES (1,'W0001','P001','2026-09-05',2,'Lunas'),
(2,'W0002','P003','2026-09-12',4,'Lunas'),
(3,'W0003','P002','2026-09-20',2,'Batal'),
(4,'W0004','P004','2026-10-02',3,'Lunas'),
(5,'W0002','P001','2026-10-03',4,'Lunas'),
(6,'W0005','P005','2026-10-10',5,'Lunas'),
(7,'W0006','P003','2026-10-15',2,'Pending'),
(8,'W0004','P002','2026-10-18',1,'Lunas'),
(9,'W0007','P007','2026-10-25',3,'Lunas'),
(10, 'W0001','P004','2026-11-01',2,'Lunas'),
(11,'W0006','P001','2026-11-07',6,'Lunas'),
(12,'W0003','P005','2026-11-09',2,'Pending');

SELECT*FROM destinasi;
SELECT*FROM paket_tur;
SELECT*FROM wisatawan;
SELECT*FROM pemesanan;

-- 2b--

UPDATE destinasi 
SET harga_tiket = 30000 
WHERE id_destinasi = 'D005';

-- 2c--

UPDATE pemesanan 
SET STATUS = 'Lunas' 
WHERE id_pesan = 12;

-- 2d--

DELETE FROM pemesanan
WHERE STATUS = 'Batal';

-- 2e--

INSERT INTO wisatawan (id_wisatawan, nama, asal_negara, email)
VALUES ('W0009','Anna Schmidt', 'Jerman','anna.s@mail.com');

-- 2f--

INSERT INTO wisatawan VALUES
  ('W0010','Budi Santoso','Indonesia','made.ayu@mail.com');
  #1062 - Duplicate entry 'made.ayu@mail.com' for key 'email'
karena adanya  duplikat DATA pada email


-- 3a--

SELECT nama_paket, harga
FROM paket_tur
WHERE harga BETWEEN 300000 AND 450000;

-- 3b--

SELECT id_wisatawan, nama
FROM wisatawan
WHERE nama LIKE '%an%';

-- 3c--

SELECT id_pesan, id_wisatawan, jumlah_orang
FROM pemesanan
ORDER BY jumlah_orang DESC, id_pesan ASC
LIMIT 3;

-- 3d--

SELECT id_pesan, tgl_tur, STATUS
FROM pemesanan
WHERE STATUS = 'Lunas'
AND MONTH(tgl_tur) = 10
AND YEAR(tgl_tur) = 2026
ORDER BY tgl_tur ASC;

-- 4a--

SELECT wisatawan.nama, paket_tur.nama_paket, pemesanan.tgl_tur
FROM pemesanan 
INNER JOIN wisatawan ON pemesanan.id_wisatawan = wisatawan.id_wisatawan
INNER JOIN paket_tur  ON pemesanan.id_paket = paket_tur.id_paket
WHERE pemesanan.status = 'Lunas'
ORDER BY pemesanan.tgl_tur ASC;

-- 4b--

SELECT paket_tur.nama_paket, destinasi.nama_destinasi,destinasi.kabupaten
FROM paket_tur 
INNER JOIN destinasi ON paket_tur.id_destinasi = destinasi.id_destinasi
WHERE destinasi.kabupaten = 'Gianyar'
ORDER BY paket_tur.nama_paket ASC;

-- 4c--

SELECT wisatawan.id_wisatawan, wisatawan.nama
FROM wisatawan 
LEFT JOIN pemesanan  ON wisatawan.id_wisatawan = pemesanan.id_wisatawan
WHERE pemesanan.id_pesan IS NULL
ORDER BY wisatawan.id_wisatawan ASC;

-- 4d--

SELECT paket_tur.id_paket, paket_tur.nama_paket
FROM pemesanan 
RIGHT JOIN paket_tur  ON pemesanan.id_paket = paket_tur.id_paket
WHERE pemesanan.id_pesan IS NULL;

-- 5a--

SELECT STATUS,
COUNT(*) AS jumlah_pesanan,
SUM(jumlah_orang) AS total_peserta
FROM pemesanan
GROUP BY STATUS
ORDER BY STATUS ASC;

-- 5b--
SELECT paket_tur.nama_paket,
SUM(paket_tur.harga * pemesanan.jumlah_orang) AS pendapatan
FROM pemesanan 
INNER JOIN paket_tur  ON pemesanan.id_paket = paket_tur.id_paket
WHERE pemesanan.status = 'Lunas'
GROUP BY paket_tur.id_paket, paket_tur.nama_paket
ORDER BY pendapatan DESC;

-- 5c--
SELECT asal_negara, 
COUNT(*) AS jumlah_wisatawan
FROM wisatawan
GROUP BY asal_negara
ORDER BY jumlah_wisatawan DESC, asal_negara ASC;

-- 5d--
SELECT kabupaten,
ROUND(AVG(harga_tiket), 2) AS rata_rata,
MAX(harga_tiket) AS tertinggi,
MIN(harga_tiket) AS terendah
FROM destinasi
GROUP BY kabupaten
ORDER BY rata_rata DESC;

-- 5e--
SELECT wisatawan.nama, SUM(pemesanan.jumlah_orang) AS total_peserta
FROM pemesanan 
INNER JOIN wisatawan ON pemesanan.id_wisatawan = wisatawan.id_wisatawan
WHERE pemesanan.status = 'Lunas'
GROUP BY wisatawan.id_wisatawan, wisatawan.nama
ORDER BY total_peserta DESC
LIMIT 3;