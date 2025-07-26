<%@ Page Title="Incidentes" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Incidentes.aspx.cs" Inherits="PROYECTOFINAL.Forms.Incidentes" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-container {
            max-width: 600px;
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
        .form-group input,
        .form-group textarea,
        .form-group select {
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
        nav {
            display: none;
        }
    </style>
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2>Registro de Incidente</h2>

        <div class="form-group">
            <label for="ddlTipo">Tipo</label>
            <asp:DropDownList ID="ddlTipo" runat="server" AppendDataBoundItems="true">
                <asp:ListItem Text="-- Seleccione --" Value="" />
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvTipo" runat="server" ControlToValidate="ddlTipo" InitialValue="" ErrorMessage="Debe seleccionar un tipo." CssClass="validation-error" Display="Dynamic" />
        </div>

        <div class="form-group">
            <label for="ddlDepartamento">Departamento</label>
            <asp:DropDownList ID="ddlDepartamento" runat="server" AppendDataBoundItems="true">
                <asp:ListItem Text="-- Seleccione --" Value="" />
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvDepartamento" runat="server" ControlToValidate="ddlDepartamento" InitialValue="" ErrorMessage="Debe seleccionar un departamento." CssClass="validation-error" Display="Dynamic" />
        </div>

        <div class="form-group">
            <label for="txtCorreo">Correo</label>
            <asp:TextBox ID="txtCorreo" runat="server" />
            <asp:RequiredFieldValidator ID="rfvCorreo" runat="server" ControlToValidate="txtCorreo" ErrorMessage="Correo requerido." CssClass="validation-error" Display="Dynamic" />
        </div>

        <div class="form-group">
            <label for="txtTelefono">Teléfono</label>
            <asp:TextBox ID="txtTelefono" runat="server" />
            <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" ErrorMessage="Teléfono requerido." CssClass="validation-error" Display="Dynamic" />
        </div>

        <div class="form-group">
            <label for="txtDescripcion">Descripción</label>
            <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Rows="3" />
            <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" ControlToValidate="txtDescripcion" ErrorMessage="Debe ingresar una descripción." CssClass="validation-error" Display="Dynamic" />
        </div>

        <div class="form-group">
            <asp:Button ID="btnGuardar" runat="server" Text="Registrar Incidente" OnClick="btnGuardar_Click" />
        </div>
    </div>
</asp:Content>
