<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="AbonelikWeb.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <br />
        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
        <br />
        <a href="Giris.aspx">Oturumu Kapat</a>
        <br />
        <asp:Button ID="Button2" runat="server" Text="Aboneliklerim" OnClick="button_aboneliklerim"/>
        <br />
        <asp:Button ID="Button3" runat="server" Text="Silinen Aboneliklerim" OnClick="button_silinen_abonelik"/>
        <br />
        <asp:Button ID="Button4" runat="server" Text="İptal Aboneliklerim" OnClick="button_iptal_abonelik"/>
    </div>
    </form>
</body>
</html>
