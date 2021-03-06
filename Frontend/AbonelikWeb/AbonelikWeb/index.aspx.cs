﻿using System;
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
    public partial class index : System.Web.UI.Page
    {
        int kullanici_id;
        string kullanici_ad, isim, soyisim;

        StringBuilder tablo = new StringBuilder();

        SqlConnection baglanti = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["baglanti"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            kullanici_id = Convert.ToInt32(Request.QueryString["id"]); // giriş sayfasıdnan gönderilen id' isimli paket alınır buradaki kullanici_id değişkenine verilir.


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

            Label1.Text = "Hoş Geldiniz, " + isim + " " + soyisim;
            Label2.Text = "oturum : " + kullanici_ad;




            baglanti.Open();


            SqlCommand komut2 = new SqlCommand();
            SqlDataReader dr2;
            komut2.CommandText = "Select ad,periyot_gun,fiyat from Dergi";
            komut2.Connection = baglanti;
            dr2 = komut2.ExecuteReader();

            //tablo oluşturma

            //başlık ekleme kısmı
            tablo.Append("<table border='1'>");
            tablo.Append("<tr><th>Dergi İsmi</th><th>Dergi Gün Periyodu</th><th>Fiyatı</th><th></th></tr>");

            //tabloya dinamik satır ekleme kısmı
            if (dr2.HasRows)
            {
                while (dr2.Read())
                {

                    tablo.Append("<tr>");
                    tablo.Append("<td>" + dr2[0] + "</td>");
                    tablo.Append("<td>" + dr2[1] + "</td>");
                    tablo.Append("<td>" + dr2[2] + "</td>");
                    tablo.Append("<td><a href=\"SatinAl.aspx?id="+ kullanici_id + "&dergi="+ dr2[0] +"\">Satin Al</a></td>");
                    tablo.Append("</tr>");
                }
            }
            tablo.Append("</table>");

            this.Controls.Add(new Literal { Text = tablo.ToString() });
            dr2.Close();
            baglanti.Close();

            


        }

        public void button_aboneliklerim(Object sender, EventArgs e)
        {
            Response.Redirect("Aboneliklerim.aspx?id=" + kullanici_id);
        }
        

        public void button_silinen_abonelik(Object sender, EventArgs e)
        {
            Response.Redirect("SilinenAbonelik.aspx?id=" + kullanici_id);
        }
        public void button_iptal_abonelik(Object sender, EventArgs e)
        {
            Response.Redirect("IptalAbonelik.aspx?id=" + kullanici_id);
        }
    }
}