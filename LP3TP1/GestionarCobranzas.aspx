﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionarCobranzas.aspx.cs" Inherits="LP3TP1.GestionarCobranzas" %>

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
            <asp:Label ID="Label5" runat="server" Text="Ingrese la fecha: "></asp:Label>
            <br />
            <asp:TextBox ID="txbFecha" runat="server" TextMode="Date"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label6" runat="server" Text="Ingrese el monto: "></asp:Label><br />
            <asp:TextBox ID="txbMonto" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label7" runat="server" Text="Seleccione el cliente: "></asp:Label>
            <asp:DropDownList ID="DDLForanea" runat="server" DataTextField="apellido" DataValueField="id" DataSourceID="SqlDropDownList">
            </asp:DropDownList>

            <br /><br />
            <asp:Button ID="agregarCobranza" runat="server" Text="Agregar Registro" OnClick="agregarCobranza_Click" />
            <asp:Button ID="btnCancelarCliente" runat="server" Text="Cancelar Registro" OnClick="btnCancelarCliente_Click" />

            <br /><br />
            <asp:Label ID="lblResultado" runat="server" Text=""></asp:Label>
            <br /><br />

            <asp:GridView ID="GridView1" runat="server" DataSourceID="sqlCobranzas" AutoGenerateColumns="False" DataKeyNames="id" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="id" ReadOnly="True" InsertVisible="False" SortExpression="id"></asp:BoundField>
                    <asp:BoundField DataField="fecha" HeaderText="fecha" SortExpression="fecha"></asp:BoundField>
                    <asp:BoundField DataField="monto" HeaderText="monto" SortExpression="monto"></asp:BoundField>
                    <asp:BoundField DataField="apellido" HeaderText="apellido" SortExpression="apellido"></asp:BoundField>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" SortExpression="nombre"></asp:BoundField>
                    <asp:BoundField DataField="idClienteForanea" HeaderText="idClienteForanea" SortExpression="idClienteForanea"></asp:BoundField>
                    <asp:CommandField CancelImageUrl="~/icons/iconocancelar.png" DeleteImageUrl="~/icons/iconoeliminar.png" EditImageUrl="~/icons/iconoeditar.png" NewImageUrl="~/icons/iconoagregar.png" SelectImageUrl="~/icons/iconoseleccionar.png" ShowDeleteButton="True"  ShowSelectButton="True" UpdateImageUrl="~/icons/iconoactualizar.png" ButtonType="Image" HeaderText="Opciones" ControlStyle-Width="20"></asp:CommandField>
                </Columns>
            </asp:GridView>
            <br /><br />

            <asp:Label ID="Label4" runat="server" Text="Ingrese fecha para Filtrar por Mes y Año y ver la tabla: "></asp:Label>
            <asp:TextBox ID="TextBoxFecha" runat="server" Type="date" AutoPostBack="true"></asp:TextBox>

            <asp:GridView ID="GridViewCobranzas" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourceCobranzas">
                <Columns>
                    <asp:BoundField DataField="NombreCliente" HeaderText="Nombre y Apellido del Cliente" />
                    <asp:BoundField DataField="TotalCobranzas" HeaderText="Total a Cobrar" />
                </Columns>
            </asp:GridView>
            <br /><br />

            <asp:Button ID="btnVolverMenuInicio" runat="server" Text="Volver al Inicio" OnClick="btnVolverMenuInicio_Click" />

            <asp:SqlDataSource ID="SqlDataSourceCobranzas" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>"
                SelectCommand="SELECT C.idClienteForanea, 
                    SUM(C.monto) AS TotalCobranzas, 
                    CONCAT(CL.nombre, ' ', CL.apellido) AS NombreCliente
                FROM Cobranzas C
                INNER JOIN Clientes CL ON C.idClienteForanea = CL.id
                WHERE MONTH(C.fecha) = MONTH(@Fecha) AND YEAR(C.fecha) = YEAR(@Fecha)
                GROUP BY C.idClienteForanea, CONCAT(CL.nombre, ' ', CL.apellido)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBoxFecha" Name="Fecha" PropertyName="Text" />
                </SelectParameters>
            </asp:SqlDataSource>



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
