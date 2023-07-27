import 'dart:convert';
import 'services.dart';
import 'package:http/http.dart' as http;
import "_services.dart";

Future<List<Product>> fetchProduct() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var responseData = json.decode(response.body);
    responseData = responseData['products'];
    //Creating a list to store input data;
    List<Product> products = [];
    for (var singleService in responseData) {
      // print(singleService);
      // print("****************************");
      Product product = Product(
          id: singleService["id"],
          title: singleService["title"],
          description: singleService["description"]);

      //Adding product to the list.
      products.add(product);
    }
    return products.reversed.toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load products');
  }
}

Future<http.Response> createProduct(String title, String description) {
  return http.post(
    Uri.parse('https://dummyjson.com/products/add'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'description': description,
      // 'status': 'Active'
    }),
  );
}

deleteProduct(String id) async {
  final http.Response response = await http.delete(
      Uri.parse('https://dummyjson.com/products/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
  if (response.statusCode == 200) {
    print(response.body);
    return 'Deleted';
  } else {
    throw Exception('Failed to delete Product.');
  }
}

Future<Product> updateProduct(
    String id, String title, String description) async {
  final response = await http.put(
    Uri.parse('https://dummyjson.com/products/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'title': title, 'description': description}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return Product.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to update Product.');
  }
}
