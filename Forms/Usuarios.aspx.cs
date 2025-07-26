using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PROYECTOFINAL.Forms
{
    public partial class Usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarUsuarios();
            }
        }

        // Cargar todos los usuarios en el GridView
        private void CargarUsuarios()
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "SELECT usuario, nombre, clave, nivel, salario FROM usuarios";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvUsuarios.DataSource = dt;
                gvUsuarios.DataBind();
            }
        }

        // Insertar nuevo usuario
        protected void btnInsertar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            string usuario = txtUsuario.Text.Trim();
            string nombre = txtNombre.Text.Trim();
            string clave = txtClave.Text.Trim();
            int nivel = int.Parse(ddlNivel.SelectedValue);
            decimal salario = string.IsNullOrEmpty(txtSalario.Text) ? 0 : Convert.ToDecimal(txtSalario.Text);

            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "INSERT INTO usuarios (usuario, nombre, clave, nivel, salario) VALUES (@usuario, @nombre, @clave, @nivel, @salario)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@usuario", usuario);
                cmd.Parameters.AddWithValue("@nombre", nombre);
                cmd.Parameters.AddWithValue("@clave", clave);
                cmd.Parameters.AddWithValue("@nivel", nivel);
                cmd.Parameters.AddWithValue("@salario", salario);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            CargarUsuarios();
            LimpiarFormulario();
        }

        // Modificar usuario existente
        protected void btnModificar_Click(object sender, EventArgs e)
        {
            if (gvUsuarios.SelectedIndex < 0) return;
            string usuario = txtUsuario.Text.Trim();
            string nombre = txtNombre.Text.Trim();
            string clave = txtClave.Text.Trim();
            int nivel = int.Parse(ddlNivel.SelectedValue);
            decimal salario = string.IsNullOrEmpty(txtSalario.Text) ? 0 : Convert.ToDecimal(txtSalario.Text);

            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "UPDATE usuarios SET nombre = @nombre, clave = @clave, nivel = @nivel, salario = @salario WHERE usuario = @usuario";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@usuario", usuario);
                cmd.Parameters.AddWithValue("@nombre", nombre);
                cmd.Parameters.AddWithValue("@clave", clave);
                cmd.Parameters.AddWithValue("@nivel", nivel);
                cmd.Parameters.AddWithValue("@salario", salario);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            CargarUsuarios();
            LimpiarFormulario();
        }

        // Eliminar usuario seleccionado
        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            if (gvUsuarios.SelectedIndex < 0) return;
            string usuario = txtUsuario.Text.Trim();
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "DELETE FROM usuarios WHERE usuario = @usuario";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@usuario", usuario);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            CargarUsuarios();
            LimpiarFormulario();
        }

        // Cargar datos del usuario seleccionado en el formulario
        protected void gvUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtUsuario.Text = gvUsuarios.SelectedRow.Cells[0].Text;
            txtNombre.Text = gvUsuarios.SelectedRow.Cells[1].Text;
            txtClave.Text = gvUsuarios.SelectedRow.Cells[2].Text;
            ddlNivel.SelectedValue = gvUsuarios.SelectedRow.Cells[3].Text;
            txtSalario.Text = gvUsuarios.SelectedRow.Cells[4].Text;
        }

        // Limpiar los campos
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }

        private void LimpiarFormulario()
        {
            txtUsuario.Text = "";
            txtNombre.Text = "";
            txtClave.Text = "";
            ddlNivel.SelectedIndex = 0;
            txtSalario.Text = "";
            gvUsuarios.SelectedIndex = -1;
        }
    }
}
