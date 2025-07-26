using System;
using System.Web.UI;

namespace PROYECTOFINAL.Forms
{
    public partial class Site : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirige a Login si no hay sesión activa
            if (Session["usuario"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
        }
    }
}
