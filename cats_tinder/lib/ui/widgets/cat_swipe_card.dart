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
    return Dismissible(
      key: ValueKey(cat.id),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        final liked = direction == DismissDirection.startToEnd;
        if (liked) {
          onLike();
        } else {
          onDislike();
        }
      },
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // картинка
              Expanded(
                child: Image.network(
                  cat.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Text('Не удалось загрузить котика')),
                ),
              ),
              // название породы
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
              // кнопки лайк/дизлайк ПРЯМО НА КАРТОЧКЕ
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
      ),
    );
  }
}
