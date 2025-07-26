using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services.Protocols;
using PROYECTOFINAL.WebServices; // Referencia al Web Service para cálculos

namespace PROYECTOFINAL.Forms
{
    public partial class Solucion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Solo cargamos datos si no es un postback
            if (!IsPostBack)
            {
                CargarIncidentes(); // Llenar el dropdown con incidentes pendientes
            }
        }

        // Método que carga los incidentes que no están cerrados
        private void CargarIncidentes()
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "SELECT id, descripcion FROM incidentes WHERE status <> 'Cerrado'";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();

                ddlIncidente.DataSource = cmd.ExecuteReader();
                ddlIncidente.DataTextField = "descripcion";
                ddlIncidente.DataValueField = "id";
                ddlIncidente.DataBind();

                // Agregar opción inicial
                ddlIncidente.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Seleccione --", ""));
            }
        }

        // Evento cuando cambia la selección del incidente (opcional para cargar datos)
        protected void ddlIncidente_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Aquí podrías cargar información adicional del incidente si se requiere
        }

        // Evento que se ejecuta al hacer clic en "Actualizar Incidente"
        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            // Validar que se haya seleccionado un incidente
            if (ddlIncidente.SelectedValue == "") return;

            // Recolección de datos ingresados por el técnico
            string causa = txtCausa.Text;
            string solucion = txtSolucion.Text;
            string fechaS = txtFechaS.Text;
            int horas = int.Parse(txtHoras.Text);
            decimal repuesto = 0;
            decimal.TryParse(txtRepuesto.Text, out repuesto);
            string estado = ddlEstado.SelectedValue;
            string tecnico = Session["usuario"] != null ? Session["usuario"].ToString() : "Técnico";

            // Obtener salario del técnico desde la BD
            decimal salario = ObtenerSalario(tecnico);

            // Consumir el WebService para calcular la mano de obra y el total
            var ws = new ServiciosIncidente();
            decimal manoObra = ws.met_ManoObra(horas, salario);
            decimal total = ws.met_CostoTotal(manoObra, repuesto);

            // Preparar y ejecutar la actualización del incidente en la base de datos
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = @"UPDATE incidentes SET 
                                causa = @causa,
                                solucion = @solucion,
                                fechas = @fechaS,
                                horas = @horas,
                                repuesto = @repuesto,
                                status = @estado,
                                tecnico = @tecnico,
                                salario = @salario,
                                manoobra = @mano,
                                total = @total
                                WHERE id = @id";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@causa", causa);
                cmd.Parameters.AddWithValue("@solucion", solucion);
                cmd.Parameters.AddWithValue("@fechaS", fechaS);
                cmd.Parameters.AddWithValue("@horas", horas);
                cmd.Parameters.AddWithValue("@repuesto", repuesto);
                cmd.Parameters.AddWithValue("@estado", estado);
                cmd.Parameters.AddWithValue("@tecnico", tecnico);
                cmd.Parameters.AddWithValue("@salario", salario);
                cmd.Parameters.AddWithValue("@mano", manoObra);
                cmd.Parameters.AddWithValue("@total", total);
                cmd.Parameters.AddWithValue("@id", ddlIncidente.SelectedValue);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery(); // Ejecutar la actualización
                    Response.Write("<script>alert('Incidente actualizado correctamente');</script>");
                }
                catch (Exception ex)
                {
                    // Manejo de errores
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }

        // Método para obtener el salario por hora del técnico desde la base de datos
        private decimal ObtenerSalario(string usuario)
        {
            string cadena = ConfigurationManager.ConnectionStrings["ConexionServicios"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cadena))
            {
                string query = "SELECT salario FROM usuarios WHERE usuario = @usuario";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@usuario", usuario);
                conn.Open();
                object result = cmd.ExecuteScalar();

                // Retornar el salario si se encuentra, de lo contrario cero
                return result != null ? Convert.ToDecimal(result) : 0;
            }
        }
    }
}
