using PROYECTOFINAL.WebServices;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PROYECTOFINAL.Forms
{
    public partial class Solucion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarIncidentes();
                CargarSoluciones();
            }
        }

        private void CargarIncidentes()
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "SELECT id, descripcion FROM incidentes WHERE status <> 'Cerrado'";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();

                ddlIncidente.DataSource = cmd.ExecuteReader();
                ddlIncidente.DataTextField = "descripcion";
                ddlIncidente.DataValueField = "id";
                ddlIncidente.DataBind();
                ddlIncidente.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione --", ""));
            }
        }

        protected void ddlIncidente_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlIncidente.SelectedValue == "") return;

            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "SELECT usuario, correo, telefono FROM incidentes WHERE id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", ddlIncidente.SelectedValue);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtDetalleUsuario.Text = reader["usuario"].ToString();
                    txtDetalleCorreo.Text = reader["correo"].ToString();
                    txtDetalleTelefono.Text = reader["telefono"].ToString();
                }
            }
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid || ddlIncidente.SelectedValue == "")
            {
                MostrarAlerta("Error", "Debe seleccionar un incidente y llenar todos los campos obligatorios.", "error");
                return;
            }

            try
            {
                string causa = txtCausa.Text.Trim();
                string solucion = txtSolucion.Text.Trim();
                string fechaS = txtFechaS.Text;
                int horas = int.Parse(txtHoras.Text);
                decimal.TryParse(txtRepuesto.Text, out decimal repuesto);
                string estado = ddlEstado.SelectedValue;
                string tecnico = Session["usuario"] != null ? Session["usuario"].ToString() : "Técnico";

                // Obtener salario
                decimal salario = ObtenerSalario(tecnico);

                // Cálculos
                var ws = new ServiciosIncidente();
                decimal manoObra = ws.met_ManoObra(horas, salario);
                decimal total = ws.met_CostoTotal(manoObra, repuesto);

                string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(cadena))
                {
                    string query = @"UPDATE incidentes SET 
                                    causa = @causa,
                                    solucion = @solucion,
                                    fechas = @fechaS,
                                    horas = @horas,
                                    repuesto = @repuesto,
                                    status = @estado,
                                    tecnico = @tecnico,
                                    salario = @salario,
                                    manoobra = @mano,
                                    total = @total
                                    WHERE id = @id";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@causa", causa);
                    cmd.Parameters.AddWithValue("@solucion", solucion);
                    cmd.Parameters.AddWithValue("@fechaS", fechaS);
                    cmd.Parameters.AddWithValue("@horas", horas);
                    cmd.Parameters.AddWithValue("@repuesto", repuesto);
                    cmd.Parameters.AddWithValue("@estado", estado);
                    cmd.Parameters.AddWithValue("@tecnico", tecnico);
                    cmd.Parameters.AddWithValue("@salario", salario);
                    cmd.Parameters.AddWithValue("@mano", manoObra);
                    cmd.Parameters.AddWithValue("@total", total);
                    cmd.Parameters.AddWithValue("@id", ddlIncidente.SelectedValue);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                CargarSoluciones();
                MostrarAlerta("Éxito", "Incidente actualizado correctamente.", "success");
                LimpiarFormulario();
            }
            catch (Exception ex)
            {
                MostrarAlerta("Error", "Hubo un error: " + ex.Message, "error");
            }
        }

        private decimal ObtenerSalario(string usuario)
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "SELECT salario FROM usuarios WHERE usuario = @usuario";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@usuario", usuario);
                conn.Open();
                object result = cmd.ExecuteScalar();

                if (result == null || result == DBNull.Value)
                {
                    MostrarAlerta("Advertencia", "El técnico no tiene salario registrado. Se usará ₡0.", "warning");
                    return 0;
                }

                return Convert.ToDecimal(result);
            }
        }

        private void CargarSoluciones(string estadoFiltro = "")
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = @"SELECT descripcion AS Incidente, tecnico AS Técnico, status AS Estado, fechas AS FechaSolución, total AS Total 
                                 FROM incidentes 
                                 WHERE status <> 'Pendiente'";

                if (!string.IsNullOrEmpty(estadoFiltro))
                    query += " AND status = @estado";

                SqlCommand cmd = new SqlCommand(query, conn);
                if (!string.IsNullOrEmpty(estadoFiltro))
                    cmd.Parameters.AddWithValue("@estado", estadoFiltro);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                var table = new DataTable();
                table.Load(reader);
                gvSoluciones.DataSource = table;
                gvSoluciones.DataBind();

                // Total general
                decimal total = 0;
                foreach (DataRow row in table.Rows)
                {
                    if (decimal.TryParse(row["Total"].ToString(), out decimal t))
                        total += t;
                }

                litTotalGeneral.Text = "₡" + total.ToString("N2");
            }
        }

        protected void ddlFiltroEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            string estado = ddlFiltroEstado.SelectedValue;
            CargarSoluciones(estado);
        }

        private void LimpiarFormulario()
        {
            ddlIncidente.SelectedIndex = 0;
            ddlEstado.SelectedIndex = 0;

            txtCausa.Text = "";
            txtSolucion.Text = "";
            txtFechaS.Text = "";
            txtHoras.Text = "";
            txtRepuesto.Text = "";

            // Campos de solo lectura (datos del incidente seleccionado)
            txtDetalleUsuario.Text = "";
            txtDetalleCorreo.Text = "";
            txtDetalleTelefono.Text = "";

            gvSoluciones.SelectedIndex = -1;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }


        private void MostrarAlerta(string titulo, string mensaje, string icono)
        {
            string script = $@"
                Swal.fire({{
                    title: '{titulo}',
                    text: '{mensaje}',
                    icon: '{icono}',
                    confirmButtonColor: '#3085d6',
                    confirmButtonText: 'OK'
                }});";
            ScriptManager.RegisterStartupScript(this, GetType(), "Alerta", script, true);
        }
    }
}
