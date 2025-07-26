using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Evitar error por UnobtrusiveValidation
        ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string usuario = txtUsuario.Text.Trim();
        string clave = txtClave.Text.Trim();

        string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(cadena))
        {
            string query = "SELECT nivel FROM usuarios WHERE usuario = @usuario AND clave = @clave";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@usuario", usuario);
            cmd.Parameters.AddWithValue("@clave", clave);

            try
            {
                conn.Open();
                object nivel = cmd.ExecuteScalar();

                if (nivel != null)
                {
                    Session["usuario"] = usuario;
                    Session["nivel"] = nivel.ToString();

                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Credenciales incorrectas');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }
    }
}
