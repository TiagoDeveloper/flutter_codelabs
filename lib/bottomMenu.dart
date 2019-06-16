import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  MyAppState createState(){
    return new MyAppState();
  } 
}

class MyAppState extends State<MyApp>{
  
  int _paginaSelecionada = 0;
  final _menuOptions = [
    Text('Home'),
    Text('Work'),
    Text('landscape'),
  ];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Bottom menu',
      home: new Scaffold(
        appBar: AppBar(
          title: Text('Bottom menu'),
        ),
        body: _menuOptions[_paginaSelecionada],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _paginaSelecionada,
          onTap: (int index){
            setState(() {
              _paginaSelecionada = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              title: Text('Work')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.landscape),
              title: Text('Landscape')
            )
          ],
        ),
      ),
    );
  }
}