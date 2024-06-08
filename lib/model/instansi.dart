class Instansi {
  final String id;
  final String namaInstansi;
  final String keterangan;
  final String lokasi;
  final String tahunKorupsi;

  Instansi({
    required this.id,
    required this.namaInstansi,
    required this.keterangan,
    required this.lokasi,
    required this.tahunKorupsi,
  });

  factory Instansi.fromJson(Map<String, dynamic> json) {
    return Instansi(
      id: json['id'],
      namaInstansi: json['nama_instansi'],
      keterangan: json['keterangan'],
      lokasi: json['lokasi'],
      tahunKorupsi: json['tahun_korupsi'],
    );
  }
}