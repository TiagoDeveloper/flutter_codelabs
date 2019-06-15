import 'package:flutter/material.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp>{
  MenuOption m  = new MenuOption(
    Text("home"),
    BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home')
    )
  );
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

class MenuOption{

  Widget conteudo;
  var item;

  MenuOption(Widget conteudo, item){
    this.conteudo = conteudo;
    this.item = item;
  }
  


}