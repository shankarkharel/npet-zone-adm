// ignore_for_file: deprecated_member_use, avoid_print, unnecessary_new, unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'shared.dart' as constant;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DemoUploadImage(),
    );
  }
}

class DemoUploadImage extends StatefulWidget {
  const DemoUploadImage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DemoUploadImageState createState() => _DemoUploadImageState();
}

class _DemoUploadImageState extends State<DemoUploadImage> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String path = constant.path;

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future uploadImage() async {
    //http: //192.168.0.117/backend/image_upload_php_mysql/viewAll.php
    final uri = Uri.parse("$path/backend/image_upload_php_mysql/upload.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = nameController.text;
    request.fields['brand'] = brandController.text;
    request.fields['price'] = priceController.text;
    request.fields['description'] = descriptionController.text;
    var pic = await http.MultipartFile.fromPath("image", _image!.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Uploded');
      log(response.toString());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Upload successful')),
      );
    } else {
      log('Image Not Uploded');
      log(response.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: brandController,
                decoration: const InputDecoration(labelText: 'brand'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'price'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: descriptionController,
                maxLines: 6,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ),
            const Text("Add a image of the product"),
            IconButton(
              icon: const Icon(
                Icons.upload_outlined,
              ),
              iconSize: 50.0,
              color: Colors.red,
              onPressed: () {
                choiceImage();
              },
            ),
            Container(
              child: _image == null
                  ? const Text('No Image Selected')
                  : Image.file(_image!),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: RaisedButton(
                color: Colors.amber,
                child: const Text('Add product'),
                onPressed: () {
                  uploadImage();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const AllPersonData(),
                  //   ),
                  // );
                },
              ),
            ),
            const SizedBox(
              height: 100.0,
            )
          ],
        ),
      ),
    );
  }
}
