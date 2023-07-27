import 'package:flutter/material.dart';
import 'display.dart';
import 'data.dart';
import 'Insert.dart';

// class FormScreen extends StatefulWidget {
//   @override
//   _FormScreenState createState() => _FormScreenState();
// }
//
// class _FormScreenState extends State<FormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   late String _name;
//   late String _email;
//   late String _password;
//   late String _confirmPassword;
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Form'),
//         backgroundColor: Colors.white, toolbarTextStyle: const TextTheme(
//           titleLarge: TextStyle(
//             color: Colors.teal,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ).bodyMedium,
//         titleTextStyle: const TextTheme(
//           titleLarge: TextStyle(
//             color: Colors.teal,
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ).titleLarge,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(60),
//           // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(
//           // color: Colors.teal,
//           // width: 2,
//           // ),
//           // ),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(height: 20),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Name'),
//                   validator: (value) {
//                     if (value == null) {
//                       return 'Please enter your name';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) => _name = value!,
//                 ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Email'),
//                   validator: (value) {
//                     if (value==null) {
//                       return 'Please enter your email address';
//                     } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
//                       return 'Please enter a valid email address';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) => _email = value!,
//                 ),
//                 // SizedBox(height: 20),
//                 // TextFormField(
//                 //   decoration: InputDecoration(labelText: 'Password'),
//                 //   obscureText: true,
//                 //   validator: (value) {
//                 //     if (value==null) {
//                 //       return 'Please enter a password';
//                 //     } else if (value.length < 6) {
//                 //       return 'Password must be at least 6 characters long';
//                 //     }
//                 //     return null;
//                 //   },
//                 //   onSaved: (value) => _password = value!,
//                 // ),
//                 SizedBox(height: 20),
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Confirm Password'),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value==null
//                     ) {
//                       return 'Please confirm your password';
//                     } else if (value != _password) {
//                       return 'Passwords do not match';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) => _confirmPassword = value!,
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//                       // Do something with the form data
//                       print('Name: $_name');
//                       print('Email: $_email');
//                       print('Password: $_password');
//                       // print('Confirm Password: $_confirmPassword');
//                     }
//                   },
//                   child: Text('Submit'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


class Form_ extends StatefulWidget {
  const Form_({super.key});


  @override
  State<Form_> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Form_> {
  late Data database;
  List docs = [];
  initialise() {
    database = Data();
    database.initiliase();
    database.getData().then((value) => {
      setState(() {
        docs = value;
      })
    });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(56, 75, 49,1.0 ),

      appBar: AppBar(
        title: Text('Firebase CRUD'),
      ),
      body: ListView.builder(
          itemCount: docs.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child:
                Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Display(
                                  Person: docs[index],
                                  database: database))).then((value) => {
                        if (value != null) {initialise()}
                      });
                    },
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage("assets/img1.jpg"),
                    ),
                    title: Text(
                        docs[index]['Name'] + "    (" + docs[index]['Gender'] + ")",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text(docs[index]['MobileNumber'],
                        style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                    trailing: Text(docs[index]['Email'] + '',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.teal,
                        )),


                  )
                ]));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Insert(database: database)))
              .then((value) {
            if (value != null) {
              initialise();
            }
          });
        },

        tooltip: 'Increment',
        label: Row(
          children: [Icon(Icons.add), Text('  Add')],
        ),


      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
