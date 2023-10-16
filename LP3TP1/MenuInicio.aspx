<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuInicio.aspx.cs" Inherits="LP3TP1.MenuInicio" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="tituloMenu" runat="server" Text="Bienvenido a la aplicacion de Cobranzas"></asp:Label>
            <br />
            <br />
            <asp:Label ID="preguntaMenu" runat="server" Text="¿Que desea hacer?"></asp:Label>
            <br />
            <br />
            <asp:HyperLink ID="formularioClientes" runat="server" NavigateUrl="~/GestionarClientes.aspx">Gestionar Clientes</asp:HyperLink>
            <asp:HyperLink ID="formularioCobranzas" runat="server" NavigateUrl="~/GestionarCobranzas.aspx">Gestionar Cobranzas</asp:HyperLink>
        </div>
    </form>
</body>
</html>
