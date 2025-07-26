using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace PROYECTOFINAL.Forms
{
    public partial class Incidentes : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtCorreo.Text = "";
                txtTelefono.Text = "";
                txtDescripcion.Text = "";

                // cargar combos
                CargarTipos();
                CargarDepartamentos();
            }
        }

        private void CargarTipos()
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "SELECT id, descripcion FROM tipos";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                ddlTipo.DataSource = cmd.ExecuteReader();
                ddlTipo.DataTextField = "descripcion";
                ddlTipo.DataValueField = "id";
                ddlTipo.DataBind();
                ddlTipo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione --", ""));
            }
        }

        private void CargarDepartamentos()
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "SELECT id, nombre FROM departamentos";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                ddlDepartamento.DataSource = cmd.ExecuteReader();
                ddlDepartamento.DataTextField = "nombre";
                ddlDepartamento.DataValueField = "id";
                ddlDepartamento.DataBind();
                ddlDepartamento.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione --", ""));
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string correo = txtCorreo.Text.Trim();
            string telefono = txtTelefono.Text.Trim();
            string descripcion = txtDescripcion.Text.Trim();
            int tipo = int.Parse(ddlTipo.SelectedValue);
            int departamento = int.Parse(ddlDepartamento.SelectedValue);
            string usuario = Session["usuario"] != null ? Session["usuario"].ToString() : "Anonimo";
            string fecha = DateTime.Now.ToString("yyyy-MM-dd");

            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = @"INSERT INTO incidentes (tipo, departamento, usuario, correo, telefono, fecha, descripcion, status)
                                 VALUES (@tipo, @departamento, @usuario, @correo, @telefono, @fecha, @descripcion, 'Pendiente')";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@tipo", tipo);
                cmd.Parameters.AddWithValue("@departamento", departamento);
                cmd.Parameters.AddWithValue("@usuario", usuario);
                cmd.Parameters.AddWithValue("@correo", correo);
                cmd.Parameters.AddWithValue("@telefono", telefono);
                cmd.Parameters.AddWithValue("@fecha", fecha);
                cmd.Parameters.AddWithValue("@descripcion", descripcion);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Incidente registrado correctamente');</script>");
                    txtCorreo.Text = "";
                    txtTelefono.Text = "";
                    txtDescripcion.Text = "";
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error al registrar: " + ex.Message + "');</script>");
                }
            }
        }
    }
}
