using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace AbonelikWeb
{
    public partial class AbonelikSil : System.Web.UI.Page
    {
        int kullanici_id, dergi_id, dergi_iptal;
        string kullanici_ad, isim, soyisim;
        

        SqlConnection baglanti = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["baglanti"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            kullanici_id = Convert.ToInt32(Request.QueryString["id"]);
            dergi_id = Convert.ToInt32(Request.QueryString["dergi"]);
            

            ////////////// Kullanıcı bilgileri
            baglanti.Open();
            SqlCommand komut = new SqlCommand();
            SqlDataReader dr;
            komut.CommandText = "SELECT kullanici_ad,isim,soyisim From Kullanicilar where id=" + kullanici_id.ToString();
            komut.Connection = baglanti;
            dr = komut.ExecuteReader();
            if (dr.Read())
            {
                kullanici_ad = dr[0].ToString();
                isim = dr[1].ToString();
                soyisim = dr[2].ToString();
                dr.Close();
            }
            baglanti.Close();

            Label1.Text = isim + " " + soyisim + " (" + kullanici_ad + ")";


            ///////// ABONELİĞİN TAAHUTU BİTTİ Mİ KONTROL : bitmişse silinen abonelik gidecek. bitmemişse iptal aboneliğe gidecek
            baglanti.Open();
            SqlCommand komut2 = new SqlCommand();
            SqlDataReader dr2;
            komut2.CommandText = "select DATEDIFF(day,GETDATE(), DATEADD(day,taahut_gun,baslangic_tarih)) from Abonelik where kullanici_id=" + kullanici_id.ToString()+ " and dergi_id=" + dergi_id.ToString()+" and taahut_gun>=DATEDIFF(day,baslangic_tarih,GETDATE())";
            komut2.Connection = baglanti;
            dr2 = komut2.ExecuteReader();

            if (dr2.HasRows)
            {
                while (dr2.Read())
                {
                   if( dr2[0] != null)
                    { 
                    Label2.Text = "ABONELİK İPTALİ (Taahütünüz Bitmediği için) , Kalan Gün : " + dr2[0].ToString() + " .Bu zamana kadar dergiyi normal fiyattan aldığınız hesap edilirse, ";
                    Label3.Text = "Not :aboneliği iptal ederseniz, iptal aboneliklerim sayfasından, bu zamana kadar ki sayıları görebileceksiniz.";
                    dergi_iptal = 1; // işlem kontrolü 
                    }

                }
            }
            else
            {
                Label2.Text = "ABONELİK SİLİNMESİ ";
                Label3.Text = "(Biten aboneliği Onaylarsanız yeniden abonelik Alabilirsiniz. Bu Aboneliğinizin sayılarına, silinen klasöründen erişebileceksiniz.)";
                dergi_iptal = 0; // işlem kontrolü 

            }

            dr2.Close();
            baglanti.Close();

            baglanti.Open();
            if (dergi_iptal == 1)
            {
                SqlCommand komut3 = new SqlCommand();
                SqlDataReader dr3;
                komut3.CommandText = "SP_Geri_Ucret_Arama";
                komut3.Parameters.AddWithValue("@kullanici_id", kullanici_id);
                komut3.Parameters.AddWithValue("@dergi_id", dergi_id);
                komut3.CommandType = System.Data.CommandType.StoredProcedure;
                komut3.Connection = baglanti;
                dr3 = komut3.ExecuteReader();

                double geri_ucret=0;
                if (dr3.HasRows)
                {
                    while (dr3.Read())
                    {
                        geri_ucret =Convert.ToDouble(dr3[0]);
                    }
                Label2.Text = Label2.Text + geri_ucret.ToString()+" TL iade edilecektir(gün başına hesap).";
                }
                dr3.Close();
            }
            
            baglanti.Close();
        }

        public void button_onayla(object sender, EventArgs e)
        {
            baglanti.Open();
            SqlCommand komut4 = new SqlCommand("Delete From Abonelik where kullanici_id=@kullanici_id and dergi_id=@dergi_id", baglanti);

            komut4.Parameters.AddWithValue("@kullanici_id", kullanici_id);
            komut4.Parameters.AddWithValue("@dergi_id", dergi_id);

            komut4.ExecuteNonQuery();

            Response.Write("<script LANGUAGE='JavaScript' >alert('Abonelik Silme/iptal işlemi uygulandı.')</script>");
            baglanti.Close();
            Response.Redirect("Aboneliklerim.aspx?id=" + kullanici_id);

        }








    }
}