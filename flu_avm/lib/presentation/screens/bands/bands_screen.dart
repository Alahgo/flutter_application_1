import 'package:flu_avm/config/config.dart';
import 'package:flutter/material.dart';

class BandsScreen extends StatelessWidget {
  const BandsScreen({super.key});


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandas de music'),
      ),
      body: ListView.builder(
        itemCount:bands.length,
        itemBuilder: (context, index) {
          return _bandTile(bands[index]);
        },
      )
    );
  }

  ListTile _bandTile(Band band) {
    return ListTile(
          leading: CircleAvatar(
            child: Text(band.nomen.substring(0,2).toUpperCase()),
          ),
          title: Text(band.nomen),
          trailing: Text('${band.numerusVotum}', style: TextStyle(fontSize: 20),),
          onTap: (){
            print(band.nomen);
          },
        );
  }
}