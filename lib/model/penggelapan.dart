class TersangkaPenggelapan {
  final String id;
  final String nama;
  final String jabatan;
  final String tanggal;
  final String deskripsi;

  TersangkaPenggelapan({
    required this.id,
    required this.nama,
    required this.jabatan,
    required this.tanggal,
    required this.deskripsi,
  });

  factory TersangkaPenggelapan.fromJson(Map<String, dynamic> json) {
    return TersangkaPenggelapan(
      id: json['id'],
      nama: json['nama'],
      jabatan: json['jabatan'],
      tanggal: json['tanggal'],
      deskripsi: json['deskripsi'],
    );
  }
}
