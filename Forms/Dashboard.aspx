<%@ Page Title="Dashboard" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="PROYECTOFINAL.Forms.Dashboard" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <style>
        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
        }
        .card {
            background-color: white;
            color: black;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            text-align: center;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card i {
            font-size: 2rem;
            color: #004080;
            margin-bottom: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Panel Principal</h2>
    <div class="card-grid">
        <asp:Panel ID="panelUsuario" runat="server">
            <div class="card"><i class="fa-solid fa-envelope"></i><br />Contactos</div>
            <div class="card"><i class="fa-solid fa-triangle-exclamation"></i><br />Incidentes</div>
        </asp:Panel>

        <asp:Panel ID="panelTecnico" runat="server">
            <div class="card"><i class="fa-solid fa-toolbox"></i><br />Soluciones</div>
        </asp:Panel>

        <asp:Panel ID="panelAdmin" runat="server">
            <div class="card"><i class="fa-solid fa-building"></i><br />Departamentos</div>
            <div class="card"><i class="fa-solid fa-tags"></i><br />Tipos</div>
            <div class="card"><i class="fa-solid fa-users"></i><br />Usuarios</div>
            <div class="card"><i class="fa-solid fa-folder-closed"></i><br />Incidentes Cerrados</div>
            <div class="card"><i class="fa-solid fa-comment-dots"></i><br />Mensajes</div>
        </asp:Panel>
    </div>
</asp:Content>
