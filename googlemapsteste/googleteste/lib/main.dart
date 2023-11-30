import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

// Classe principal do aplicativo (MyApp)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retorna um MaterialApp, que é o widget principal para criar um aplicativo Material Design
    return const MaterialApp(
      // Título do aplicativo
      title: 'Flutter Google Maps Demo',
      // Tela inicial do aplicativo, representada por um objeto da classe MapSample
      home: MapSample(),
    );
  }
}

// Classe que representa a tela principal do aplicativo (MapSample)
class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

// Classe de estado correspondente à tela principal (MapSample)
class MapSampleState extends State<MapSample> {
  // Completer é usado para aguardar a conclusão de uma operação assíncrona
  final Completer<GoogleMapController> _controller = Completer();

  // Posições estáticas no mapa
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    // Retorna um Scaffold, que é uma estrutura básica da interface do usuário do aplicativo
    return Scaffold(
      // Corpo do Scaffold contendo um GoogleMap
      body: GoogleMap(
        // Tipo de mapa (híbrido, satélite, etc.)
        mapType: MapType.hybrid,
        // Posição inicial da câmera no mapa
        initialCameraPosition: _kGooglePlex,
        // Callback chamado quando o mapa é criado
        onMapCreated: (GoogleMapController controller) {
          // Completa o Completer quando o mapa é criado
          _controller.complete(controller);
        },
      ),
      // Botão flutuante que, quando pressionado, chama o método _goToTheLake
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  // Método assíncrono chamado quando o botão "To the lake!" é pressionado
  Future<void> _goToTheLake() async {
    // Obtém o controlador do GoogleMap quando estiver disponível
    final GoogleMapController controller = await _controller.future;
    // Anima a câmera para a posição do lago
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
