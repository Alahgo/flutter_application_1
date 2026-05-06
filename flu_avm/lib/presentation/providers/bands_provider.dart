import 'package:flutter_riverpod/legacy.dart';
import 'package:flu_avm/config/config.dart';

final bandsProvider = StateNotifierProvider<BandsNotifier,List<Band>>((ref){
  return BandsNotifier();
});

class BandsNotifier extends StateNotifier<List<Band>>{
  
  //Esto es el state
  BandsNotifier() : super([
    Band(id: '1', nomen: 'Quien', numerusVotum: 4),
    Band(id: '2', nomen: 'Bronzalica', numerusVotum: 2),
    Band(id: '3', nomen: 'Bon Juani', numerusVotum: 8),
    Band(id: '4', nomen: 'MILKA', numerusVotum: 1)
  ]);

  void addereBand(Band band){
    state = [...state, band];
  }

  void delereBand(Band band){
    state = state.where((b) => b.id != band.id ).toList();
  }

  void addereVotum(Band band){
    state = state.map((b) {
      return b.id == band.id 
        ? b.copyWith(numerusVotum: b.numerusVotum + 1)  
        : b;
    }).toList();
  }
}