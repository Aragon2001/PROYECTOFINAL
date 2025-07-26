using System;
using System.Web.UI;

public partial class Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Puedes agregar lógica de carga inicial si se requiere
    }

    protected void btnEntrar_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
}
