import 'package:flutter/material.dart';
import '../../models/breed.dart';

class BreedDetailsScreen extends StatelessWidget {
  final Breed breed;

  const BreedDetailsScreen({
    super.key,
    required this.breed,
  });

  String? _buildImageUrl() {
    if (breed.referenceImageId == null) return null;
    return 'https://cdn2.thecatapi.com/images/${breed.referenceImageId}.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = _buildImageUrl();

    return Scaffold(
      appBar: AppBar(
        title: Text(breed.name),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl != null)
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          child: const Text(
                            'Не удалось загрузить изображение породы',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                breed.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                breed.origin.isNotEmpty
                    ? 'Страна происхождения: ${breed.origin}'
                    : 'Страна происхождения: неизвестна',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              const Text(
                'Описание',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                breed.description,
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
              const SizedBox(height: 16),
              const Text(
                'Характеристики',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (breed.lifeSpan.isNotEmpty)
                    Chip(label: Text('Жизнь: ${breed.lifeSpan} лет')),
                  if (breed.energyLevel != null)
                    Chip(label: Text('Энергичность: ${breed.energyLevel}/5')),
                  if (breed.intelligence != null)
                    Chip(label: Text('Интеллект: ${breed.intelligence}/5')),
                  if (breed.temperament.isNotEmpty)
                    Chip(
                      label: Text(
                        breed.temperament,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
