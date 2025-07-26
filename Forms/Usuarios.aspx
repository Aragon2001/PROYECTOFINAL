<%@ Page Title="Usuarios" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="PROYECTOFINAL.Forms.Usuarios" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-container {
            max-width: 700px;
            margin: 40px auto;
            background-color: white;
            color: black;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            font-weight: bold;
            display: block;
        }
        .form-group input[type=text],
        .form-group input[type=password],
        .form-group input[type=number] {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        .form-group select {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        .form-group .buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        .form-group input[type=submit],
        .form-group input[type=button] {
            background-color: #004080;
            color: white;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            border-radius: 5px;
        }
        .form-group input[type=submit]:hover,
        .form-group input[type=button]:hover {
            background-color: #0055aa;
        }
        .validation-error {
            color: red;
            font-size: 0.9em;
        }
        nav {
            display: none;
        }
    </style>
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2>Catálogo de Usuarios</h2>

        <div class="form-group">
            <label for="txtUsuario">Usuario</label>
            <asp:TextBox ID="txtUsuario" runat="server" />
            <asp:RequiredFieldValidator ID="rfvUsuario" runat="server" ControlToValidate="txtUsuario" ErrorMessage="Campo requerido" CssClass="validation-error" Display="Dynamic" />
        </div>

        <div class="form-group">
            <label for="txtNombre">Nombre</label>
            <asp:TextBox ID="txtNombre" runat="server" />
            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="Campo requerido" CssClass="validation-error" Display="Dynamic" />
        </div>

        <div class="form-group">
            <label for="txtClave">Contraseña</label>
            <asp:TextBox ID="txtClave" runat="server" TextMode="Password" />
            <asp:RequiredFieldValidator ID="rfvClave" runat="server" ControlToValidate="txtClave" ErrorMessage="Campo requerido" CssClass="validation-error" Display="Dynamic" />
        </div>

        <div class="form-group">
            <label for="ddlNivel">Nivel</label>
            <asp:DropDownList ID="ddlNivel" runat="server">
                <asp:ListItem Text="-- Seleccione --" Value="" />
                <asp:ListItem Text="Usuario (1)" Value="1" />
                <asp:ListItem Text="Técnico (2)" Value="2" />
                <asp:ListItem Text="Administrador (3)" Value="3" />
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvNivel" runat="server" ControlToValidate="ddlNivel" InitialValue="" ErrorMessage="Seleccione un nivel" CssClass="validation-error" Display="Dynamic" />
        </div>

        <div class="form-group">
            <label for="txtSalario">Salario</label>
            <asp:TextBox ID="txtSalario" runat="server" TextMode="Number" />
        </div>

        <div class="form-group buttons">
            <asp:Button ID="btnInsertar" runat="server" Text="Insertar" OnClick="btnInsertar_Click" />
            <asp:Button ID="btnModificar" runat="server" Text="Modificar" OnClick="btnModificar_Click" />
            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" OnClick="btnEliminar_Click" />
            <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" OnClick="btnLimpiar_Click" />
        </div>

        <asp:GridView ID="gvUsuarios" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="gvUsuarios_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="usuario" HeaderText="Usuario" ReadOnly="True" />
                <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                <asp:BoundField DataField="clave" HeaderText="Clave" />
                <asp:BoundField DataField="nivel" HeaderText="Nivel" />
                <asp:BoundField DataField="salario" HeaderText="Salario" />
                <asp:CommandField ShowSelectButton="True" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
