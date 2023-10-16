<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionarCobranzas.aspx.cs" Inherits="LP3TP1.GestionarCobranzas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Bienvenido a la Seccion Cobranzas"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="En la siguiente seccion usted podra ver las deudas"></asp:Label>
            <br />
            <asp:Label ID="Label3" runat="server" Text="que posee cada cliente y filtrarlas por las fechas"></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="txbFecha" runat="server" TextMode="Date"></asp:TextBox>
            <asp:TextBox ID="txbMonto" runat="server"></asp:TextBox>
            <asp:DropDownList ID="DDLForanea" runat="server" DataTextField="apellido" DataValueField="id" DataSourceID="SqlDropDownList">
                <asp:ListItem Text="-- Seleccione --" Value="" />
            </asp:DropDownList>
            <br /><br />
            <asp:Button ID="agregarCobranza" runat="server" Text="Agregar" OnClick="agregarCobranza_Click" />
            <asp:Button ID="btnCancelarCliente" runat="server" Text="Cancelar Registro" OnClick="btnCancelarCliente_Click" />
            <asp:Button ID="btnVolverMenuInicio" runat="server" Text="Volver al Inicio" OnClick="btnVolverMenuInicio_Click" />

            <br /><br />
            <asp:GridView ID="GridView1" runat="server" DataSourceID="sqlCobranzas" AutoGenerateColumns="False" DataKeyNames="id">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" InsertVisible="False" SortExpression="id"></asp:BoundField>
                    <asp:BoundField DataField="fecha" HeaderText="fecha" SortExpression="fecha"></asp:BoundField>
                    <asp:BoundField DataField="monto" HeaderText="monto" SortExpression="monto"></asp:BoundField>
                    <asp:BoundField DataField="apellido" HeaderText="apellido" SortExpression="apellido"></asp:BoundField>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" SortExpression="nombre"></asp:BoundField>
                    <asp:BoundField DataField="idClienteForanea" HeaderText="idClienteForanea" SortExpression="idClienteForanea"></asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sqlCobranzas" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" DeleteCommand="DELETE FROM [Cobranzas] WHERE [id] = @id" InsertCommand="INSERT INTO [Cobranzas] ([fecha], [idClienteForanea], [monto]) VALUES (@fecha, @idClienteForanea, @monto)" SelectCommand="SELECT Cobranzas.id, Cobranzas.fecha, Cobranzas.monto, Clientes.apellido, Clientes.nombre, Cobranzas.idClienteForanea FROM Cobranzas INNER JOIN Clientes ON Cobranzas.idClienteForanea = Clientes.id" UpdateCommand="UPDATE [Cobranzas] SET [fecha] = @fecha, [idClienteForanea] = @idClienteForanea, [monto] = @monto WHERE [id] = @id">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter DbType="Date" Name="fecha"></asp:Parameter>
                    <asp:Parameter Name="idClienteForanea" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="monto" Type="Decimal"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter DbType="Date" Name="fecha"></asp:Parameter>
                    <asp:Parameter Name="idClienteForanea" Type="Int32"></asp:Parameter>
                    <asp:Parameter Name="monto" Type="Decimal"></asp:Parameter>
                    <asp:Parameter Name="id" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDropDownList" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" SelectCommand="SELECT * FROM [Clientes]"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
