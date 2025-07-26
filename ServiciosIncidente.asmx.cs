using System;
using System.Web.Services;

namespace PROYECTOFINAL.WebServices
{
    [WebService(Namespace = "http://elzapatero.uaca/ws")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class ServiciosIncidente : WebService
    {
        public ServiciosIncidente() { }

        [WebMethod(Description = "Calcula el valor de la mano de obra (horas * salario por hora)")]
        public decimal met_ManoObra(int horas, decimal salario)
        {
            if (horas < 0 || salario < 0)
                throw new ArgumentException("Parámetros inválidos");

            return horas * salario;
        }

        [WebMethod(Description = "Calcula el costo total (mano de obra + repuesto)")]
        public decimal met_CostoTotal(decimal manoObra, decimal repuesto)
        {
            if (manoObra < 0 || repuesto < 0)
                throw new ArgumentException("Parámetros inválidos");

            return manoObra + repuesto;
        }
    }
}
