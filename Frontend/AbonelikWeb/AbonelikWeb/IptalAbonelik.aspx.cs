using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Text;

namespace AbonelikWeb
{
    public partial class IptalAbonelik : System.Web.UI.Page
    {
        int kullanici_id;
        string kullanici_ad, isim, soyisim;
        StringBuilder tablo = new StringBuilder();

        SqlConnection baglanti = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["baglanti"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            kullanici_id = Convert.ToInt32(Request.QueryString["id"]);

            /////////////// Kullanıcı Bilgileri
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
            Label2.Text = "Iptal Abonelikler : ";


            ///////////// Silinen_Abonelikleri Getirme.

            baglanti.Open();


            SqlCommand komut2 = new SqlCommand();
            SqlDataReader dr2;
            komut2.CommandText = "select a.abonelik_id,d.ad,a.baslangic_tarih,a.iptal_tarih,a.asil_bitis_tarihi from Iptal_Abonelik a inner join dergi d on a.dergi_id=d.id where a.kullanici_id=" + kullanici_id.ToString();
            komut2.Connection = baglanti;
            dr2 = komut2.ExecuteReader();

            //tablo oluşturma

            //başlık ekleme kısmı
            tablo.Append("<table border='1'>");
            tablo.Append("<tr><th>Dergi İsmi</th><th>Başlangıç Tarih</th><th>İptal Tarihi</th><th>Anlaşma Bitiş Tarihi</th></tr>");

            //tabloya dinamik satır ekleme kısmı
            if (dr2.HasRows)
            {
                while (dr2.Read())
                {

                    tablo.Append("<tr>");
                    tablo.Append("<td>" + dr2[1] + "</td>");
                    tablo.Append("<td>" + dr2[2] + "</td>");
                    tablo.Append("<td>" + dr2[3] + "</td>");
                    tablo.Append("<td>" + dr2[4] + "</td>");
                    tablo.Append("<td><a href=\"IptalAbonelikSayi.aspx?id=" + kullanici_id + "&abonelik=" + dr2[0] + "\">Sayilara Bak</a></td>");
                    tablo.Append("</tr>");
                }
            }
            tablo.Append("</table>");

            this.Controls.Add(new Literal { Text = tablo.ToString() });
            dr2.Close();
            baglanti.Close();

            /////////////
        }
    }
}