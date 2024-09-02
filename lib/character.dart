class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String imageUrl;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.imageUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      imageUrl: json['image'],
    );
  }
}
