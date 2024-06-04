class Berita {
  final String judul;
  final String tanggal;
  final String imagePath;
  final String kategori;
  final String? isi;

  Berita(
    {
      required this.judul, 
      required this.tanggal, 
      required this.imagePath, 
      required this.kategori, 
      this.isi
    }
  );

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      judul     : json['judul'],
      tanggal   : json['tanggal'],
      imagePath : json['imagePath'],
      kategori  : json['kategori'],
      isi       : json['isi'],
    );
  }
}
