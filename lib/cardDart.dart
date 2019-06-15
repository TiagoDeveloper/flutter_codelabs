import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  Widget _myAppBody(){
    var card = new Card(
      child: new Column(
        children: <Widget>[
          new ListTile(
            leading: Icon(Icons.filter_tilt_shift,color: Colors.blue, size: 40.0,),
            title: Text("Cargo"),
            subtitle: Text("Software enginer"),
          ),
          new Divider(color: Colors.blue,indent: 16.0,),
          new ListTile(
            leading: Icon(Icons.email,color: Colors.blue, size: 30.0,),
            title: Text("tiago@gmail.com"),
          ),
          new ListTile(
            leading: Icon(Icons.phone,color: Colors.blue, size: 30.0,),
            title: Text("(31)9 9776 2774"),
          ),
        ],
      ),
    );


    return new Container(
      margin: new EdgeInsets.only(left: 10.0, right: 10.0),
      child: new SizedBox(
        height: 220.0,
        child: card,
      )
    );
  }

  Widget _myAppScatfold(){
    return new Scaffold(
      appBar: AppBar(
        title: Text("QR code Scanner"),
      ),
      body: _myAppBody(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "QR code Scanner",
      home: _myAppScatfold(),
    ); 
  }

}