import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'display.dart';
import 'data.dart';

// ignore: must_be_immutable
class Insert extends StatefulWidget {
  Insert({Key? key, required this.database}) : super(key: key);
  Data database;
  @override
  _InsertState createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  TextEditingController personName = new TextEditingController();
  TextEditingController personGender = new TextEditingController();
  TextEditingController personEmail = new TextEditingController();
  TextEditingController personMobileno = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Insert Data"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(45),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: inputDecoration("Name"),
                controller: personName,
                validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: inputDecoration("Gender"),
                controller: personGender,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a gender';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: inputDecoration("Email"),
                controller: personEmail,
                validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: inputDecoration("Contact"),
                controller: personMobileno,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a mobile number';
                  }
                  if (value?.length != 14) {
                    return 'Please enter a valid mobile number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.transparent,
        child: BottomAppBar(
          color: Colors.transparent,
          child: ElevatedButton(
              onPressed: () {

                widget.database.create(personName.text, personGender.text,
                    personEmail.text, personMobileno.text);
                Navigator.pop(context, true);},

              child: Text(
                "Save",
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),

              ),)
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.white,
      labelStyle: TextStyle(color: Colors.teal),
      labelText: labelText,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.teal),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.teal,
          width: 2.0,
        ),
      ),
    );
  }
}
