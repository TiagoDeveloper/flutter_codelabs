import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() => runApp(MaterialApp(home: QRViewExample()));

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 10,
              child: Card(
                // color: Color.fromARGB(255, 0, 0, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Container(
                  width: 200,
                  height: 200,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  )
                ),
              ),
            ),Positioned(
              bottom: 10,
              child: Card(
                
                // color: Color.fromARGB(255, 0, 0, 255),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10)
                // ),
                child: Container(
                  width: 300,
                  height: 100,
                  child: Text("This is the result of scan: $qrText")
              ),
            )
          )
          ]
        )
      )
    );
  }

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
}

// Widget build(BuildContext context) {
//   return Center(
//     child: Card(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           const ListTile(
//             leading: Icon(Icons.album),
//             title: Text('The Enchanted Nightingale'),
//             subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
//           ),
//           ButtonTheme.bar( // make buttons use the appropriate styles for cards
//             child: ButtonBar(
//               children: <Widget>[
//                 FlatButton(
//                   child: const Text('BUY TICKETS'),
//                   onPressed: () { /* ... */ },
//                 ),
//                 FlatButton(
//                   child: const Text('LISTEN'),
//                   onPressed: () { /* ... */ },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Column(
//         children: <Widget>[
//           Expanded(
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//             flex: 4,
//           ),
//           Expanded(
//             child: Text("This is the result of scan: $qrText"),
//             flex: 2,
//           )
//         ],
//       )