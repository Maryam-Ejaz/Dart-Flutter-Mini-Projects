// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'Quote.dart';
//
// class QuoteService {
//   static const String _url = 'https://dummyjson.com/quotes';
//
//   Future<List<Quote>> getQuotes() async {
//     final response = await http.get(Uri.parse(_url));
//
//     if (response.statusCode == 200) {
//       final List<dynamic> quotesJson = jsonDecode(response.body)['quotes'];
//       return quotesJson.map((quoteJson) => Quote.fromJson(quoteJson)).toList();
//     } else {
//       throw Exception('Failed to load quotes');
//     }
//   }
//
//   Future<Quote> createQuote(String quote, String author) async {
//     final response = await http.post(
//       Uri.parse(_url),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'quote': quote,
//         'author': author,
//       }),
//     );
//
//     if (response.statusCode == 201) {
//       final Map<String, dynamic> quoteJson = jsonDecode(response.body);
//       return Quote.fromJson(quoteJson);
//     } else {
//       throw Exception('Failed to create quote');
//     }
//   }
//
//   Future<void> updateQuote(int id, String quote, String author) async {
//     final response = await http.put(
//       Uri.parse('$_url/$id'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'quote': quote,
//         'author': author,
//       }),
//     );
//
//     if (response.statusCode != 200) {
//       throw Exception('Failed to update quote');
//     }
//   }
//
//   Future<void> deleteQuote(int id) async {
//     final response = await http.delete(Uri.parse('$_url/$id'));
//
//     if (response.statusCode != 204) {
//       throw Exception('Failed to delete quote');
//     }
//   }
// }
