import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  
  void _onQRViewCreated(QRViewController controller) {
    final channel = controller.channel;
    controller.init(qrKey);
    channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case "onRecognizeQR":
          dynamic arguments = call.arguments;
          setState(() {
            qrText = arguments.toString();
          });
      }
    });
  }
  Widget _cardOne(){
    var card = new Card(
      child: new Container(
        margin: new EdgeInsets.only(left: 50.0, right: 50.0,top: 20.0, bottom: 20.0),
        child:new SizedBox(
          height: 220.0,
          child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
          ),
        )
      )
    );
    return card;
  }
  Widget _cardTwo(){
    var card = new Card(
      child: new ListTile(
            leading: Icon(Icons.scanner,color: Colors.blue, size: 40.0,),
            title: Text("Resultado: $qrText"),
        ),
    );
    return card;
  }

  Widget _myAppBody(){
    return new Column(
      children: <Widget>[
        _cardOne(),
        _cardTwo()
      ],
    );
  }

  Widget _myAppScaffold() {
    return new Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: new SingleChildScrollView(
        child: _myAppBody(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Scanner QRCODE",
      home: _myAppScaffold(),
    );
  }
}
