import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';


class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key, required this.title});

  final String title;

  @override
  State<ImageUploadScreen> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploadScreen> {
  File? _imageFile;
  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 25,); //maxHeight:  200 , maxWidth: 200
    if (pickedFile != null) {
      //final croppedImage = await cropImage(File(pickedFile.path));
      setState(() {
        _imageFile = File(pickedFile!.path);
      });
      await uploadImage(_imageFile!);
    }
  }

  Future<File?> cropImage(File img) async {
    final imageCropper = ImageCropper();
    final croppedImage = await imageCropper.cropImage(
      sourcePath: img.path,
      compressQuality: 100,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.teal,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
      iosUiSettings: IOSUiSettings(
        title: 'Crop Image',
        aspectRatioLockEnabled: true,
      ),
    );
    return croppedImage ?? _imageFile;
  }

  Future<void> uploadImage(File imageFile) async {
    // final storage = FirebaseFirestore.instance;
    // final imageName = DateTime.now().toString() + '.png';
    // final ref = await storage.collection('images').add('images/$imageName' as Map<String, dynamic>);
    // _imageFile = ref as File;
    // FirebaseStorage storage = FirebaseStorage.instance;
    // const storage = firebase.app().storage('gs://your-project.appspot.com');
    // var snapshot = await storage.ref('$_imageFile${DateTime.now()}')
        // .child('$_imageFile${DateTime.now()}')
        // .putFile(imageFile);
    // Reference ref = storage.ref().child('images/$_imageFile${DateTime.now()}');
    // UploadTask uploadTask = ref.putFile(_imageFile!);
    // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    Reference reference = FirebaseStorage.instance.ref();
    Reference referenceDirImage = reference.child('images');
    Reference referenceUploadImage = referenceDirImage.child('$_imageFile${DateTime.now()}');

    await referenceUploadImage.putFile(imageFile);
    var imageURL = await referenceUploadImage.getDownloadURL();
    var dbRef;
    dbRef.add({'image': imageURL});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Uploader'),
      ),
      body: Center(
        child: _imageFile == null? const Text('No image selected.'): Image.file(_imageFile as File),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('Camera'),
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.add),
      ),
    );
  }
}
