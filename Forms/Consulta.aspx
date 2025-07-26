<%@ Page Title="Consulta de Incidentes" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Consulta.aspx.cs" Inherits="PROYECTOFINAL.Forms.ConsultaIncidentes" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .form-container {
            max-width: 1000px;
            margin: 50px auto;
            background-color: #fff;
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

        .form-control {
            border-radius: 10px;
        }

        .btn {
            min-width: 150px;
            border-radius: 30px;
            font-weight: bold;
        }

        .table thead {
            background-color: #004080;
            color: white;
        }

        .table-hover tbody tr:hover {
            background-color: #eef6ff;
        }
    </style>
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2><i class="bi bi-search text-primary me-2"></i>Consulta de Incidentes</h2>

        <div class="row mb-4 g-3 align-items-end">
            <div class="col-md-8">
                <label for="ddlEstado">Estado del incidente</label>
                <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control">
                    <asp:ListItem Text="-- Todos --" Value="" />
                    <asp:ListItem Text="Pendiente" Value="Pendiente" />
                    <asp:ListItem Text="En Proceso" Value="En Proceso" />
                    <asp:ListItem Text="Cerrado" Value="Cerrado" />
                </asp:DropDownList>
            </div>
            <div class="col-md-4 text-end">
                <asp:Button ID="btnFiltrar" runat="server" Text="Filtrar"
                    CssClass="btn btn-primary" OnClick="btnFiltrar_Click" />
            </div>
        </div>

        <div class="table-responsive">
            <asp:GridView ID="gvIncidentes" runat="server"
                CssClass="table table-bordered table-hover table-striped"
                AutoGenerateColumns="True"
                GridLines="None" />
        </div>
    </div>
</asp:Content>
