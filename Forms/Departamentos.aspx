<%@ Page Title="Departamentos" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Departamentos.aspx.cs" Inherits="PROYECTOFINAL.Forms.Departamentos" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Contenedor principal del formulario con estilos de presentación */
        .form-container {
            max-width: 600px;
            margin: 40px auto;
            background-color: white;
            color: black;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }

        /* Título centrado */
        .form-container h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        /* Agrupación de campos con separación */
        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            font-weight: bold;
            display: block;
        }

        /* Estilo de entrada de texto */
        .form-group input[type=text] {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        /* Botones agrupados horizontalmente */
        .form-group .buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        /* Estilo general de los botones */
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

        /* Estilo para mensajes de validación */
        .validation-error {
            color: red;
            font-size: 0.9em;
        }

        /* Oculta el menú lateral cuando esta vista está activa */
        nav {
            display: none;
        }
    </style>
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <!-- Título del catálogo -->
        <h2>Catálogo de Departamentos</h2>

        <!-- Campo para nombre de departamento con validación -->
        <div class="form-group">
            <label for="txtNombre">Nombre del Departamento</label>
            <asp:TextBox ID="txtNombre" runat="server" />
            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="Campo requerido" CssClass="validation-error" Display="Dynamic" />
        </div>

        <!-- Botones de acción CRUD -->
        <div class="form-group buttons">
            <asp:Button ID="btnInsertar" runat="server" Text="Insertar" OnClick="btnInsertar_Click" />
            <asp:Button ID="btnModificar" runat="server" Text="Modificar" OnClick="btnModificar_Click" />
            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" OnClick="btnEliminar_Click" />
            <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" OnClick="btnLimpiar_Click" />
        </div>

        <!-- Tabla con los datos de los departamentos -->
        <asp:GridView ID="gvDepartamentos" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="gvDepartamentos_SelectedIndexChanged">
            <Columns>
                <!-- Columna ID (solo lectura) -->
                <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" />
                <!-- Columna nombre editable -->
                <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                <!-- Botón de selección por fila -->
                <asp:CommandField ShowSelectButton="True" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
