<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionarClientes.aspx.cs" Inherits="LP3TP1.GestionarClientes" %><html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" type="text/css" href="GestionarClientes.css" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Bienvenido a la Gestion de Clientes"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Nombre: "></asp:Label>
            <asp:TextBox ID="txbNombreCliente" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Apellido:"></asp:Label>
            <asp:TextBox ID="txbApellidoCliente" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="btnAgregarCliente" runat="server" Text="Agregar Cliente" OnClick="btnAgregarCliente_Click" />
            <asp:Button ID="btnCancelarCliente" runat="server" Text="Cancelar Registro" OnClick="btnCancelarCliente_Click" />
            <br />
            <br />
            <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataInsertar" AutoGenerateColumns="False" DataKeyNames="id">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="Id Cliente" ReadOnly="True" InsertVisible="False" SortExpression="id"></asp:BoundField>
                    <asp:BoundField DataField="apellido" HeaderText="Apellido Cliente" SortExpression="apellido"></asp:BoundField>
                    <asp:BoundField DataField="nombre" HeaderText="Nombre Cliente" SortExpression="nombre"></asp:BoundField>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ButtonType="Button" HeaderText="Opciones"></asp:CommandField>
                </Columns>
            </asp:GridView>
            <br />
            <br />
            <asp:Button ID="btnVolverMenuInicio" runat="server" Text="Volver al Inicio" OnClick="btnVolverMenuInicio_Click" />
            <asp:SqlDataSource ID="SqlDataInsertar" runat="server" ConnectionString="<%$ ConnectionStrings:conexion %>" DeleteCommand="DELETE FROM [Clientes] WHERE [id] = @id" InsertCommand="INSERT INTO [Clientes] ([apellido], [nombre]) VALUES (@apellido, @nombre)" SelectCommand="SELECT * FROM [Clientes]" UpdateCommand="UPDATE [Clientes] SET [apellido] = @apellido, [nombre] = @nombre WHERE [id] = @id">
                <DeleteParameters>
                    <asp:Parameter Name="id" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="apellido" Type="String"></asp:Parameter>
                    <asp:Parameter Name="nombre" Type="String"></asp:Parameter>
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="apellido" Type="String"></asp:Parameter>
                    <asp:Parameter Name="nombre" Type="String"></asp:Parameter>
                    <asp:Parameter Name="id" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
           
        </div>

    </form>
</body>
</html>
