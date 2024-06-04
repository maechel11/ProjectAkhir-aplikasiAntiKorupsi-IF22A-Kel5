class Api {
  static const _host = "http://localhost/api_mobile";

  //berita
  static String berita ="$_host/berita.php";

  //Faq
static String _faq = "$_host/faq";
  static String getFaq = "$_faq/view.php";

  //tentang kami
static String _tentangkami = "$_host/tentang kami";
  static String getTentang = "$_tentangkami/view.php";

    // Peta Korupsi
  static String petaKorupsi = "$_host/peta_korupsi.php";

  // Peta uud
  static String uud = "$_host/uud.php";

  // Pengaduan Korupsi
  static String report = "$_host/report.php";

  
  // profile pejabat
  static String pejabat="$_host/pejabat/pejabat.php";

   // Instansi Korupsi
  static String instansi = "$_host/instansi.php";


}