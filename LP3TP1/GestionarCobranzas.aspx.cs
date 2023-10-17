using System;
using System.Collections.Generic;
using System.IO;
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
                    StreamWriter stw = new StreamWriter($"{Server.MapPath(".")}/RegistroDeCobranzas.txt", true);
                    stw.WriteLine("Se ha creado un nuevo cliente. Fecha y hora: " + DateTime.Now);
                    stw.Close();
                    lblResultado.Text = $"Se ha registrado un movimiento en la base de datos - tabla de cobranzas," +
                        $" block de notas creado en {Server.MapPath(".")}.";

                    // Éxito en la inserción
                    string successScript = "alert('Cobranza registrada correctamente.');";
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

        protected void btnModificar_Click(object sender, EventArgs e)
        {
            sqlCobranzas.Update();
        }


        protected void btnVolverMenuInicio_Click(object sender, EventArgs e)
        {
            Response.Redirect("MenuInicio.aspx");
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Obtener el valor de la celda para la fecha
            string fechaString = GridView1.SelectedRow.Cells[1].Text;

            // Convertir la cadena a un objeto DateTime = parsearla
            if (DateTime.TryParse(fechaString, out DateTime fecha))
            {
                // Formatear la fecha según sea necesario
                txbFecha.Text = fecha.ToString("yyyy-MM-dd");
            }
            else
            {
                // en el caso en que la conversión no sea exitosa
                // establezco un valor predeterminado o mostrar un mensaje de error
                txbFecha.Text = "Formato de fecha no válido";
            }

            // Obtener el valor de otras celdas
            txbMonto.Text = GridView1.SelectedRow.Cells[2].Text;
            DDLForanea.SelectedValue = GridView1.SelectedRow.Cells[5].Text;
        }
    }
}