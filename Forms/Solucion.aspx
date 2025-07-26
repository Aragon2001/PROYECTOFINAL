<%@ Page Title="Solucion" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Solucion.aspx.cs" Inherits="PROYECTOFINAL.Forms.Solucion" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Estilos generales del formulario */
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
        /* Ocultar menú lateral */
        nav {
            display: none;
        }
    </style>
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2>Cierre de Incidente</h2>

        <!-- Selección de incidente pendiente -->
        <div class="form-group">
            <label for="ddlIncidente">Incidente</label>
            <asp:DropDownList ID="ddlIncidente" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlIncidente_SelectedIndexChanged"></asp:DropDownList>
        </div>

        <!-- Campo para la causa del incidente -->
        <div class="form-group">
            <label for="txtCausa">Causa</label>
            <asp:TextBox ID="txtCausa" runat="server" TextMode="MultiLine" Rows="2" />
            <asp:RequiredFieldValidator ID="rfvCausa" runat="server" ControlToValidate="txtCausa" ErrorMessage="Campo requerido" CssClass="validation-error" Display="Dynamic" />
        </div>

        <!-- Campo para seleccionar la fecha en que se resolvió -->
        <div class="form-group">
            <label for="txtFechaS">Fecha Solución</label>
            <asp:TextBox ID="txtFechaS" runat="server" TextMode="Date" />
            <asp:RequiredFieldValidator ID="rfvFechaS" runat="server" ControlToValidate="txtFechaS" ErrorMessage="Campo requerido" CssClass="validation-error" Display="Dynamic" />
        </div>

        <!-- Descripción de la solución aplicada -->
        <div class="form-group">
            <label for="txtSolucion">Solución</label>
            <asp:TextBox ID="txtSolucion" runat="server" TextMode="MultiLine" Rows="2" />
            <asp:RequiredFieldValidator ID="rfvSolucion" runat="server" ControlToValidate="txtSolucion" ErrorMessage="Campo requerido" CssClass="validation-error" Display="Dynamic" />
        </div>

        <!-- Cantidad de horas invertidas en la solución -->
        <div class="form-group">
            <label for="txtHoras">Horas</label>
            <asp:TextBox ID="txtHoras" runat="server" />
            <asp:RequiredFieldValidator ID="rfvHoras" runat="server" ControlToValidate="txtHoras" ErrorMessage="Campo requerido" CssClass="validation-error" Display="Dynamic" />
        </div>

        <!-- Costo del repuesto si aplica -->
        <div class="form-group">
            <label for="txtRepuesto">Costo Repuesto</label>
            <asp:TextBox ID="txtRepuesto" runat="server" />
        </div>

        <!-- Estado final del incidente -->
        <div class="form-group">
            <label for="ddlEstado">Estado</label>
            <asp:DropDownList ID="ddlEstado" runat="server">
                <asp:ListItem Text="-- Seleccione --" Value="" />
                <asp:ListItem Text="Cerrado" Value="Cerrado" />
                <asp:ListItem Text="En proceso" Value="En proceso" />
                <asp:ListItem Text="Espera de repuesto" Value="Espera de repuesto" />
                <asp:ListItem Text="Espera de usuario" Value="Espera de usuario" />
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvEstado" runat="server" ControlToValidate="ddlEstado" InitialValue="" ErrorMessage="Seleccione estado" CssClass="validation-error" Display="Dynamic" />
        </div>

        <!-- Botón para actualizar la información del incidente -->
        <div class="form-group">
            <asp:Button ID="btnActualizar" runat="server" Text="Actualizar Incidente" OnClick="btnActualizar_Click" />
        </div>
    </div>
</asp:Content>
