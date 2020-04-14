import 'package:carros/pages/carro/carro.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatelessWidget {
  final Carro carro;

  MapaPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(carro.nome),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: GoogleMap(
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: carro.latlng(),
          zoom: 17
        ),
        markers: Set.of(_getMarkers()),
      ),
    );
  }

  List<Marker> _getMarkers() {
    return [
      Marker(
        markerId: MarkerId("1"),
        position: carro.latlng(),
        infoWindow: InfoWindow(
          title: "Title: ${carro.nome}",
          snippet: "Snippet: ${carro.nome}",
          onTap: () {
            print("Clicou na janela");
          }
        ),
        onTap: () {
          print("Clicou no marcador");
        }
      )
    ];
  }

//  latLng() {
//    return LatLng(-22.951911, -43.2126759);
//  }
}
