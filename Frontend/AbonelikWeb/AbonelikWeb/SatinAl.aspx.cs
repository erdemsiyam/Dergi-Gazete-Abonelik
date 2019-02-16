using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace AbonelikWeb
{
    public partial class SatinAl : System.Web.UI.Page
    {
        int kullanici_id;
        string dergi;
        double dergi_fiyat, dergi_periyot_gun;

        SqlConnection baglanti = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["baglanti"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            kullanici_id = Convert.ToInt32(Request.QueryString["id"]);
            dergi = Request.QueryString["dergi"];
            Label1.Text = dergi;
            
                baglanti.Open();
                SqlCommand komut = new SqlCommand();
                SqlDataReader dr;
                komut.CommandText = "SELECT max_taahut,fiyat,periyot_gun FROM dergi WHERE ad='" + dergi + "'";
                komut.Connection = baglanti;
                try
                {
                    dr = komut.ExecuteReader();
                    if (dr.Read())
                    {
                        int taahut = Convert.ToInt32(dr[0]);
                        dergi_fiyat = Convert.ToInt32(dr[1]);
                        dergi_periyot_gun = Convert.ToInt32(dr[2]);
                            if (!this.IsPostBack)
                            {
                                DropDownList1.Items.Clear();
                                for (int i = 30; i <= taahut; i += 30)
                                {
                                    DropDownList1.Items.Add(i.ToString());
                                }
                                dr.Close();
                            }

                    }
                    else
                    {
                        Response.Write("<script LANGUAGE='JavaScript' >alert('Dergi bilgilerine erişilemedi.')</script>");
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



        public void ddl_SecimDegisince(object sender,EventArgs e)
        {

            //fiyat hesaplanır.
            

            double indirim, toplam_fiyat;

            //eğer taahut gun 720 den fazlaysa (yani 24 ay dan fazla taahut ise) ndirim oranı sabit kalır. (hep 24 aymış gibi indirime tabii tutulur.)
            if (Convert.ToInt32(DropDownList1.SelectedValue) >= 720)
                indirim = (24 * (2.5));
            else
                indirim = ((Convert.ToDouble(DropDownList1.SelectedValue) / 30) * (2.5));

            toplam_fiyat = Convert.ToDouble(DropDownList1.SelectedValue);
            toplam_fiyat /= 30;
            toplam_fiyat *= dergi_fiyat;
            toplam_fiyat *= (30 / dergi_periyot_gun);
            toplam_fiyat /= 100;
            toplam_fiyat *= (100 - indirim);

            Label2.Text = toplam_fiyat.ToString() + " TL ( %" + indirim.ToString() + " İndirimli )";

            Button1.Enabled = true; // satın alma butonu aktif edilir.

        }

        public void button_SatinAl(object sender, EventArgs e)
        {
            baglanti.Open();
            SqlCommand komut2 = new SqlCommand("SP_Abonelik_Ekle", baglanti);

            komut2.Parameters.AddWithValue("@kullanici_id", kullanici_id);
            komut2.Parameters.AddWithValue("@dergi_ad", dergi);
            komut2.Parameters.AddWithValue("@baslangic_tarih", DateTime.Now.ToString("yyyy-MM-dd"));
            komut2.Parameters.AddWithValue("@taahut_gun", DropDownList1.SelectedValue.ToString());
            komut2.CommandType = System.Data.CommandType.StoredProcedure;
            try
            {
                komut2.ExecuteNonQuery();
                Response.Redirect("index.aspx?id=" + kullanici_id);
            }
            catch (Exception hata)
            {
                Response.Write("<script LANGUAGE='JavaScript' >alert('hata : "+hata.Message+"')</script>");
            }
            finally
            {
                baglanti.Close();
            }


        }


    }
}