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

  //registrasi
  static String adduser = "$_host/registrasi/add.php";
  static String updateuser = "$_host/registrasi/update.php";

  //login
  static String login = "$_host/login.php";

  
  // Tersangka Penggelapan
  static String tersangkaPenggelapan = "$_host/tersangka_penggelapan.php";

  static String tersangkaPenyuapan = "$_host/tersangka_penyuapan.php";

  static String tersangkaKerugianKeuanganNegara =
      "$_host/tersangka_kerugian_keuangan_negara.php";

  static String tersangkaGratifikasi = "$_host/tersangka_gratifikasi.php";

  static String tersangkaPemerasan = "$_host/tersangka_pemerasan.php";

  static String tersangkaPerbuatanCurang =
      "$_host/tersangka_perbuatan_curang.php";
  
}