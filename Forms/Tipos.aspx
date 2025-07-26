<%@ Page Title="Tipos" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Tipos.aspx.cs" Inherits="PROYECTOFINAL.Forms.Tipos" %>

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
        .form-group input[type=text] {
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
        <!-- Título del catálogo de tipos -->
        <h2>Catálogo de Tipos</h2>

        <!-- Campo de descripción con validación -->
        <div class="form-group">
            <label for="txtDescripcion">Descripción del Tipo</label>
            <asp:TextBox ID="txtDescripcion" runat="server" />
            <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" ControlToValidate="txtDescripcion" ErrorMessage="Campo requerido" CssClass="validation-error" Display="Dynamic" />
        </div>

        <!-- Botones de acción para CRUD -->
        <div class="form-group buttons">
            <asp:Button ID="btnInsertar" runat="server" Text="Insertar" OnClick="btnInsertar_Click" />
            <asp:Button ID="btnModificar" runat="server" Text="Modificar" OnClick="btnModificar_Click" />
            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" OnClick="btnEliminar_Click" />
            <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" OnClick="btnLimpiar_Click" />
        </div>

        <!-- Tabla de tipos -->
        <asp:GridView ID="gvTipos" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="gvTipos_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="descripcion" HeaderText="Descripción" />
                <asp:CommandField ShowSelectButton="True" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
