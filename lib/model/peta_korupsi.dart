class CorruptionCase {
  final String provinsiName;
  final String kotaName;
  final String pelakuName;

  CorruptionCase({
    required this.provinsiName,
    required this.kotaName,
    required this.pelakuName,
  });

  factory CorruptionCase.fromJson(Map<String, dynamic> json) {
    return CorruptionCase(
      provinsiName: json['provinsi_name'],
      kotaName: json['kota_name'],
      pelakuName: json['pelaku_name'],
    );
  }
}
