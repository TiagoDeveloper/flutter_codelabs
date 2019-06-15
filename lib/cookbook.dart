import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      title: "data",
      home: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.filter_2),onPressed:(){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => SecondRoute())
            );
          },),
          title: Text("data"),
        ),
        body: Center(
          child: Text("data"),
        ),
      );
  }
}
class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.filter_1,),
          onPressed:() => Navigator.pop(context),
        ),
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
