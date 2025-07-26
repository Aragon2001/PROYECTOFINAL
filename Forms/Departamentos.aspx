<%@ Page Title="Departamentos" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Departamentos.aspx.cs" Inherits="PROYECTOFINAL.Forms.Departamentos" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .form-container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
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

        .btn-group-custom .btn {
            min-width: 120px;
            margin: 5px;
            font-weight: bold;
            border-radius: 30px;
        }
    </style>
</asp:Content>

<asp:Content ID="mainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2><i class="bi bi-building me-2 text-primary"></i>Gestión de Departamentos</h2>

        <div class="form-group mb-4">
            <label for="txtNombre">Nombre del Departamento</label>
            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                ErrorMessage="* Campo obligatorio" CssClass="validation-error" Display="Dynamic" />
        </div>

        <div class="text-center btn-group-custom">
            <asp:Button ID="btnInsertar" runat="server" Text=" Insertar" CssClass="btn btn-success" OnClick="btnInsertar_Click" />
            <asp:Button ID="btnModificar" runat="server" Text=" Modificar" CssClass="btn btn-warning text-white" OnClick="btnModificar_Click" />
            <asp:Button ID="btnEliminar" runat="server" Text=" Eliminar" CssClass="btn btn-danger" OnClick="btnEliminar_Click" />
            <asp:Button ID="btnLimpiar" runat="server" Text=" Limpiar" CssClass="btn btn-secondary" OnClick="btnLimpiar_Click" />
        </div>

        <hr class="my-4" />

        <div class="table-responsive">
            <asp:GridView ID="gvDepartamentos" runat="server" CssClass="table table-bordered table-hover table-striped"
                AutoGenerateColumns="False" GridLines="None" OnSelectedIndexChanged="gvDepartamentos_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="true" />
                    <asp:BoundField DataField="nombre" HeaderText="Nombre del Departamento" />
                    <asp:CommandField ShowSelectButton="True" SelectText="<i class='bi bi-pencil-square'></i> Seleccionar" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
