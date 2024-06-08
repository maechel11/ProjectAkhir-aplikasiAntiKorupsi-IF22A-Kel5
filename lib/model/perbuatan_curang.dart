class TersangkaPerbuatanCurang {
  final String id;
  final String nama;
  final String jabatan;
  final String tanggal;
  final String deskripsi;

  TersangkaPerbuatanCurang({
    required this.id,
    required this.nama,
    required this.jabatan,
    required this.tanggal,
    required this.deskripsi,
  });

  factory TersangkaPerbuatanCurang.fromJson(Map<String, dynamic> json) {
    return TersangkaPerbuatanCurang(
      id: json['id'],
      nama: json['nama'],
      jabatan: json['jabatan'],
      tanggal: json['tanggal'],
      deskripsi: json['deskripsi'],
    );
  }
}
