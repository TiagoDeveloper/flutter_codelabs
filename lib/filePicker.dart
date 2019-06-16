import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main(){
  return runApp(
    new MaterialApp(
      title: 'File picker',
      home: new MyApp(),
    )
  );
}

class MyApp extends StatefulWidget{
  MyAppState createState() => new MyAppState();
}
class MyAppState extends State<MyApp>{
  
  List<File> files = <File>[];
  // final _suggestions = <File>[];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('File picker'),
      ),
      body: new Container(
        child: new FutureBuilder(
          future: _file(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return new Container(child: Text("Loading..."),);
              }
            return new ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context,int i){
                if (i.isOdd) return Divider();
                
                // final index = i ~/ 2; /*3*/
                final index = i; /*3*/
                if (index >= files.length) {
                  files.addAll(snapshot.data.skip(index).take(10));
                }
                return new Container(
                  // child: Text(files[index].path+' < == > $index'),
                  child: ListTile(
                    leading: new ClipRRect(
                      borderRadius: BorderRadius.circular(90.0),
                      clipBehavior: Clip.hardEdge,
                      child: Image.file(files[index], height: 190.0, width: 90.0, ),
                    ), 
                    title: Text('$index'),
                  ) 
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<File>> _file() async {
    var root = await getExternalStorageDirectory();
    var fm = FileManager(root: root);
    
    return await fm.filesTree(extensions:['.jpg','.jpeg'], excludedPaths: ["/storage/emulated/0/Android"]);
  }

  
}
