class Uud {
  final String id;
  final String title;
  final String shortDescription;
  final String fullDescription;

  Uud({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
  });

  factory Uud.fromJson(Map<String, dynamic> json) {
    return Uud(
      id: json['id'], 
      title: json['title'],
      shortDescription: json['short_description'],
      fullDescription: json['full_description'],
    );
  }
}
