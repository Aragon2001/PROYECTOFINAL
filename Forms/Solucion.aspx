<%@ Page Title="Solución de Incidente" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Solucion.aspx.cs" Inherits="PROYECTOFINAL.Forms.Solucion" %>

<asp:Content ID="headContent" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .form-container {
            max-width: 1100px;
            margin: 40px auto;
            background: #fff;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .form-container h2 {
            text-align: center;
            font-weight: bold;
            margin-bottom: 25px;
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
            min-width: 140px;
            margin: 5px;
            border-radius: 30px;
        }

        .table thead {
            background-color: #004080;
            color: white;
        }
    </style>
</asp:Content>

<asp:Content ID="contentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2><i class="bi bi-tools me-2"></i>Gestión de Soluciones Técnicas</h2>

        <!-- Formulario de solución -->
        <div class="row g-3">
            <div class="col-md-12">
                <label for="ddlIncidente">Seleccione Incidente</label>
                <asp:DropDownList ID="ddlIncidente" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlIncidente_SelectedIndexChanged" />
            </div>

            <!-- DATOS DEL INCIDENTE EN SOLO LECTURA -->
            <div class="col-md-12 mt-3">
                <h5 class="text-secondary"><i class="bi bi-info-circle-fill"></i> Detalles del Incidente</h5>
            </div>

            <div class="col-md-4">
                <label>Usuario</label>
                <asp:TextBox ID="txtDetalleUsuario" runat="server" CssClass="form-control" ReadOnly="true" />
            </div>
            <div class="col-md-4">
                <label>Correo</label>
                <asp:TextBox ID="txtDetalleCorreo" runat="server" CssClass="form-control" ReadOnly="true" />
            </div>
            <div class="col-md-4">
                <label>Teléfono</label>
                <asp:TextBox ID="txtDetalleTelefono" runat="server" CssClass="form-control" ReadOnly="true" />
            </div>

            <!-- CAMPOS PARA ACTUALIZAR -->
            <div class="col-md-6 mt-4">
                <label for="txtCausa">Causa</label>
                <asp:TextBox ID="txtCausa" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvCausa" runat="server" ControlToValidate="txtCausa" ErrorMessage="* Campo requerido" CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="col-md-6 mt-4">
                <label for="txtSolucion">Solución</label>
                <asp:TextBox ID="txtSolucion" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvSolucion" runat="server" ControlToValidate="txtSolucion" ErrorMessage="* Campo requerido" CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="col-md-4">
                <label for="txtFechaS">Fecha de Solución</label>
                <asp:TextBox ID="txtFechaS" runat="server" CssClass="form-control" TextMode="Date" />
                <asp:RequiredFieldValidator ID="rfvFechaS" runat="server" ControlToValidate="txtFechaS" ErrorMessage="* Requerido" CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="col-md-4">
                <label for="txtHoras">Horas de trabajo</label>
                <asp:TextBox ID="txtHoras" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvHoras" runat="server" ControlToValidate="txtHoras" ErrorMessage="* Requerido" CssClass="validation-error" Display="Dynamic" />
            </div>

            <div class="col-md-4">
                <label for="txtRepuesto">Costo Repuestos ₡</label>
                <asp:TextBox ID="txtRepuesto" runat="server" CssClass="form-control" />
            </div>

            <div class="col-md-6">
                <label for="ddlEstado">Estado</label>
                <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control">
                    <asp:ListItem Text="-- Seleccione --" Value="" />
                    <asp:ListItem Text="En Proceso" Value="En Proceso" />
                    <asp:ListItem Text="Cerrado" Value="Cerrado" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvEstado" runat="server" ControlToValidate="ddlEstado" InitialValue="" ErrorMessage="* Requerido" CssClass="validation-error" Display="Dynamic" />
            </div>
        </div>

        <!-- BOTONES -->
        <div class="text-center mt-4 btn-group-custom">
            <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btn-success" OnClick="btnActualizar_Click" />
            <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn btn-secondary" OnClick="btnLimpiar_Click" />
        </div>

        <hr class="my-5" />

        <!-- TABLA DE SOLUCIONES -->
        <h4 class="text-primary mb-3">Historial de Soluciones</h4>
        <div class="mb-3">
            <label for="ddlFiltroEstado">Filtrar por Estado</label>
            <asp:DropDownList ID="ddlFiltroEstado" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFiltroEstado_SelectedIndexChanged" CssClass="form-control w-50">
                <asp:ListItem Text="Todos" Value="" />
                <asp:ListItem Text="En Proceso" Value="En Proceso" />
                <asp:ListItem Text="Cerrado" Value="Cerrado" />
            </asp:DropDownList>
        </div>

        <div class="table-responsive">
            <asp:GridView ID="gvSoluciones" runat="server" CssClass="table table-bordered table-hover table-striped"
                AutoGenerateColumns="True" GridLines="None" />
        </div>

        <div class="mt-3 text-end">
            <strong>Total General: </strong>
            <asp:Literal ID="litTotalGeneral" runat="server" />
        </div>
    </div>
</asp:Content>
