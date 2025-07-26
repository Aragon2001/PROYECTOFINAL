using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PROYECTOFINAL.Forms
{
    public partial class Tipos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Cargar los datos solo la primera vez
            if (!IsPostBack)
            {
                CargarTipos();
            }
        }

        // Método para llenar el GridView con los tipos actuales
        private void CargarTipos()
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "SELECT id, descripcion FROM tipos";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvTipos.DataSource = dt;
                gvTipos.DataBind();
            }
        }

        // Insertar un nuevo tipo en la base de datos
        protected void btnInsertar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            string descripcion = txtDescripcion.Text.Trim();
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "INSERT INTO tipos (descripcion) VALUES (@descripcion)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@descripcion", descripcion);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            CargarTipos();
            LimpiarFormulario();
        }

        // Modificar el tipo seleccionado
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (gvTipos.SelectedIndex < 0) return;
            string descripcion = txtDescripcion.Text.Trim();
            string id = gvTipos.SelectedRow.Cells[0].Text;
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "UPDATE tipos SET descripcion = @descripcion WHERE id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@descripcion", descripcion);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            CargarTipos();
            LimpiarFormulario();
        }

        // Eliminar el tipo seleccionado
        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            if (gvTipos.SelectedIndex < 0) return;
            string id = gvTipos.SelectedRow.Cells[0].Text;
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "DELETE FROM tipos WHERE id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            CargarTipos();
            LimpiarFormulario();
        }

        // Llenar el campo de texto al seleccionar una fila
        protected void gvTipos_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtDescripcion.Text = gvTipos.SelectedRow.Cells[1].Text;
        }

        // Limpiar los controles del formulario
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }

        private void LimpiarFormulario()
        {
            txtDescripcion.Text = "";
            gvTipos.SelectedIndex = -1;
        }
    }
}
