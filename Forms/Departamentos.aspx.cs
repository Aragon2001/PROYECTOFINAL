using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace PROYECTOFINAL.Forms
{
    public partial class Departamentos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarGrid();
            }
        }

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

        protected void btnInsertar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                MostrarAlerta("Error", "Debe completar el nombre del departamento.", "error");
                return;
            }

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
            MostrarAlerta("Insertado", "Departamento agregado correctamente.", "success");
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (gvDepartamentos.SelectedIndex < 0)
            {
                MostrarAlerta("Error", "Seleccione un departamento para modificar.", "warning");
                return;
            }

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
            MostrarAlerta("Modificado", "Departamento actualizado correctamente.", "success");
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            if (gvDepartamentos.SelectedIndex < 0)
            {
                MostrarAlerta("Error", "Seleccione un departamento para eliminar.", "warning");
                return;
            }

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
            MostrarAlerta("Eliminado", "Departamento eliminado correctamente.", "success");
        }

        protected void gvDepartamentos_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtNombre.Text = gvDepartamentos.SelectedRow.Cells[1].Text;
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }

        private void LimpiarFormulario()
        {
            txtNombre.Text = "";
            gvDepartamentos.SelectedIndex = -1;
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
