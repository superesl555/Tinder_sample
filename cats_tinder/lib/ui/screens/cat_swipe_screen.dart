import 'dart:math';

import 'package:flutter/material.dart';
import '../../models/cat.dart';
import '../widgets/cat_swipe_card.dart';
import '../widgets/cat_details_sheet.dart';

class CatSwipeScreen extends StatefulWidget {
  const CatSwipeScreen({super.key});

  @override
  State<CatSwipeScreen> createState() => _CatSwipeScreenState();
}

class _CatSwipeScreenState extends State<CatSwipeScreen> {
  final _random = Random();

  final List<Cat> _cats = [
    Cat(
      id: '1',
      name: 'British Shorthair',
      imageUrl: 'https://placekitten.com/400/400',
      description: 'Спокойный, плюшевый и очень уютный кот.',
    ),
    Cat(
      id: '2',
      name: 'Sphynx',
      imageUrl: 'https://placekitten.com/401/400',
      description: 'Лысый, но очень тёплый и общительный.',
    ),
    Cat(
      id: '3',
      name: 'Siamese',
      imageUrl: 'https://placekitten.com/400/401',
      description: 'Голосистый, умный и общительный кот.',
    ),
  ];

  int _currentIndex = 0;
  int _likeCount = 0;

  Cat get _currentCat => _cats[_currentIndex];

  void _goToNextCat({required bool liked}) {
    setState(() {
      if (liked) {
        _likeCount++;
      }

      int nextIndex = _currentIndex;
      if (_cats.length > 1) {
        while (nextIndex == _currentIndex) {
          nextIndex = _random.nextInt(_cats.length);
        }
      }
      _currentIndex = nextIndex;
    });
  }

  void _openCatDetails() {
    final cat = _currentCat;

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
            child: CatSwipeCard(
              cat: _currentCat,
              onLike: () => _goToNextCat(liked: true),
              onDislike: () => _goToNextCat(liked: false),
              onTap: _openCatDetails,
            ),
          ),
        ),
      ],
    );
  }
}
