using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data; //sql data adapter için
using System.Text; // tablo oluşturabilmek için -> StringBuilder 'içeren kütüphane

namespace AbonelikWeb
{
    public partial class Aboneliklerim : System.Web.UI.Page
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

            Label1.Text =  isim + " " + soyisim+" ("+ kullanici_ad + ")";
            Label2.Text = "Abonelikler : " ;


            ///////////// Abonelikleri Getirme.

            baglanti.Open();


            SqlCommand komut2 = new SqlCommand();
            SqlDataReader dr2;
            komut2.CommandText = "select d.id,d.ad,a.baslangic_tarih,DATEADD(day,taahut_gun,a.baslangic_tarih) from abonelik a inner join dergi d on a.dergi_id=d.id where a.kullanici_id="+ kullanici_id.ToString();
            komut2.Connection = baglanti;
            dr2 = komut2.ExecuteReader();

            //tablo oluşturma

            //başlık ekleme kısmı
            tablo.Append("<table border='1'>");
            tablo.Append("<tr><th>Dergi İsmi</th><th>Başlangıç Tarih</th><th>Bitiş Tarihi</th><th></th><th></th></tr>");

            //tabloya dinamik satır ekleme kısmı
            if (dr2.HasRows)
            {
                while (dr2.Read())
                {

                    tablo.Append("<tr>");
                    tablo.Append("<td>" + dr2[1] + "</td>");
                    tablo.Append("<td>" + dr2[2] + "</td>");
                    tablo.Append("<td>" + dr2[3] + "</td>");
                    tablo.Append("<td><a href=\"SayiBak.aspx?id=" + kullanici_id + "&dergi=" + dr2[0] + "\">Sayilara Bak</a></td>");
                    tablo.Append("<td><a href=\"AbonelikSil.aspx?id=" + kullanici_id + "&dergi=" + dr2[0] + "\">Abonelik Sil</a></td>");
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