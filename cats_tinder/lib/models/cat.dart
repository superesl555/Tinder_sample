// lib/models/cat.dart
class Cat {
  final String id;
  final String name;
  final String imageUrl;
  final String description;

  Cat({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory Cat.fromSearchJson(Map<String, dynamic> json) {
    final breeds = json['breeds'] as List<dynamic>?;
    final breed =
        (breeds != null && breeds.isNotEmpty)
            ? breeds.first as Map<String, dynamic>
            : null;

    return Cat(
      id: json['id'] as String,
      imageUrl: json['url'] as String,
      name: breed?['name'] as String? ?? 'Unknown breed',
      description:
          breed?['description'] as String? ?? 'Описание породы недоступно.',
    );
  }
}
