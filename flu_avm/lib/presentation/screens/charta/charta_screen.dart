import 'package:flu_avm/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class ChartaScreen extends StatefulWidget {
  const ChartaScreen({super.key});

  @override
  State<ChartaScreen> createState() => _ChartaScreenState();
}

class _ChartaScreenState extends State<ChartaScreen> {

  CircleAnnotationManager? _circleAnnotationManager;
  

  void _initializeCiecleAnnotations(MapboxMap mapBoxMap){
  
    mapBoxMap.annotations.createCircleAnnotationManager().then((manager){
      _circleAnnotationManager = manager;

      _addVelRenovareMarker();
    });
  }

  Future<void> _addVelRenovareMarker() async{
    final manager = _circleAnnotationManager;

    if(manager == null) return;

    final situs = Position(-122.467895, 37.800126);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MapWidget(
            key: const ValueKey('main_mapa'),
            cameraOptions: CameraOptions(
              center: Point(
                coordinates: Position(-122.467895, 37.800126
                ),
              ),
              zoom: 14.5,
            ),
            styleUri: MapboxStyles.MAPBOX_STREETS,
            onMapCreated: _initializeCiecleAnnotations
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Padding(padding: EdgeInsets.all(8.0),
            child: ComplereForm(),
            ),
          ),
        ],
      ),
    );
  }
}