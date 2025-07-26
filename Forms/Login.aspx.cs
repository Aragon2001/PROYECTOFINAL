using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Linq;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
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

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string cedula = txtCedula.Text.Trim();
        string clave = txtClave.Text.Trim();

        // Validación básica de cédula
        if (cedula.Length < 9 || cedula.Length > 12 || !cedula.All(char.IsDigit))
        {
            MostrarAlerta("Cédula inválida", "Verifique el formato de su cédula.", "warning");
            return;
        }

        string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(cadena))
        {
            string query = "SELECT rol_id FROM usuarios WHERE cedula = @cedula AND clave = @clave";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@cedula", cedula);
            cmd.Parameters.AddWithValue("@clave", clave);

            try
            {
                conn.Open();
                object rol = cmd.ExecuteScalar();

                if (rol != null)
                {
                    Session["cedula"] = cedula;
                    Session["nivel"] = rol.ToString();
                    Response.Redirect("~/Forms/Dashboard.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    // Evita que se cancele el redirect por errores del ciclo de vida
                }

                else
                {
                    MostrarAlerta("Error", "Credenciales incorrectas", "error");
                }

            }
            catch (Exception ex)
            {
                MostrarAlerta("Error inesperado", ex.Message, "error");
            }
        }
    }
}
