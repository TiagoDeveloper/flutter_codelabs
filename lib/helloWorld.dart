import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
    @override
    Widget build(BuildContext context){
      return MaterialApp(
        title: "Titulo da activity",
        theme: ThemeData(
          primaryColor: Colors.black
        ),
        home: Teste()
      );
    }
    
}
class Teste extends StatefulWidget{
  TesteState createState() => TesteState();
}
class TesteState extends State<Teste>{
    
    Widget build(BuildContext context){
      return _conteudo();
    }
    Widget _conteudo(){
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.list, color: Colors.white,),onPressed: _proximaPagina,),
          title: Text("Titulo bar"),

        ),
        body:Center(
          child: Text("Ben venido"),
        )
      );
    }

    void _proximaPagina(){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondRoute()),
        // MaterialPag
      );
    }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}