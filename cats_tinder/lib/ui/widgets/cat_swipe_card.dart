// lib/ui/widgets/cat_swipe_card.dart
import 'package:flutter/material.dart';
import '../../models/cat.dart';

class CatSwipeCard extends StatelessWidget {
  final Cat cat;
  final VoidCallback onLike;
  final VoidCallback onDislike;
  final VoidCallback onTap;

  const CatSwipeCard({
    super.key,
    required this.cat,
    required this.onLike,
    required this.onDislike,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                cat.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      'Ошибка картинки:\n$error',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 16,
                right: 16,
              ),
              child: Text(
                cat.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: onDislike,
                    icon: const Icon(Icons.thumb_down, color: Colors.red),
                    label: const Text('Дизлайк'),
                  ),
                  TextButton.icon(
                    onPressed: onLike,
                    icon: const Icon(Icons.thumb_up, color: Colors.green),
                    label: const Text('Лайк'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
