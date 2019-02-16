using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace AbonelikWeb
{
    public partial class Giris : System.Web.UI.Page
    {
        SqlConnection baglanti = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["baglanti"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        public void button_giris(Object sender,EventArgs e) {

            baglanti.Open();
            SqlCommand komut = new SqlCommand();
            SqlDataReader dr;
            komut.CommandText = "SELECT id FROM Kullanicilar WHERE kullanici_ad='" + kullanici_ad.Text.ToString() + "' AND kullanici_sifre='" + kullanici_sifre.Text.ToString()+"'";
            komut.Connection = baglanti;

            try
            {
                dr = komut.ExecuteReader();
                if (dr.Read())
                {
                    
                    Response.Write("<script LANGUAGE='JavaScript' >alert('Giriş Başarılı')</script>");
                    string id = dr[0].ToString();
                    Response.Redirect("index.aspx?id=" + id);
                    //Server.Transfer("index.aspx?id=" + id);
                    dr.Close();
                    
                }
                else
                {
                    Response.Write("<script LANGUAGE='JavaScript' >alert('Kayıtlı Kullanici Bulunamadı. Bilgilerinizi tekrar kontrol ediniz.')</script>");
                }
                
            }
            catch (Exception ex)
            {
                 Response.Write("<script LANGUAGE='JavaScript' >alert('Hata Bulundu : "+ex.Message+"')</script>");   
            }
            finally
            {
                baglanti.Close();
            }
        }

    }
}