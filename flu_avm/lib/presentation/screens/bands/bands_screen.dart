import 'package:flu_avm/config/config.dart';
import 'package:flu_avm/presentation/providers/providers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pie_chart/pie_chart.dart';

class BandsScreen extends ConsumerWidget {
  const BandsScreen({super.key});


  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bandsState = ref.watch(bandsProvider);
    final serverStatus = ref.watch(bandsProvider).serverStatus;

    return Scaffold(
      appBar: AppBar(
        title: Text('Bandas de music'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: (serverStatus == ServerStatus.Online)
            ? const Icon(Icons.check_circle, color: Colors.green,)
            : const Icon(Icons.offline_bolt, color: Colors.red,),
          )
        ],
      ),
      body: Column(
        children: [
          _videreData(bandsState.bands),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount:bandsState.bands.length,
              itemBuilder: (context, index) {
                return _bandTile(context, ref, bandsState.bands[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: bandsState.bands.length < 7 ? true : false,
        child: FloatingActionButton(
          elevation: 1,
          onPressed: () => addereNuvumBand(context,ref),
          child: Icon(Icons.add),),
      ),
    );
  }

  Widget _videreData( List<Band> bands ) {

    // ignore: prefer_collection_literals
    Map<String, double> dataMap = Map(); 

    for (var band in bands) { 
      dataMap.putIfAbsent(band.nomen, () => band.numerusVotum.toDouble() );
    }

    final List<Color> colorList = [
      Colors.pink.shade100,
      Colors.pink.shade300,
      Colors.blue.shade200,
      Colors.blue.shade600,
      Colors.lightGreen.shade200,
      Colors.lightGreen.shade600,
    ];
    
    return dataMap.isNotEmpty ? Container(
      padding: const EdgeInsets.only(left: 5, top: 5),
      width: double.infinity,
      height: 200.0,
      child: PieChart(
        dataMap: dataMap,
        animationDuration: const Duration(milliseconds: 800),
        colorList: colorList,
        chartType: ChartType.ring,
        legendOptions: const LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "CupertinoSystemText", fontSize: 17,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValues: dataMap.length <= 6, // con más de 6 no se ve el valor
          showChartValueBackground: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: false,
        ),
      ),
  ) : const LinearProgressIndicator();
}

  Widget _bandTile(BuildContext context, WidgetRef ref, Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {

        ref.read(bandsProvider.notifier).delereBand(band.id);

      },
      background: Container(
        padding: EdgeInsets.only(left: 8),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("Delete band", style:  TextStyle(color: Colors.white),),
        ),
      ),
      child: ListTile(
            leading: CircleAvatar(
              child: Text(band.nomen.substring(0,2).toUpperCase()),
            ),
            title: Text(band.nomen),
            trailing: Text('${band.numerusVotum}', style: TextStyle(fontSize: 20),),
            onTap: (){
              ref.read(bandsProvider.notifier).addereVotum(band.id);
            },
          ),
    );
  }

  addereNuvumBand(BuildContext context, WidgetRef ref){

    final textumController = TextEditingController();

    
    /*showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("New band name:"),
          content: TextField(controller: textumController,),
          actions: [
            MaterialButton(
              onPressed:() => addereBandAdCollectione(context, textumController.text),
              textColor: Colors.blue,
              child: Text("add"), 
            )
          ],
        );
      },
    );*/
    showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('New band name'),
      content: CupertinoTextField(
        controller: textumController,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
      ),
    ),
    
    actions: [
      CupertinoDialogAction(
        isDefaultAction: true,
        child: const Text('Add'),
        onPressed: () {
          ref.read(bandsProvider.notifier).addereBand(textumController.text);
          context.pop();
        },
      ),
      CupertinoDialogAction(
        isDestructiveAction: true,
        child: const Text('Close'),
        onPressed: () => context.pop(),
      ),
    ],
  ),
);
  }

}