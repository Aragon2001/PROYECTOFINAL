using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROYECTOFINAL.Forms
{
    public partial class Usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarUsuarios();
                CargarRoles();
            }
        }

        private void CargarUsuarios()
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            string query = @"SELECT u.cedula, u.nombre, u.apellido1, u.apellido2, 
                             u.correo, u.telefono, u.clave, u.salario, r.nombre AS rol
                             FROM USUARIOS u
                             INNER JOIN ROLES r ON u.rol_id = r.id";

            using (SqlConnection conn = new SqlConnection(cadena))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvUsuarios.DataSource = dt;
                gvUsuarios.DataBind();
            }
        }

        private void CargarRoles()
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            string query = "SELECT id, nombre FROM ROLES";

            using (SqlConnection conn = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                ddlRol.DataSource = cmd.ExecuteReader();
                ddlRol.DataTextField = "nombre";
                ddlRol.DataValueField = "id";
                ddlRol.DataBind();
                ddlRol.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione --", ""));
            }
        }

        protected void btnInsertar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid || ddlRol.SelectedValue == "")
            {
                MostrarAlerta("Error", "Complete todos los campos requeridos.", "error");
                return;
            }

            string cedula = txtCedula.Text.Trim();
            string nombre = txtNombre.Text.Trim();
            string apellido1 = txtApellido1.Text.Trim();
            string apellido2 = txtApellido2.Text.Trim();
            string correo = txtCorreo.Text.Trim();
            string telefono = txtTelefono.Text.Trim();
            string clave = txtClave.Text.Trim();
            decimal salario = ConvertirSalario(txtSalario.Text);
            int rol_id = int.Parse(ddlRol.SelectedValue);

            try
            {
                string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
                string query = @"INSERT INTO USUARIOS 
                                 (cedula, nombre, apellido1, apellido2, correo, telefono, clave, salario, rol_id)
                                 VALUES 
                                 (@cedula, @nombre, @apellido1, @apellido2, @correo, @telefono, @clave, @salario, @rol_id)";

                using (SqlConnection conn = new SqlConnection(cadena))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@cedula", cedula);
                    cmd.Parameters.AddWithValue("@nombre", nombre);
                    cmd.Parameters.AddWithValue("@apellido1", apellido1);
                    cmd.Parameters.AddWithValue("@apellido2", apellido2);
                    cmd.Parameters.AddWithValue("@correo", correo);
                    cmd.Parameters.AddWithValue("@telefono", telefono);
                    cmd.Parameters.AddWithValue("@clave", clave);
                    cmd.Parameters.AddWithValue("@salario", salario);
                    cmd.Parameters.AddWithValue("@rol_id", rol_id);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                CargarUsuarios();
                LimpiarFormulario();
                MostrarAlerta("Éxito", "Usuario registrado correctamente.", "success");
            }
            catch (Exception ex)
            {
                MostrarAlerta("Error", "Error al insertar: " + ex.Message, "error");
            }
        }

        protected void gvUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gvUsuarios.SelectedRow;
            txtCedula.Text = row.Cells[0].Text;
            txtNombre.Text = row.Cells[1].Text;
            txtApellido1.Text = row.Cells[2].Text;
            txtApellido2.Text = row.Cells[3].Text;
            txtCorreo.Text = row.Cells[4].Text;
            txtTelefono.Text = row.Cells[5].Text;
            txtClave.Text = row.Cells[6].Text;
            txtSalario.Text = row.Cells[7].Text;
            ddlRol.SelectedValue = ObtenerRolId(row.Cells[8].Text).ToString();

            txtCedula.Enabled = false; // Evitar modificar cédula (clave primaria)
        }

        private int ObtenerRolId(string rolNombre)
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            string query = "SELECT id FROM ROLES WHERE nombre = @nombre";

            using (SqlConnection conn = new SqlConnection(cadena))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@nombre", rolNombre);
                conn.Open();
                object result = cmd.ExecuteScalar();
                return result != null ? Convert.ToInt32(result) : 0;
            }
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            string cedula = txtCedula.Text.Trim();

            if (string.IsNullOrEmpty(cedula))
            {
                MostrarAlerta("Error", "Seleccione un usuario para modificar.", "warning");
                return;
            }

            string nombre = txtNombre.Text.Trim();
            string apellido1 = txtApellido1.Text.Trim();
            string apellido2 = txtApellido2.Text.Trim();
            string correo = txtCorreo.Text.Trim();
            string telefono = txtTelefono.Text.Trim();
            string clave = txtClave.Text.Trim();
            decimal salario = ConvertirSalario(txtSalario.Text);
            int rol_id = int.Parse(ddlRol.SelectedValue);

            try
            {
                string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
                string query = @"UPDATE USUARIOS SET 
                                nombre = @nombre,
                                apellido1 = @apellido1,
                                apellido2 = @apellido2,
                                correo = @correo,
                                telefono = @telefono,
                                clave = @clave,
                                salario = @salario,
                                rol_id = @rol_id
                                WHERE cedula = @cedula";

                using (SqlConnection conn = new SqlConnection(cadena))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@cedula", cedula);
                    cmd.Parameters.AddWithValue("@nombre", nombre);
                    cmd.Parameters.AddWithValue("@apellido1", apellido1);
                    cmd.Parameters.AddWithValue("@apellido2", apellido2);
                    cmd.Parameters.AddWithValue("@correo", correo);
                    cmd.Parameters.AddWithValue("@telefono", telefono);
                    cmd.Parameters.AddWithValue("@clave", clave);
                    cmd.Parameters.AddWithValue("@salario", salario);
                    cmd.Parameters.AddWithValue("@rol_id", rol_id);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                CargarUsuarios();
                LimpiarFormulario();
                MostrarAlerta("Modificado", "Usuario actualizado correctamente.", "success");
            }
            catch (Exception ex)
            {
                MostrarAlerta("Error", "Error al modificar: " + ex.Message, "error");
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            string cedula = txtCedula.Text.Trim();

            if (string.IsNullOrEmpty(cedula))
            {
                MostrarAlerta("Error", "Seleccione un usuario para eliminar.", "warning");
                return;
            }

            try
            {
                string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
                string query = "DELETE FROM USUARIOS WHERE cedula = @cedula";

                using (SqlConnection conn = new SqlConnection(cadena))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@cedula", cedula);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                CargarUsuarios();
                LimpiarFormulario();
                MostrarAlerta("Eliminado", "Usuario eliminado correctamente.", "success");
            }
            catch (Exception ex)
            {
                MostrarAlerta("Error", "Error al eliminar: " + ex.Message, "error");
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
        }

        private void LimpiarFormulario()
        {
            txtCedula.Text = "";
            txtCedula.Enabled = true;
            txtNombre.Text = "";
            txtApellido1.Text = "";
            txtApellido2.Text = "";
            txtCorreo.Text = "";
            txtTelefono.Text = "";
            txtClave.Text = "";
            txtSalario.Text = "";
            ddlRol.SelectedIndex = 0;
            gvUsuarios.SelectedIndex = -1;
        }

        private decimal ConvertirSalario(string input)
        {
            if (string.IsNullOrWhiteSpace(input)) return 0;
            string limpio = input.Replace("₡", "").Replace(",", "").Replace(" ", "").Replace(" ", "");
            return decimal.TryParse(limpio, out decimal result) ? result : 0;
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
