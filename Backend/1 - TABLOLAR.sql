
use dergi
------------------------------------------ DATABASE and TABLES

Create table Kullanicilar(
	id int identity(1,1) Primary Key,
	kullanici_ad nvarchar(20) unique,
	kullanici_sifre nvarchar(20),
	isim nvarchar(30),
	soyisim nvarchar(30),
	adres text,
	e_posta nvarchar(50) unique
	constraint ck_e_posta
	check (e_posta like ('%_@%_.%_')),
	tel char(14) unique
	constraint ck_tel 
	check (tel like ( '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')),
	tc char(11) unique
	constraint ck_tc 
	check (tc like ( '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
)
Create table Dergi(
	id int identity(1,1) Primary Key,
	ad nvarchar(30) unique,
	fiyat float,
	periyot_gun int,
	baslangic_tarih date default GETDATE(),
	max_taahut int constraint ck_max_tarih check(max_taahut>=0)
) 

Create Table Dergi_Sayisi(
	dergi_id int foreign key references Dergi (id),
	dergi_sayi int,
	tarih date,
	link nvarchar(50),

	unique(dergi_id,dergi_sayi),
	unique(dergi_id,tarih),
	unique(dergi_id,link)
)

Create Table Dergi_Sayisi_Yedek( -- YEDEK
	dergi_id int,
	dergi_sayi int,
	tarih date,
	link nvarchar(50)
)

Create Table Abonelik(
	id int identity(1,1) Primary Key,
	kullanici_id int foreign key references Kullanicilar(id),
	dergi_id int foreign key references Dergi(id),
	baslangic_tarih date,
	taahut_gun int,

	unique(kullanici_id,dergi_id)
)
	
Create table Fatura(
	id int identity(1,1) primary key,
	abonelik_id int unique foreign key references Abonelik(id),
	ucret float ,
	siparis_tarih datetime DEFAULT GETDATE()
)
Create table Iptal_Abonelik(
	
	id int identity(1,1) Primary Key,
	abonelik_id int unique,
	kullanici_id int,
	dergi_id int,
	baslangic_tarih date,
	taahut_gun int,
	iptal_tarih date,
	asil_bitis_tarihi date,
)

Create table Fatura_Iade(
	
	id int identity(1,1) Primary Key,
	iptal_abonelik_id int Foreign key references Iptal_Abonelik(id),
	geri_ucret int
)

Create table Silinen_Abonelik(

	abonelik_id int unique,
	kullanici_id int,
	dergi_id int,
	baslangic_tarih date,
	bitis_tarih date,
	taahut_gun int,
)

Create Table Silinen_Fatura(
	abonelik_id int unique,
	ucret float,
	siparis_tarih datetime
)

Create Table Yetkililer(
	ad nvarchar(20) Primary Key,
	sifre nvarchar(20),
)
Create Table Yetki (
	ad nvarchar(20) Foreign key references Yetkililer(ad) unique,
	dergi_ekle bit default 0,
	dergi_guncelle bit default 0,
	dergi_sil bit default 0,
	dergi_sayi_ekle bit default 0,
	dergi_sayi_guncelle bit default 0,
	kullanici_ekle bit default 0,
	kullanici_guncelle bit default 0,
	kullanici_abonelik_ekle bit default 0,
	kullanici_abonelik_sil bit default 0,
	otomasyon_kullanici_ekle bit default 0,
	otomasyon_kullanici_guncelle bit default 0,
	tablo_yedek bit default 0
)
Create Table Yetki_Yedek (
	ad nvarchar(20),
	dergi_ekle bit,
	dergi_guncelle bit,
	dergi_sil bit,
	dergi_sayi_ekle bit,
	dergi_sayi_guncelle bit,
	kullanici_ekle bit,
	kullanici_guncelle bit,
	kullanici_abonelik_ekle bit,
	kullanici_abonelik_sil bit,
	otomasyon_kullanici_ekle bit,
	otomasyon_kullanici_guncelle bit,
	tablo_yedek bit
)

--INDEXLER
create nonclustered index index_dergi_sayisi on Dergi_Sayisi(dergi_id)
create nonclustered index index_kullanici_ad on Kullanicilar(kullanici_ad)