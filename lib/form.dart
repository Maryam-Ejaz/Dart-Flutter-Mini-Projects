import 'package:flutter/material.dart';
class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _password;


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
        backgroundColor: Colors.white, toolbarTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.teal,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ).bodyMedium,
        titleTextStyle: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.teal,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ).titleLarge,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(60),
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(
          // color: Colors.teal,
          // width: 2,
          // ),
          // ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value==null) {
                      return 'Please enter your email address';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value==null) {
                      return 'Please enter a password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
                // SizedBox(height: 20),
                // TextFormField(
                //   decoration: InputDecoration(labelText: 'Confirm Password'),
                //   obscureText: true,
                //   validator: (value) {
                //     if (value==null
                //     ) {
                //       return 'Please confirm your password';
                //     } else if (value != _password) {
                //       return 'Passwords do not match';
                //     }
                //     return null;
                //   },
                //   onSaved: (value) => _confirmPassword = value!,

                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Do something with the form data

                      print('Name: $_name');
                      print('Email: $_email');
                      print('Password: $_password');
                      // print('Confirm Password: $_confirmPassword');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Form Submitted'),
                            content: const Text('Your form has been submitted successfully.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text('Submit'),
                ),
              ],)
            ),
          ),
        ),
      );

  }
}
