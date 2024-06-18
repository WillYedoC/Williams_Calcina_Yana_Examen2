using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DatosE
{
    public class Class1
    {
        public DataSet Alumno()
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = "server=DESKTOP-JGDQVEO\\SQLEXPRESS;user id=prueba;password=123456;database=School";
            SqlDataAdapter ada = new SqlDataAdapter();
            ada.SelectCommand = new SqlCommand();
            ada.SelectCommand.Connection = conn;
            ada.SelectCommand.CommandText = "select * from alumnos where id_alumno=1";
            DataSet ds = new DataSet();
            ada.Fill(ds);
            return ds;
        }
    }
}
