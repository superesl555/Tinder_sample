import 'package:flutter/material.dart';
import '../../models/cat.dart';
import '../../services/cats_api.dart';
import '../widgets/cat_swipe_card.dart';
import '../widgets/cat_details_sheet.dart';

class CatSwipeScreen extends StatefulWidget {
  const CatSwipeScreen({super.key});

  @override
  State<CatSwipeScreen> createState() => _CatSwipeScreenState();
}

class _CatSwipeScreenState extends State<CatSwipeScreen> {
  final _api = CatsApi();

  Cat? _currentCat;
  bool _isLoading = false;
  int _likeCount = 0;

  @override
  void initState() {
    super.initState();
    _loadRandomCat();
  }

  Future<void> _loadRandomCat({bool incrementLikes = false}) async {
    setState(() {
      _isLoading = true;
      if (incrementLikes) {
        _likeCount++;
      }
    });

    try {
      final cat = await _api.fetchRandomCat();
      setState(() {
        _currentCat = cat;
      });
    } catch (e) {
      _showErrorDialog(
        'Не удалось загрузить котика.\n\n'
        'Ошибка: $e',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _loadRandomCat();
            },
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }

  void _openCatDetails() {
    final cat = _currentCat;
    if (cat == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => CatDetailsSheet(cat: cat),
    );
  }

  @override
  Widget build(BuildContext context) {

    final cat = _currentCat;

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          'Лайков: $_likeCount',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _isLoading && cat == null
                ? const Center(child: CircularProgressIndicator())
                : cat == null
                    ? const Center(child: Text('Котик не найден'))
                    : Dismissible(
                        key: ValueKey(cat.id),
                        direction: DismissDirection.horizontal,
                        onDismissed: (direction) {
                          final liked =
                              direction == DismissDirection.startToEnd;
                          setState(() {
                            _currentCat = null;
                          });
                          _loadRandomCat(incrementLikes: liked);
                        },
                        child: CatSwipeCard(
                          cat: cat,
                          onLike: () => _loadRandomCat(incrementLikes: true),
                          onDislike: () =>
                              _loadRandomCat(incrementLikes: false),
                          onTap: _openCatDetails,
                        ),
                      ),
          ),
        ),
      ],
    );
  }
}
