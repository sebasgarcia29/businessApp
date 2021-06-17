import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:formvalidation/src/models/producto_model.dart';

class ProductsProvider {
  final String _url =
      'https://flutter-varios-acd65-default-rtdb.firebaseio.com';

  Future<bool> createProduct(ProductModel product) async {
    final url = Uri.parse('$_url/productos.json');
    final response = await http.post(url, body: productModelToJson(product));

    final decodedData = json.decode(response.body);
    print(decodedData);
    return true;
  }

  Future<List<ProductModel>> loadProduct() async {
    final url = Uri.parse('$_url/productos.json');
    final response = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(response.body);
    final List<ProductModel> productos = [];

    // ignore: unnecessary_null_comparison
    if (decodedData == null) {
      return [];
    }
    decodedData.forEach((id, prod) {
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);
    });
    return productos;
  }

  Future<int> deleteProduct(String id) async {
    final url = Uri.parse('$_url/productos/$id.json');
    final response = await http.delete(url);
    print(response.body);
    return 1;
  }

    Future<bool> updateProduct(ProductModel product) async {
    final url = Uri.parse('$_url/productos/${product.id}.json');
    final response = await http.put(url, body: productModelToJson(product));

    final decodedData = json.decode(response.body);
    print(decodedData);
    return true;
  }


}
