using System;

namespace PROYECTOFINAL.Forms
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["cedula"] == null || Session["nivel"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            string cedula = Session["cedula"].ToString();
            int nivel = Convert.ToInt32(Session["nivel"]);

            switch (nivel)
            {
                case 1:
                    // Usuario básico
                    panelUsuario.Visible = true;
                    break;

                case 2:
                    // Técnico
                    panelTecnico.Visible = true;
                    break;

                case 3:
                    // Admin
                    panelAdmin.Visible = true;
                    break;

                default:
                    Response.Redirect("~/Login.aspx");
                    return;
            }

            Response.Write($"<script>console.log('Bienvenido: {cedula}');</script>");
        }
    }
}
