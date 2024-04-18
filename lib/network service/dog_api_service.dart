import 'dart:convert';

import 'package:http/http.dart' as http;
import '../model/dog_model.dart';

class DogApiService {
  static const String baseUrl = 'https://dog.ceo/api/breeds/image/random';

  static Future<Dog> fetchRandomDog() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final imageUrl = json['message'];
      return Dog(message: imageUrl, price: "0", id: 0, isInCart: 0);
    } else {
      throw Exception('Failed to fetch dog image');
    }
  }
}
