import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cat.dart';
import '../models/breed.dart';

class CatsApi {
  final http.Client _client;

  CatsApi({http.Client? client}) : _client = client ?? http.Client();

  static const _host = 'api.thecatapi.com';
  static const String _apiKey =
      'live_HNY3ejUNb7SgUaR53bwU0pVU4vFO37UmLGpAht4Nb0CuyijkVNSRyhuIdkCRGrQV';

  Map<String, String> _headers() {
    final headers = <String, String>{};
    headers['x-api-key'] = _apiKey;
    return headers;
  }

  Future<Cat> fetchRandomCat() async {
    final uri = Uri.https(_host, '/v1/images/search', {
      'has_breeds': '1',
      'limit': '1',
      'size': 'med',
    });

    final response = await _client.get(uri, headers: _headers());

    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки котика: ${response.statusCode}');
    }

    final List<dynamic> data = json.decode(response.body) as List<dynamic>;
    if (data.isEmpty) {
      throw Exception('Сервер вернул пустой список котиков');
    }

    final map = data.first as Map<String, dynamic>;
    return Cat.fromSearchJson(map);
  }

  Future<List<Breed>> fetchBreeds() async {
    final uri = Uri.https(_host, '/v1/breeds');

    final response = await _client.get(uri, headers: _headers());
    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки пород: ${response.statusCode}');
    }

    final List<dynamic> data = json.decode(response.body) as List<dynamic>;
    return data
        .map((item) => Breed.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
