using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PROYECTOFINAL.Forms
{
    public partial class ConsultaIncidentes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Al cargar por primera vez, mostrar todos los datos
            if (!IsPostBack)
            {
                CargarDatos("");
            }
        }

        // Evento al presionar el botón de filtro
        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            string estado = ddlEstado.SelectedValue;
            CargarDatos(estado);
        }

        // Método que consulta incidentes según el estado
        private void CargarDatos(string estado)
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            string query = "SELECT id, descripcion, usuario, correo, telefono, fecha, status FROM incidentes";

            // Si se filtró por estado, añadir condición
            if (!string.IsNullOrEmpty(estado))
            {
                query += " WHERE status = @estado";
            }

            using (SqlConnection conn = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                if (!string.IsNullOrEmpty(estado))
                {
                    cmd.Parameters.AddWithValue("@estado", estado);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvIncidentes.DataSource = dt;
                gvIncidentes.DataBind();
            }
        }
    }
}
