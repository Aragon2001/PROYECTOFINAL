using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PROYECTOFINAL.Forms
{
    public partial class Departamentos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarGrid(); // Cargar todos los departamentos al cargar la página
            }
        }

        // Cargar departamentos en el GridView
        private void CargarGrid()
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "SELECT id, nombre FROM departamentos";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvDepartamentos.DataSource = dt;
                gvDepartamentos.DataBind();
            }
        }

        // Insertar un nuevo departamento
        protected void btnInsertar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            string nombre = txtNombre.Text.Trim();
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "INSERT INTO departamentos (nombre) VALUES (@nombre)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@nombre", nombre);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            CargarGrid();
            LimpiarFormulario();
        }

        // Modificar departamento seleccionado
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (gvDepartamentos.SelectedIndex < 0) return;
            string nombre = txtNombre.Text.Trim();
            string id = gvDepartamentos.SelectedRow.Cells[0].Text;
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "UPDATE departamentos SET nombre = @nombre WHERE id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@nombre", nombre);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            CargarGrid();
            LimpiarFormulario();
        }

        // Eliminar departamento seleccionado
        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            if (gvDepartamentos.SelectedIndex < 0) return;
            string id = gvDepartamentos.SelectedRow.Cells[0].Text;
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "DELETE FROM departamentos WHERE id = @id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            CargarGrid();
            LimpiarFormulario();
        }

        // Seleccionar fila del GridView
        protected void gvDepartamentos_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtNombre.Text = gvDepartamentos.SelectedRow.Cells[1].Text;
        }

        // Limpiar campos
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }

        private void LimpiarFormulario()
        {
            txtNombre.Text = "";
            gvDepartamentos.SelectedIndex = -1;
        }
    }
}
