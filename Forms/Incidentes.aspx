<%@ Page Title="Registrar Incidente" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Incidentes.aspx.cs" Inherits="PROYECTOFINAL.Forms.Incidentes" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .form-container {
            max-width: 900px;
            margin: 50px auto;
            background: #fff;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .form-container h2 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 30px;
        }

        .form-group label {
            font-weight: 600;
        }

        .form-group .form-control {
            border-radius: 10px;
        }

        .form-actions {
            margin-top: 30px;
            text-align: center;
        }

        .form-actions .btn {
            min-width: 150px;
            font-weight: bold;
            margin: 5px;
            border-radius: 30px;
        }

        .validation-error {
            color: red;
            font-size: 0.9rem;
        }
    </style>
</asp:Content>

<asp:Content ID="contentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2><i class="bi bi-exclamation-circle-fill me-2 text-danger"></i>Registrar Incidente</h2>

        <div class="row g-4">
            <div class="col-md-6 form-group">
                <label for="ddlTipo">Tipo de Incidente</label>
                <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvTipo" runat="server" ControlToValidate="ddlTipo"
                    ErrorMessage="* Requerido" CssClass="validation-error" InitialValue=""
                    ValidationGroup="grupoIncidente" Display="Dynamic" />
            </div>

            <div class="col-md-6 form-group">
                <label for="ddlDepartamento">Departamento</label>
                <asp:DropDownList ID="ddlDepartamento" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvDepartamento" runat="server" ControlToValidate="ddlDepartamento"
                    ErrorMessage="* Requerido" CssClass="validation-error" InitialValue=""
                    ValidationGroup="grupoIncidente" Display="Dynamic" />
            </div>

            <div class="col-md-6 form-group">
                <label for="txtCorreo">Correo Electrónico</label>
                <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvCorreo" runat="server" ControlToValidate="txtCorreo"
                    ErrorMessage="* Requerido" CssClass="validation-error" Display="Dynamic"
                    ValidationGroup="grupoIncidente" />
                <asp:RegularExpressionValidator ID="revCorreo" runat="server" ControlToValidate="txtCorreo"
                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"
                    ErrorMessage="* Correo inválido" CssClass="validation-error" Display="Dynamic"
                    ValidationGroup="grupoIncidente" />
            </div>

            <div class="col-md-6 form-group">
                <label for="txtTelefono">Teléfono</label>
                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono"
                    ErrorMessage="* Requerido" CssClass="validation-error" Display="Dynamic"
                    ValidationGroup="grupoIncidente" />
                <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono"
                    ValidationExpression="^\d{8}$" ErrorMessage="* Teléfono inválido"
                    CssClass="validation-error" Display="Dynamic" ValidationGroup="grupoIncidente" />
            </div>

            <div class="col-12 form-group">
                <label for="txtDescripcion">Descripción del Problema</label>
                <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" ControlToValidate="txtDescripcion"
                    ErrorMessage="* Requerido" CssClass="validation-error" Display="Dynamic"
                    ValidationGroup="grupoIncidente" />
                <asp:CustomValidator ID="cvDescripcion" runat="server" ControlToValidate="txtDescripcion"
                    OnServerValidate="cvDescripcion_ServerValidate" ErrorMessage="* Mínimo 10 caracteres"
                    CssClass="validation-error" Display="Dynamic" ValidationGroup="grupoIncidente" />
            </div>
        </div>

        <div class="form-actions">
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar Incidente"
                CssClass="btn btn-primary" ValidationGroup="grupoIncidente" OnClick="btnGuardar_Click" />
        </div>
    </div>
</asp:Content>
