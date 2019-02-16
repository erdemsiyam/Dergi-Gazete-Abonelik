<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YeniKullanici.aspx.cs" Inherits="AbonelikWeb.YeniKullanici" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Kullanıcı adı :<asp:TextBox ID="kullanici_ad" runat="server" MaxLength="30"></asp:TextBox>
            <br />
            Kullanıcı şifresi :<asp:TextBox ID="kullanici_sifre" runat="server" MaxLength="30"></asp:TextBox>
            <br />
            isim :<asp:TextBox ID="isim" runat="server" MaxLength="30"></asp:TextBox>
            <br />
            soyisim :<asp:TextBox ID="soyisim" runat="server" MaxLength="30"></asp:TextBox>
            <br />
            adres :<asp:TextBox ID="adres" runat="server" MaxLength="60"></asp:TextBox>
            <br />
            e-posta :<asp:TextBox ID="e_posta" runat="server" TextMode="Email" MaxLength="50"></asp:TextBox>
            <br />
            telefon :<asp:TextBox ID="telefon" runat="server" TextMode="Phone" MaxLength="14" ></asp:TextBox>
            <h> Örnek : '(536) 123-4567'</h>
            <br />
            TC :<asp:TextBox ID="tc" runat="server" TextMode="Number" MaxLength="11"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Kayıt Ol" OnClick="button_kayit"/>
        </div>
    </form>
</body>
</html>
