using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LP3TP1
{
    public partial class GestionarClientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAgregarCliente_Click(object sender, EventArgs e)
        {
            string nombreCliente = txbNombreCliente.Text;
            string apellidoCliente = txbApellidoCliente.Text;

            // Verifica si los campos están vacíos
            if (string.IsNullOrWhiteSpace(nombreCliente) || string.IsNullOrWhiteSpace(apellidoCliente))
            {
                // Muestra una advertencia si uno o ambos campos están vacíos
                string script = "alert('Por favor, completa todos los campos.');";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);
            }
            else
            {
                // Los campos no están vacíos, procede con la inserción
                SqlDataInsertar.InsertParameters["nombre"].DefaultValue = nombreCliente;
                SqlDataInsertar.InsertParameters["apellido"].DefaultValue = apellidoCliente;

                int resultado = SqlDataInsertar.Insert();

                if (resultado != 0)
                {
                    // Éxito en la inserción
                    string successScript = "alert('Cliente registrado correctamente.');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlSuccessScript", successScript, true);
                }
                else
                {
                    // Error en la inserción
                    string errorScript = "alert('Error en el registro del cliente.');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlErrorScript", errorScript, true);
                }
            }
        }


        protected void btnCancelarCliente_Click(object sender, EventArgs e)
        {
            limpiarTxb();
        }


        protected void limpiarTxb()
        {
            txbNombreCliente.Text = string.Empty;
            txbApellidoCliente.Text = string.Empty;
        }

        protected void btnVolverMenuInicio_Click(object sender, EventArgs e)
        {
            Response.Redirect("MenuInicio.aspx");
        }
    }
}