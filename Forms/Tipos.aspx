<%@ Page Title="Tipos" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Tipos.aspx.cs" Inherits="PROYECTOFINAL.Forms.Tipos" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        .form-container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #ffffff;
            color: #000;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        .form-container h2 {
            text-align: center;
            font-weight: 700;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: 600;
            margin-bottom: 5px;
            display: block;
        }

        .form-group input[type="text"],
        .form-control {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        .validation-error {
            color: red;
            font-size: 0.9em;
        }

        .btn-group-custom .btn {
            min-width: 120px;
            margin-right: 10px;
        }

        .table thead {
            background-color: #004080;
            color: white;
        }

        .table-hover tbody tr:hover {
            background-color: #f0f8ff;
        }

        nav {
            display: none; /* ocultar menú si aplica */
        }
    </style>
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container shadow-lg rounded">
        <h2><i class="bi bi-tags-fill me-2"></i>Catálogo de Tipos</h2>

        <!-- Campo de descripción -->
        <div class="form-group">
            <label for="txtDescripcion">Descripción del Tipo</label>
            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" placeholder="Ingrese descripción del tipo" />
            <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server"
                ControlToValidate="txtDescripcion" CssClass="validation-error"
                ErrorMessage="* Campo requerido" Display="Dynamic" />
        </div>

        <!-- Botones de acción -->
        <div class="form-group btn-group-custom d-flex flex-wrap justify-content-center mt-3">
            <asp:Button ID="btnInsertar" runat="server" Text=" Insertar" CssClass="btn btn-success rounded-pill fw-semibold"
                OnClick="btnInsertar_Click" />
            <asp:Button ID="btnModificar" runat="server" Text=" Modificar" CssClass="btn btn-warning text-white rounded-pill fw-semibold"
                OnClick="btnModificar_Click" />
            <asp:Button ID="btnEliminar" runat="server" Text=" Eliminar" CssClass="btn btn-danger rounded-pill fw-semibold"
                OnClick="btnEliminar_Click" />
            <asp:Button ID="btnLimpiar" runat="server" Text=" Limpiar" CssClass="btn btn-secondary rounded-pill fw-semibold"
                OnClick="btnLimpiar_Click" />
        </div>

        <hr class="my-4" />

        <!-- Tabla de tipos -->
        <div class="table-responsive">
            <asp:GridView ID="gvTipos" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover table-striped"
                OnSelectedIndexChanged="gvTipos_SelectedIndexChanged" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="descripcion" HeaderText="Descripción" />
                    <asp:CommandField ShowSelectButton="True" SelectText="<i class='bi bi-pencil-square'></i> Seleccionar" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
