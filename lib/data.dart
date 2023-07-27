import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String personName, String personGender,
      String personEmail, String personMobileno) async {
    try {
      await firestore.collection("Person").add({
        'Name': personName,
        'Gender': personGender,
        'Email': personEmail,
        'MobileNumber': personMobileno
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("Person").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List> getData() async {
    QuerySnapshot information;
    List docs = [];
    try {
      information = await firestore.collection('Person').get();
      if (information.docs.isNotEmpty) {
        for (var doc in information.docs.toList()) {
          Map a = {
            "id": doc.id,
            "Name": doc['Name'],
            "Gender": doc["Gender"],
            "Email": doc["Email"],
            "MobileNumber": doc["MobileNumber"]
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
    return docs;
  }

  Future<void> update(String personId, String personName, String personGender,
      String personEmail, String personMobileno) async {
    try {
      await firestore.collection("Person").doc(personId).update({
        'Name': personName,
        'Gender': personGender,
        'Email': personEmail,
        'MobileNumber': personMobileno
      });
    } catch (e) {
      print(e);
    }
  }
}
