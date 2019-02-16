using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace AbonelikWeb
{
    public partial class YeniKullanici : System.Web.UI.Page
    {
        SqlConnection baglanti = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["baglanti"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void button_kayit(Object sender, EventArgs e)
        {
            baglanti.Open();
            SqlCommand komut = new SqlCommand();
            SqlDataReader dr;
            komut.CommandText = "SELECT * FROM Kullanicilar WHERE kullanici_ad='" + kullanici_ad.Text.ToString() + "'";
            komut.Connection = baglanti;

            try
            {
                dr = komut.ExecuteReader();
                if (dr.Read())
                {
                    
                    Response.Write("<script LANGUAGE='JavaScript' >alert('Girilen Kullanıcı Bulunmakta.')</script>");
                    dr.Close();

                }
                else
                {
                    dr.Close();
                    SqlCommand komut2 = new SqlCommand("INSERT INTO Kullanicilar (kullanici_ad,kullanici_sifre,isim,soyisim,adres,e_posta,tel,tc) VALUES (@kullanici_ad,@kullanici_sifre,@isim,@soyisim,@adres,@e_posta,@tel,@tc)", baglanti);

                    komut2.Parameters.AddWithValue("@kullanici_ad", kullanici_ad.Text);
                    komut2.Parameters.AddWithValue("@kullanici_sifre", kullanici_sifre.Text);
                    komut2.Parameters.AddWithValue("@isim", isim.Text);
                    komut2.Parameters.AddWithValue("@soyisim", soyisim.Text);
                    komut2.Parameters.AddWithValue("@adres", adres.Text);
                    komut2.Parameters.AddWithValue("@e_posta", e_posta.Text);
                    komut2.Parameters.AddWithValue("@tel", telefon.Text);
                    komut2.Parameters.AddWithValue("@tc", tc.Text);

                    komut2.ExecuteNonQuery();
                    
                    Response.Write("<script LANGUAGE='JavaScript' >alert('Kullanıcı Kayıt Oldu (veri tip ve uzunluğu uygunsa.)')</script>");
                    
                    //Server.Transfer("Giris.aspx");
                    Response.Redirect("Giris.aspx",true);
                }

            }
            catch (Exception ex)
            {
                Response.Write("<script LANGUAGE='JavaScript' >alert('Hata Bulundu : " + ex.Message + "')</script>");
            }
            finally
            {
                baglanti.Close();
            }
        }
    }
}