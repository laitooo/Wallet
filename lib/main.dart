import 'package:flutter/material.dart';
import 'package:Wallet/models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyList(),
    );
  }
}


class MyList extends StatelessWidget {
  List<Record> records = List<Record>();


  MyList(){
    records.add(Record(0, "record1", 2, 20.0, 30.0, -10.0));
    records.add(Record(1, "record2", 3, 0.0, 14.0, -14.0));
    records.add(Record(2, "record3", 4, 40.0, 30.0, 10.0));
    records.add(Record(3, "record4", 5, 200.0, 15.0, 185.0));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
          appBar: AppBar(
            title: Text("Records"),
          ),
          body: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: records.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildItemsForListView(context, index);
              }
          )
        );
  }

  Container _buildItemsForListView(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text(records[index].name),
          SizedBox(height: 10.0,),
          Row(
            children: [
              Text("credit : " + records[index].credit.toString()),
              SizedBox(width: 20.0,),
              Text("credit : " + records[index].credit.toString()),
              SizedBox(width: 20.0,),
              Text("credit : " + records[index].credit.toString()),
            ],
          )
        ],
      )
    );
  }

}
