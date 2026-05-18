import 'package:flu_avm/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../../providers/providers.dart';

class ChartaScreen extends ConsumerStatefulWidget{
  const ChartaScreen({super.key});

  @override
  ConsumerState<ChartaScreen> createState() => _ChartaScreenState();
}

class _ChartaScreenState extends ConsumerState<ChartaScreen> {

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

    final placed = ref.read(markerPositumProvider);

    if(!placed){
      await manager.deleteAll();
      return;
    }

    final situs = Position(-122.467895, 37.800126);
    final color = ref.read(formColorProvider);

    final optiones = CircleAnnotationOptions(
        geometry: Point(coordinates: situs),
        circleColor: color.toARGB32(),
        circleRadius: 14,
        circleStrokeColor: Colors.white.toARGB32(),
        circleStrokeWidth: 2,
        isDraggable: true,
      );

      try {
        await manager.create(optiones);
      } catch (e) {
        debugPrint('Error al crear el marcador: $e');
      }
  }

  @override
  Widget build(BuildContext context) {

    ref.listen(markerPositumProvider, (prev, next) {
      if(next) _addVelRenovareMarker();
    });


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