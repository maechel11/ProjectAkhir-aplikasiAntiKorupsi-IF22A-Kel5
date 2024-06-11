class Tentang {
  String? judul;
  String? jawaban;

  Tentang({
    this.judul,
    this.jawaban,

  });

  factory Tentang.fromJson(Map<String, dynamic> json) => Tentang(
    judul: json['judul'],
    jawaban: json['jawaban'],
  );

  Map<String, dynamic> toJson() => {
    'judul': this.judul,
    'jawaban': this.jawaban,
  };
}