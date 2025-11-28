import 'package:flutter/material.dart';
import '../../models/breed.dart';
import '../../services/cats_api.dart';
import 'breed_details_screen.dart';

class BreedsListScreen extends StatefulWidget {
  const BreedsListScreen({super.key});

  @override
  State<BreedsListScreen> createState() => _BreedsListScreenState();
}

class _BreedsListScreenState extends State<BreedsListScreen> {
  final _api = CatsApi();
  late Future<List<Breed>> _futureBreeds;

  @override
  void initState() {
    super.initState();
    _futureBreeds = _api.fetchBreeds();
  }

  void _reload() {
    setState(() {
      _futureBreeds = _api.fetchBreeds();
    });
  }

  void _showErrorDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _reload();
            },
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Breed>>(
      future: _futureBreeds,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showErrorDialog('Не удалось загрузить список пород.\n\nОшибка: ${snapshot.error}');
          });
          return const Center(child: Text('Ошибка загрузки пород'));
        }

        final breeds = snapshot.data ?? [];

        if (breeds.isEmpty) {
          return const Center(child: Text('Список пород пуст'));
        }

        return ListView.separated(
          itemCount: breeds.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final breed = breeds[index];
            return ListTile(
              title: Text(breed.name),
              subtitle: Text(
                breed.temperament,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BreedDetailsScreen(breed: breed),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
