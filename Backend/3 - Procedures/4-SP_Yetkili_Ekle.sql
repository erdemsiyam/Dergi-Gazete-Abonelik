
CREATE PROCEDURE SP_Yetkili_Ekle
@ad nvarchar(20),
@sifre nvarchar(20)
AS

	IF( EXISTS(Select * from Yetkililer where (ad=@ad) ))
		return
		
		
	INSERT INTO Yetkililer VALUES ( @ad,@sifre)
	
	INSERT INTO Yetki VALUES ( @ad,0,0,0,0,0,0,0,0,0,0,0,0)
	

GO