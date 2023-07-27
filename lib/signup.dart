import 'auth_functions.dart';
import 'package:flutter/material.dart';
import 'signin.dart';

class MyFormValidation extends StatelessWidget {
  const MyFormValidation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: Scaffold(
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<MyStatefulWidget> {
  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  String email = '';
  String password = '';
  String username = '';

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    signup(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 26, 16, 16),
      //form
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            //styling
            SizedBox(
              height: 12,
            ),
            Text(
              "Create Your Account",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: 5,
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

            TextFormField(
              decoration: InputDecoration(labelText: 'Username'),
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (value) {
                //Validator
              },
              onSaved: (value) {
                setState(() {
                  username = value!;
                });
              },
            ),
            SizedBox(
              height: 5,
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
              height: 30,
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.teal),
                  ),
                  child: const Text(
                    'Create Account',
                  ),
                  onPressed: () {
                    print(email);
                    print(password);
                    _submit();

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SigninScreen(),
                    ));
                  },
                )),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
