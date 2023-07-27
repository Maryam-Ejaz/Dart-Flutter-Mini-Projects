import 'package:madproj1/main.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'CustomAlertDialog.dart';

// ignore: must_be_immutable
class Display extends StatefulWidget {
  Display({Key? key, required this.Person, required this.database})
      : super(key: key);
  Map Person;
  Data database;
  @override
  // ignore: library_private_types_in_public_api
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  TextEditingController name = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController mobileNo = new TextEditingController();
  @override
  void initState() {
    super.initState();
    print(widget.Person);
    name.text = widget.Person['Name'];
    gender.text = widget.Person['Gender'];
    email.text = widget.Person['Email'];
    mobileNo.text = widget.Person['MobileNumber'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Update Data"),
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                    return CustomAlertDialog(
                          title:"Delete",
                          message: 'Do you want to delete the data?',
                          buttonText: 'Yes',
                          onPressed: () {
                                  widget.database.delete(widget.Person["id"]);
                                  Navigator.pop(context, true);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyApp()),
                                  );
                                },);
                      },);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(45),
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: inputDecoration("Name"),
                controller: name,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: inputDecoration("Gender"),
                controller: gender,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: inputDecoration("Email"),
                controller: email,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: inputDecoration("Mobile Number."),
                controller: mobileNo,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        color: Colors.transparent,
        child: BottomAppBar(
          color: Colors.transparent,
          child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                  builder: (BuildContext context){
                    return CustomAlertDialog(
                      title:"Update",
                      message: 'Do you want to update the data?',
                      buttonText: 'Yes',
                      onPressed: () {
                        widget.database.update(
                            widget.Person['id'],
                            name.text,
                            gender.text,
                            email.text,
                            mobileNo.text);
                        Navigator.pop(context, true);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()),
                        );
                      },);
                  },);
              },
              child: Text(
                "Update",
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18),
              )),
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
        borderSide: BorderSide(
          color: Colors.teal,
          width: 2.0,
        ),
      ),
    );
  }
}
