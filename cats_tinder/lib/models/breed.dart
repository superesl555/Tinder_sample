class Breed {
  final String id;
  final String name;
  final String description;
  final String origin;
  final String temperament;
  final String lifeSpan;
  final int? energyLevel;
  final int? intelligence;
  final String? referenceImageId;

  Breed({
    required this.id,
    required this.name,
    required this.description,
    required this.origin,
    required this.temperament,
    required this.lifeSpan,
    this.energyLevel,
    this.intelligence,
    this.referenceImageId,
  });

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      origin: json['origin'] as String? ?? 'Unknown',
      temperament: json['temperament'] as String? ?? '',
      lifeSpan: json['life_span'] as String? ?? '',
      energyLevel: json['energy_level'] as int?,
      intelligence: json['intelligence'] as int?,
      referenceImageId: json['reference_image_id'] as String?,
    );
  }
}
