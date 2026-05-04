class Band{
  String id;
  String nomen;
  int numerusVotum;

  Band ({
    required this.id,
    required this.nomen,
    required this.numerusVotum

  });



  
}
  List<Band> bands = [
    Band(id: '1', nomen: 'Quien', numerusVotum: 4),
    Band(id: '2', nomen: 'Bronzalica', numerusVotum: 2),
    Band(id: '3', nomen: 'Bon Juani', numerusVotum: 8),
    Band(id: '4', nomen: 'MILKA', numerusVotum: 1)
  ];