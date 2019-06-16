import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  return runApp(new MaterialApp(
    title: 'Chanel teste',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget{
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp>{
  Future<File> imageFile;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Chanel teste'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            showImage(),
            RaisedButton(
              child: Text("Select Image from Gallery"),
              onPressed: () {
                pickImageFromGallery(ImageSourceTest.gallery);
              },
            )
          ],
        ),
      ),
    );
  }

  pickImageFromGallery(ImageSourceTest source) {
    setState(() {
      imageFile = ImagePickerTest.pickImage(source: source);
    });
  }
 
  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

}

class ImagePickerTest{
  //TODO: Aprender a fazer plugin para usá-lo dessa forma
  static const MethodChannel _channel = MethodChannel('plugins.flutter.io/image_picker');
  static Future<File> pickImage({ @required ImageSourceTest source }) async {
   
    assert(source != null);

    final String path = await _channel.invokeMethod<String>(
      'pickImage',
      <String, dynamic>{
        'source': source.index,
      },
    );

    return path == null ? null : File(path);
  }
}




enum ImageSourceTest {
  camera,
  gallery,
}