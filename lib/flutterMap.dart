import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';


void main() => runApp(new MaterialApp( title: 'Mapa OSM', home: MyApp(),));

class MyApp extends StatefulWidget{
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>{

  List<Marker> _listaMakers = [];
  var location = new Location();
  double lat = 0.0;
  double lng = 0.0;
  MapOptions mapOptions;
  LatLng latLng;
  MapController _mapController = new MapControllerImpl();

  @override
  void initState() {
    super.initState();
    this._ouvindo();
  }

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

          return new FlutterMap(
            mapController: this._mapController,
            options: this._criarMapOptions(snapshot.data.latitude, snapshot.data.longitude),
            layers: [
              new TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']
              ),
              new MarkerLayerOptions(
                markers: [
                  new Marker(
                    width: 80.0,
                    height: 80.0,
                    point: new LatLng(this.lat, this.lng),
                    builder: (ctx) =>
                    new Container(
                      child: new Icon(Icons.my_location, color: Colors.blue),
                    ),
                  )
                ]
              ),
            ],
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(

        onPressed:() {
          setState(() {
            this._mapController.move(this.latLng, 16.0);
          });
        },
        child: Center(child: Icon(Icons.location_searching),),
        mini: true,
      ),
    );
  }

  void _addMakers(Marker maker){
    this._listaMakers.add(maker);
  }

  Future<LocationData> _getLocalizacaoAtual() async {
    return await this.location.getLocation();
  }

  MapOptions _criarMapOptions(latitude,longitude){
    this.latLng = new LatLng(latitude, longitude);
    this.mapOptions = new MapOptions(
        center: this.latLng,
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
      );

      return this.mapOptions;
  }

  void _ouvindo(){
      this.location.onLocationChanged().listen((LocationData currentLocation) {
        setState(() {
            this.lat = currentLocation.latitude;
            this.lng = currentLocation.longitude;
        });
      });
      
  }
}