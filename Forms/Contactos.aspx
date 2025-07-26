<%@ Page Title="Contacto" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Contactos.aspx.cs" Inherits="PROYECTOFINAL.Forms.Contactos" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .form-container {
            max-width: 800px;
            margin: 50px auto;
            background: #fff;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .form-container h2 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 30px;
        }

        .form-group label {
            font-weight: 600;
        }

        .form-control {
            border-radius: 10px;
        }

        .validation-error {
            color: red;
            font-size: 0.9rem;
        }

        .form-actions {
            text-align: center;
            margin-top: 30px;
        }

        .form-actions .btn {
            min-width: 160px;
            font-weight: bold;
            border-radius: 30px;
        }
    </style>
</asp:Content>

<asp:Content ID="contentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2><i class="bi bi-envelope-paper-fill text-primary me-2"></i>Contáctanos</h2>

        <div class="row g-3">
            <div class="col-12 form-group">
                <label for="txtMensaje">Mensaje</label>
                <asp:TextBox ID="txtMensaje" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvMensaje" runat="server"
                    ControlToValidate="txtMensaje" ErrorMessage="* Requerido"
                    CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="col-md-6 form-group">
                <label for="txtEmail">Correo electrónico</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                    ControlToValidate="txtEmail" ErrorMessage="* Requerido"
                    CssClass="validation-error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                    ControlToValidate="txtEmail"
                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"
                    ErrorMessage="* Formato inválido"
                    CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="col-md-6 form-group">
                <label for="txtTelefono">Teléfono</label>
                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvTelefono" runat="server"
                    ControlToValidate="txtTelefono" ErrorMessage="* Requerido"
                    CssClass="validation-error" Display="Dynamic" />
            </div>

            <asp:TextBox ID="txtFecha" runat="server" Visible="false" />
            <asp:TextBox ID="txtUsuario" runat="server" Visible="false" />
        </div>

        <div class="form-actions">
            <asp:Button ID="btnEnviar" runat="server" Text="Enviar Mensaje"
                CssClass="btn btn-primary" OnClick="btnEnviar_Click" />
        </div>
    </div>
</asp:Content>
