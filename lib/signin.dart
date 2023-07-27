import 'google_auth.dart';
import 'push_notifications.dart';
import 'auth_functions.dart';
import 'signup.dart';
import 'package:flutter/material.dart';
import 'fbAuth.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _HomePageState();
}

class _HomePageState extends State<SigninScreen> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  String email = '';
  String password = '';

  void _submit() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    int msg = await signIn(email, password);
    if (msg == 1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Signed in successfully"),
      ));
    } else if (msg == 2) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No user found for that email.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Wrong password provided for that user.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        //form
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Sign in',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  //Validator
                },
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),
              //box styling
              SizedBox(
                height: 3,
              ),
              //text input
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {},
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'Enter a valid password!';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.teal),
                    ),
                    child: const Text(
                      'Sign in',
                    ),
                    onPressed: () {
                      _submit();
                    },
                  )),
              SizedBox(
                height: 2,
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.teal),
                    ),
                    child: const Text(
                      'Sign up',
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyFormValidation(),
                      ));
                    },
                  )),
              SizedBox(
                height: 2,
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.teal),
                    ),
                    child: const Text(
                      'Sign in with google',
                    ),
                    onPressed: () {
                      var result = AuthService().signInWithGoogle();
                      //this function being called here is in google_auth.dart file
                      if(result == true){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen())
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Logged in successfully!"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );}
                    }
                  )),

              // SizedBox(
              //   height: 2,
              // ),
              // Container(
              //     width: double.infinity,
              //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              //     child: ElevatedButton(
              //         style: const ButtonStyle(
              //           backgroundColor: MaterialStatePropertyAll<Color>(
              //               Colors.teal),
              //         ),
              //         child: const Text(
              //           'Sign in with Facebook',
              //         ),
              //         onPressed: () {
              //           var result = signInWithFacebook();
              //           //this function being called here is in google_auth.dart file
              //           if(result.toString().isNotEmpty){
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(builder: (context) => HomeScreen())
              //             );
              //             showDialog(
              //               context: context,
              //               builder: (BuildContext context) {
              //                 return AlertDialog(
              //                   title: Text("Logged in successfully!"),
              //                   actions: [
              //                     TextButton(
              //                       onPressed: () {
              //                         Navigator.of(context).pop();
              //                       },
              //                       child: Text("OK"),
              //                     ),
              //                   ],
              //                 );
              //               },
              //             );}
              //         }
              //     )),
              // PushNotification_(),
            ],
          ),
        ),
      ),
    );
  }
}
