using System;

namespace PROYECTOFINAL.Forms
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Validar sesión
            if (Session["usuario"] == null || Session["nivel"] == null)
            {
                Response.Redirect("~/Forms/Login.aspx");
                return;
            }

            // Lógica basada en nivel de usuario
            string usuario = Session["usuario"].ToString();
            int nivel = Convert.ToInt32(Session["nivel"]);

            // Puedes hacer algo diferente por tipo de usuario si lo deseas
            switch (nivel)
            {
                case 1:
                    // Usuario nivel 1 (Naranja): acceso solo a Contactos e Incidentes
                    Response.Write("<script>console.log('Usuario nivel 1: acceso limitado');</script>");
                    break;

                case 2:
                    // Usuario nivel 2 (Verde): técnico, acceso a soluciones
                    Response.Write("<script>console.log('Usuario técnico: acceso técnico');</script>");
                    break;

                case 3:
                    // Usuario nivel 3 (Morado): administrador, acceso total
                    Response.Write("<script>console.log('Usuario administrador: acceso completo');</script>");
                    break;

                default:
                    // Nivel inválido
                    Response.Redirect("~/Forms/Login.aspx");
                    break;
            }

            // Saludo en consola
            Response.Write($"<script>console.log('Bienvenido: {usuario}');</script>");
        }
    }
}
