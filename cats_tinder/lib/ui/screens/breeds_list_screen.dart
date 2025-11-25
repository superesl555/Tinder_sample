import 'package:flutter/material.dart';

class BreedsListScreen extends StatelessWidget {
  const BreedsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Здесь будет список пород 🐾',
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}
