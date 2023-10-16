using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LP3TP1
{
    public partial class GestionarCobranzas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Cargar datos iniciales en el GridView
                CargarDatos();
            }

        }

        protected void TextBoxFecha_TextChanged(object sender, EventArgs e)
        {
            // Al cambiar la fecha, recargar los datos
            CargarDatos();
        }

        private void CargarDatos()
        {
            // Recargar el GridView
            GridViewCobranzas.DataBind();
        }

        /*
         * 
         
         */

        protected void agregarCobranza_Click(object sender, EventArgs e)
        {
            //ACA TAMBIEN VA A IR LA CLASE STREAMWRITER PARA EL BLOCK DE NOTAS.
            

            string fecha = txbFecha.Text;
            string monto = txbMonto.Text;
            string cliente = DDLForanea.SelectedValue.ToString();


            if (string.IsNullOrWhiteSpace(fecha) || string.IsNullOrWhiteSpace(monto) || string.IsNullOrWhiteSpace(cliente))
            {
                // Muestra una advertencia si uno o ambos campos están vacíos
                string script = "alert('Por favor, completa todos los campos.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
            }
            else
            {
                sqlCobranzas.InsertParameters["fecha"].DefaultValue = txbFecha.Text;
                sqlCobranzas.InsertParameters["monto"].DefaultValue = txbMonto.Text;
                sqlCobranzas.InsertParameters["idClienteForanea"].DefaultValue = DDLForanea.SelectedValue;

                int resultado = sqlCobranzas.Insert();

                if (resultado != 0)
                {
                    // Éxito en la inserción
                    string successScript = "alert('Cliente registrado correctamente.');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlSuccessScript", successScript, true);
                    limpiarCasillas();
                }
                else
                {
                    // Error en la inserción
                    string errorScript = "alert('Error en el registro del cliente.');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlErrorScript", errorScript, true);
                }
            }
        }

        protected void limpiarCasillas()
        {
            txbFecha.Text = string.Empty;
            txbMonto.Text = string.Empty;
            DDLForanea.SelectedIndex = 0;
        }

        protected void btnCancelarCliente_Click(object sender, EventArgs e)
        {
            limpiarCasillas();
        }

        protected void btnVolverMenuInicio_Click(object sender, EventArgs e)
        {
            Response.Redirect("MenuInicio.aspx");
        }
    }
}