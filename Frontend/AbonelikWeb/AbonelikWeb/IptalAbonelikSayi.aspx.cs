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
    public partial class IptalAbonelikSayi : System.Web.UI.Page
    {
        int kullanici_id, abonelik;
        string kullanici_ad, isim, soyisim;
        StringBuilder tablo = new StringBuilder();

        SqlConnection baglanti = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["baglanti"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            kullanici_id = Convert.ToInt32(Request.QueryString["id"]);
            abonelik = Convert.ToInt32(Request.QueryString["abonelik"]);

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
            Label2.Text = "Iptal Abonelik Sayıları : ";


            ///////////// Iptal_Abonelik_Sayi Getirme.

            baglanti.Open();


            SqlCommand komut2 = new SqlCommand();
            SqlDataReader dr2;
            komut2.CommandText = "Select d.ad,ds.dergi_sayi,ds.tarih,ds.link from Dergi_Sayisi ds inner join Iptal_Abonelik sa on ds.dergi_id=sa.dergi_id inner join Dergi d on sa.dergi_id = d.id where (sa.abonelik_id=" + abonelik + " and (tarih between (Select baslangic_tarih from Iptal_Abonelik where abonelik_id=" + abonelik + ") and (Select iptal_tarih from Iptal_Abonelik where abonelik_id=" + abonelik + "))) order by ds.dergi_sayi";
            komut2.Connection = baglanti;
            dr2 = komut2.ExecuteReader();

            //tablo oluşturma

            //başlık ekleme kısmı
            tablo.Append("<table border='1'>");
            tablo.Append("<tr><th>Dergi İsmi</th><th>Dergi Sayısı</th><th>Tarihi</th><th>Linki</th></tr>");

            //tabloya dinamik satır ekleme kısmı
            if (dr2.HasRows)
            {
                while (dr2.Read())
                {

                    tablo.Append("<tr>");
                    tablo.Append("<td>" + dr2[0] + "</td>");
                    tablo.Append("<td>" + dr2[1] + "</td>");
                    tablo.Append("<td>" + dr2[2] + "</td>");
                    tablo.Append("<td>" + dr2[3] + "</td>");
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