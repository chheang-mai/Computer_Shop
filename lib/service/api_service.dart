import 'dart:convert';

import 'package:computer_shop/model/product.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Product>> getProduct() async {
    final url = Uri.parse(
      "https://seangleangsim006-cmd.github.io/computer-json/",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String,dynamic> data = jsonDecode(response.body);
      List  product = data['products'];
      return product.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}
