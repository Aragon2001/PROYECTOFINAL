<%@ Page Title="Consulta Incidentes" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="ConsultaIncidentes.aspx.cs" Inherits="PROYECTOFINAL.Forms.ConsultaIncidentes" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <style>
        .consulta-container {
            max-width: 900px;
            margin: 40px auto;
            background-color: white;
            color: black;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0, 0, 0, 0.1);
        }
        .consulta-container h2 {
            text-align: center;
            margin-bottom: 25px;
        }
        .consulta-container .filters {
            margin-bottom: 20px;
            display: flex;
            gap: 15px;
        }
        .consulta-container label {
            font-weight: bold;
        }
        .consulta-container input[type=text],
        .consulta-container select {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .consulta-container input[type=submit] {
            background-color: #004080;
            color: white;
            border: none;
            padding: 8px 16px;
            cursor: pointer;
            border-radius: 5px;
        }
        .consulta-container input[type=submit]:hover {
            background-color: #0055aa;
        }
        nav {
            display: none;
        }
    </style>
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="consulta-container">
        <!-- Título de la consulta -->
        <h2>Consulta de Incidentes</h2>

        <!-- Controles de filtro -->
        <div class="filters">
            <asp:Label ID="lblEstado" runat="server" Text="Estado:"></asp:Label>
            <asp:DropDownList ID="ddlEstado" runat="server">
                <asp:ListItem Text="Todos" Value="" />
                <asp:ListItem Text="Pendiente" Value="Pendiente" />
                <asp:ListItem Text="Cerrado" Value="Cerrado" />
                <asp:ListItem Text="En proceso" Value="En proceso" />
                <asp:ListItem Text="Espera de repuesto" Value="Espera de repuesto" />
                <asp:ListItem Text="Espera de usuario" Value="Espera de usuario" />
            </asp:DropDownList>

            <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar" OnClick="btnFiltrar_Click" />
        </div>

        <!-- Grid con resultados -->
        <asp:GridView ID="gvIncidentes" runat="server" AutoGenerateColumns="True" />
    </div>
</asp:Content>
