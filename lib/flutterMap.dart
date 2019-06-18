import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';


void main() => runApp(new MaterialApp( title: 'Mapa OSM', home: MyApp(),));

class MyApp extends StatefulWidget{
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>{

  List<Marker> _listaMakers = [];
  var location = new Location();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Mapa OSM")),
      ),
      body: FutureBuilder(
        future: _getLocalizacaoAtual(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.data==null){
            return Center(child: Text('Loading...'),);
          }
          if(_listaMakers.length == 0){
            _addMakers(
              new Marker(
                width: 80.0,
                height: 80.0,
                point: new LatLng(snapshot.data.latitude, snapshot.data.longitude),
                builder: (ctx) =>
                new Container(
                  child: new Icon(Icons.my_location, color: Colors.blue),
                ),
              ),
            );
          }

          return new FlutterMap(
            options: new MapOptions(
              center: new LatLng(snapshot.data.latitude, snapshot.data.longitude),
              zoom: 16.0,

              onTap: (clickLocation) {
                setState(() {
                  _addMakers(
                    new Marker(
                      width: 80.0,
                      height: 80.0,
                      point: new LatLng(clickLocation.latitude, clickLocation.longitude),
                      builder: (ctx) =>
                      new Container(
                        child: new Icon(Icons.location_on, color: Colors.red),
                      ),
                    ),
                  );
                  
                });

              }
            ),
            layers: [
              new TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']
              ),
              new MarkerLayerOptions(
                markers: this._listaMakers
              ),
            ],
          );
        },
      ),
    );
  }

  void _addMakers(Marker maker){
    this._listaMakers.add(maker);
  }

  Future<LocationData> _getLocalizacaoAtual() async {
    return await this.location.getLocation();
  }

}