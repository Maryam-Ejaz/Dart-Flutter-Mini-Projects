// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'quote.dart';
// import 'QuoteService.dart';
//
// class QuoteDisplayPage extends StatefulWidget {
//   @override
//   _QuoteDisplayPageState createState() => _QuoteDisplayPageState();
// }
//
// class _QuoteDisplayPageState extends State<QuoteDisplayPage> {
//   List<Quote> _quotes = [];
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   // Fetch quotes data from API
//   Future<void> _fetchQuotes() async {
//     try {
//       var response = await http.get(Uri.parse('https://dummyjson.com/quotes'));
//       var jsonData = json.decode(response.body);
//       setState(() {
//         _quotes = QuoteService.(jsonData['quotes']);
//       });
//     } catch (e) {
//       _scaffoldKey.currentState?.showSnackBar(
//         SnackBar(content: Text('Error fetching quotes data: $e')),
//       );
//     }
//   }
//
//   // Show dialog to add new quote
//   void _showAddQuoteDialog() {
//     // TODO: Implement code to show add quote dialog
//     void _showAddQuoteDialog() {
//       TextEditingController quoteController = TextEditingController();
//       TextEditingController authorController = TextEditingController();
//
//       showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 TextField(
//                   controller: quoteController,
//                   decoration: InputDecoration(
//                     labelText: 'Quote',
//                   ),
//                 ),
//                 TextField(
//                   controller: authorController,
//                   decoration: InputDecoration(
//                     labelText: 'Author',
//                   ),
//                 ),
//                 SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final newQuote = {
//                       'quote': quoteController.text,
//                       'author': authorController.text,
//                     };
//                     final response = await QuoteService.createQuote(newQuote);
//                     if (response.statusCode == 201) {
//                       Navigator.pop(context);
//                       _scaffoldKey.currentState!.showSnackBar(
//                         SnackBar(
//                           content: Text('Quote added successfully'),
//                           backgroundColor: Colors.green,
//                         ),
//                       );
//                       setState(() {
//                         _quotes.add(response.body);
//                       });
//                     } else {
//                       _scaffoldKey.currentState!.showSnackBar(
//                         SnackBar(
//                           content: Text('Failed to add quote'),
//                           backgroundColor: Colors.teal,
//                         ),
//                       );
//                     }
//                   },
//                   child: Text('Save'),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     }
//
//   }
//
//   // Show dialog to edit existing quote
//   void _showEditQuoteDialog(int index) {
//     // TODO: Implement code to show edit quote dialog
//   }
//
//   // Delete existing quote
//   void _deleteQuote(int index) {
//     // TODO: Implement code to delete quote
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchQuotes();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         title: Text("CRUD Operations Demo"),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               child: Text('Quotes'),
//               decoration: BoxDecoration(
//                 color: Colors.teal,
//               ),
//             ),
//             ListTile(
//               title: Text('Home'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: Text('Add Quote'),
//               onTap: () {
//                 _showAddQuoteDialog();
//               },
//             ),
//           ],
//         ),
//       ),
//       body: _quotes.isEmpty
//           ? Center(
//         child: CircularProgressIndicator(),
//       )
//           : ListView.builder(
//         itemCount: _quotes.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Card(
//             child: ListTile(
//               title: Text(_quotes[index].quote),
//               subtitle: Text(_quotes[index].author),
//               trailing: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.edit),
//                     onPressed: () {
//                       _showEditQuoteDialog(index);
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () {
//                       _deleteQuote(index);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
