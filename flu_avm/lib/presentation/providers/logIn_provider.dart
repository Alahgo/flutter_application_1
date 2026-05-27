import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../config/config.dart';



class LogInProvider extends StateNotifier<ServerState> {
  late IO.Socket _socket;


  LogInProvider() : super(ServerState()) {
    _initSocket();
  }

  void _initSocket() {
    _socket = IO.io('http://192.168.68.57:3201', IO.OptionBuilder()
      .setTransports(['websocket'])
      .enableAutoConnect()
      .build());

    _socket.onConnect((_) {
      print('¡Conectado al servidor de Bun!');
   
      state = state.copyWith(isConnected: true);
      _socket.emit('GET_PARTIDA');
    });

    _socket.onDisconnect((_) {
      print('Desconectado del servidor.');
    
      state = ServerState(isConnected: false, partida: null);
    });

    _socket.on('GET_PARTIDA', (data) {
      if (data != null) {
        final partidaActualizada = Partida.fromJson(data as Map<String, dynamic>);
     
        state = state.copyWith(partida: partidaActualizada);
      }
    });

    _socket.on('JUGADORES_LISTOS', (data) {
      if (data != null) {
       
        state = state.copyWith(puedeComenzar: data as bool);
      }
    });

  }

  // --- ACCIONES ---
  void unirseALaPartida(String nombreUsuario) => _socket.emit('ADD_PLAYER', nombreUsuario);
  void salirDeLaPartida(String nombreUsuario) => _socket.emit('REMOVE_PLAYER', nombreUsuario);
  void ponerFicha(int posicion) => _socket.emit('PONER_FICHA', posicion);
  void reiniciarPartida() => _socket.emit('REINICIAR_PARTIDA');
  void verificarJugadoresPreparados() => _socket.emit('CAN_START');


  @override
  void dispose() {
    _socket.dispose();
    super.dispose();
  }
}


final loginProvider = StateNotifierProvider<LogInProvider, ServerState>((ref) {
  return LogInProvider();
});

final usuarioActualProvider = StateProvider<String?>((ref) => '');

final usuarioLogeadoProvider = Provider<bool>((ref) {
  final serverState = ref.watch(loginProvider);
  
 
  if (serverState.isConnected && serverState.partida != null) {
    final partida = serverState.partida!;
    final miNombre = ref.watch(usuarioActualProvider);
    
    return miNombre != null && miNombre.isNotEmpty && 
           (partida.player1 == miNombre || partida.player2 == miNombre);
  }
  return false;
});