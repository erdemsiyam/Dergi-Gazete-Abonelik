<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SatinAl.aspx.cs" Inherits="AbonelikWeb.SatinAl" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            dergi :<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <br />
            taahüt süresi : <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddl_SecimDegisince"></asp:DropDownList>
            <br />
            ücret : <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Button ID="Button1" runat="server" Text="Satın Al" Enabled="false"  OnClick="button_SatinAl"/><!-- satın alma butonu başta enabled false edilir. dropdownlist seçili indeksi değişirkse aktif olur-->
        </div>
    </form>
</body>
</html>
