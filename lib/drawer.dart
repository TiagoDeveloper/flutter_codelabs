import 'package:flutter/material.dart';


void main() => runApp(Application());


class Application extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget{
  
  final String title;

  HomePage({Key key, this.title}) : super(key:key);

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Center(
        child: Text("data"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[

            DrawerHeader(
              child: Text("data"),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),
            ListTile(
              title: Text("Item a"),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text("Item b"),
              onTap: () => Navigator.pop(context),
            )

          ],
        ),
      ),
    );
  }

}