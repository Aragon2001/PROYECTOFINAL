<%@ Page Title="Gestión de Usuarios" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="PROYECTOFINAL.Forms.Usuarios" ValidateRequest="false" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .form-container {
            max-width: 1000px;
            margin: 50px auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .form-container h2 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 30px;
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
        <h2><i class="bi bi-person-lines-fill text-primary me-2"></i>Gestión de Usuarios</h2>

        <!-- Cédula (clave) -->
        <div class="row mb-3">
            <div class="col-md-6">
                <label for="txtCedula">Cédula</label>
                <asp:TextBox ID="txtCedula" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvCedula" runat="server" ControlToValidate="txtCedula"
                    ErrorMessage="* Requerido" CssClass="validation-error" Display="Dynamic" />
            </div>
            <div class="col-md-6">
                <label for="ddlRol">Rol</label>
                <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvRol" runat="server" ControlToValidate="ddlRol"
                    InitialValue="" ErrorMessage="* Seleccione un rol" CssClass="validation-error" Display="Dynamic" />
            </div>
        </div>

        <!-- Datos personales -->
        <div class="row mb-3">
            <div class="col-md-4">
                <label for="txtNombre">Nombre</label>
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                    ErrorMessage="* Requerido" CssClass="validation-error" Display="Dynamic" />
            </div>
            <div class="col-md-4">
                <label for="txtApellido1">Primer Apellido</label>
                <asp:TextBox ID="txtApellido1" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvApellido1" runat="server" ControlToValidate="txtApellido1"
                    ErrorMessage="* Requerido" CssClass="validation-error" Display="Dynamic" />
            </div>
            <div class="col-md-4">
                <label for="txtApellido2">Segundo Apellido</label>
                <asp:TextBox ID="txtApellido2" runat="server" CssClass="form-control" />
            </div>
        </div>

        <!-- Contacto -->
        <div class="row mb-3">
            <div class="col-md-6">
                <label for="txtCorreo">Correo</label>
                <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvCorreo" runat="server" ControlToValidate="txtCorreo"
                    ErrorMessage="* Requerido" CssClass="validation-error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revCorreo" runat="server" ControlToValidate="txtCorreo"
                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"
                    ErrorMessage="* Correo inválido" CssClass="validation-error" Display="Dynamic" />
            </div>
            <div class="col-md-6">
                <label for="txtTelefono">Teléfono</label>
                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono"
                    ErrorMessage="* Requerido" CssClass="validation-error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono"
                    ValidationExpression="^\d{8}$"
                    ErrorMessage="* Teléfono inválido (8 dígitos)" CssClass="validation-error" Display="Dynamic" />
            </div>
        </div>

        <!-- Seguridad y salario -->
        <div class="row mb-4">
            <div class="col-md-6">
                <label for="txtClave">Contraseña</label>
                <asp:TextBox ID="txtClave" runat="server" CssClass="form-control" TextMode="Password" />
                <asp:RequiredFieldValidator ID="rfvClave" runat="server" ControlToValidate="txtClave"
                    ErrorMessage="* Requerido" CssClass="validation-error" Display="Dynamic" />
            </div>
            <div class="col-md-6">
                <label for="txtSalario">Salario ₡</label>
                <asp:TextBox ID="txtSalario" runat="server" CssClass="form-control" />
                <asp:RegularExpressionValidator ID="revSalario" runat="server" ControlToValidate="txtSalario"
                    ValidationExpression="^\d+(\.\d{1,2})?$"
                    ErrorMessage="* Salario inválido" CssClass="validation-error" Display="Dynamic" />
            </div>
        </div>

        <!-- Botones -->
        <div class="text-center btn-group-custom">
            <asp:Button ID="btnInsertar" runat="server" Text="Insertar" CssClass="btn btn-success" OnClick="btnInsertar_Click" />
            <asp:Button ID="btnModificar" runat="server" Text="Modificar" CssClass="btn btn-warning text-white" OnClick="btnModificar_Click" />
            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btnEliminar_Click" />
            <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn btn-secondary" OnClick="btnLimpiar_Click" />
        </div>

        <!-- Tabla -->
        <hr class="my-5" />
        <div class="table-responsive">
            <asp:GridView ID="gvUsuarios" runat="server" AutoGenerateColumns="False"
                CssClass="table table-bordered table-hover table-striped"
                OnSelectedIndexChanged="gvUsuarios_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="cedula" HeaderText="Cédula" ReadOnly="True" />
                    <asp:BoundField DataField="nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="apellido1" HeaderText="Apellido 1" />
                    <asp:BoundField DataField="apellido2" HeaderText="Apellido 2" />
                    <asp:BoundField DataField="correo" HeaderText="Correo" />
                    <asp:BoundField DataField="telefono" HeaderText="Teléfono" />
                    <asp:BoundField DataField="salario" HeaderText="Salario ₡" />
                    <asp:BoundField DataField="rol" HeaderText="Rol" />
                    <asp:CommandField ShowSelectButton="True" SelectText="Seleccionar" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
