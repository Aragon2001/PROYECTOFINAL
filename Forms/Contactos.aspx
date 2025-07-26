<%@ Page Title="Contactos" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Contactos.aspx.cs" Inherits="PROYECTOFINAL.Forms.Contactos" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-container {
            max-width: 500px;
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
            display: block;
            font-weight: bold;
        }
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        .form-group input[type=submit] {
            background-color: #004080;
            color: white;
            border: none;
            cursor: pointer;
        }
        .form-group input[type=submit]:hover {
            background-color: #0055aa;
        }
        .validation-error {
            color: red;
            font-size: 0.9em;
        }
        /* Ocultar menú lateral cuando esté en modo formulario */
        nav {
            display: none;
        }
    </style>
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2>Formulario de Contacto</h2>
        <div class="form-group">
            <label for="txtMensaje">Mensaje</label>
            <asp:TextBox ID="txtMensaje" runat="server" TextMode="MultiLine" Rows="3" />
            <asp:RequiredFieldValidator ID="rfvMensaje" runat="server" ControlToValidate="txtMensaje" ErrorMessage="El mensaje es obligatorio." CssClass="validation-error" Display="Dynamic" />
        </div>

        <div class="form-group">
            <label for="txtFecha">Fecha</label>
            <asp:TextBox ID="txtFecha" runat="server" ReadOnly="true" />
        </div>

        <div class="form-group">
            <label for="txtEmail">Correo Electrónico</label>
            <asp:TextBox ID="txtEmail" runat="server" />
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="El correo es obligatorio." CssClass="validation-error" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Correo inválido." CssClass="validation-error" Display="Dynamic" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" />
        </div>

        <div class="form-group">
            <label for="txtTelefono">Teléfono</label>
            <asp:TextBox ID="txtTelefono" runat="server" />
            <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" ErrorMessage="El teléfono es obligatorio." CssClass="validation-error" Display="Dynamic" />
        </div>

        <div class="form-group">
            <label for="txtUsuario">Usuario</label>
            <asp:TextBox ID="txtUsuario" runat="server" ReadOnly="true" />
        </div>

        <div class="form-group">
            <asp:Button ID="btnEnviar" runat="server" Text="Enviar Mensaje" OnClick="btnEnviar_Click" />
        </div>
    </div>
</asp:Content>
