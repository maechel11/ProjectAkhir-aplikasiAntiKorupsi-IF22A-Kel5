class Faq {
  String? pertanyaan;
  String? jawaban;

  Faq({
    this.pertanyaan,
    this.jawaban,

  });

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
    pertanyaan: json['pertanyaan'],
    jawaban: json['jawaban'],
  );

  Map<String, dynamic> toJson() => {
    'pertanyaan': this.pertanyaan,
    'jawaban': this.jawaban,
  };
}