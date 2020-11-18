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

  MyList() {
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
          title: Text("My Wallet"),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: records.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildItemsForListView(context, index);
            }));
  }

  Container _buildItemsForListView(BuildContext context, int index) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              records[index].name,
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100.0,
                  height: 50.0,
                  color: Colors.white,
                  child: Text("credit : " + records[index].credit.toString()),
                ),
                Container(
                  width: 100.0,
                  height: 50.0,
                  color: Colors.white,
                  child: Text("credit : " + records[index].credit.toString()),
                ),
                Container(
                  width: 100.0,
                  height: 50.0,
                  color: Colors.white,
                  child: Text("credit : " + records[index].credit.toString()),
                ),
              ],
            )
          ],
        ));
  }
}
