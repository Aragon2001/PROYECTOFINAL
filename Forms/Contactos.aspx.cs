using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace PROYECTOFINAL.Forms
{
    public partial class Contactos : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (!IsPostBack)
            {
                txtFecha.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtUsuario.Text = Session["usuario"] != null ? Session["usuario"].ToString() : "Anonimo";
            }
        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            string mensaje = txtMensaje.Text.Trim();
            string fecha = txtFecha.Text;
            string email = txtEmail.Text.Trim();
            string telefono = txtTelefono.Text.Trim();
            string usuario = txtUsuario.Text;

            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = @"INSERT INTO contactos (mensaje, fecha, email, telefono, usuario)
                                 VALUES (@mensaje, @fecha, @correo, @telefono, @usuario)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@mensaje", mensaje);
                cmd.Parameters.AddWithValue("@fecha", fecha);
                cmd.Parameters.AddWithValue("@correo", email);
                cmd.Parameters.AddWithValue("@telefono", telefono);
                cmd.Parameters.AddWithValue("@usuario", usuario);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Mensaje enviado correctamente');</script>");
                    txtMensaje.Text = "";
                    txtEmail.Text = "";
                    txtTelefono.Text = "";
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error al guardar: " + ex.Message + "');</script>");
                }
            }
        }
    }
}
