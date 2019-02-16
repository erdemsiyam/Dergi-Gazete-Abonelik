<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Giris.aspx.cs" Inherits="AbonelikWeb.Giris" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous"/>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        kullanici adı : <asp:TextBox ID="kullanici_ad" runat="server"></asp:TextBox>
        <br />
        kullanıcı sifre : <asp:TextBox ID="kullanici_sifre" runat="server"></asp:TextBox>
        <br />
        <asp:Button ID="kullanici_giris" runat="server" Text="Giriş Yap" OnClick="button_giris"/>
        <br />
        <br />
        <a href="YeniKullanici.aspx">Kullanıcı Oluştur</a>
    </div>
    </form>
</body>
</html>
