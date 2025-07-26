using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PROYECTOFINAL.Forms
{
    public partial class ConsultaIncidentes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDatos("");
            }
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            string estado = ddlEstado.SelectedValue;
            CargarDatos(estado);
        }

        private void CargarDatos(string estado)
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            string query = "SELECT id AS ID, descripcion AS Descripción, usuario AS Usuario, correo AS Correo, telefono AS Teléfono, fecha AS Fecha, status AS Estado FROM incidentes";

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

                if (dt.Rows.Count == 0)
                {
                    MostrarAlerta("Sin resultados", "No se encontraron incidentes con ese estado.", "info");
                }
            }
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
