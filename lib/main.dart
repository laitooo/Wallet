import 'package:Wallet/database.dart';
import 'package:flutter/material.dart';
import 'package:Wallet/record_screen.dart';
import 'package:Wallet/models.dart';
import 'package:Wallet/dialogs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  AppDatabase.started = true;

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
      initialRoute: '/list',
      routes: {
        '/list' : (context) => MyList(),
        '/record' : (context) => RecordDetail(),
      },
    );
  }
}

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Wallet"),
      ),
      body: FutureBuilder(
        future: loadRecords(),
        builder: (context, snapshot) {
          List<Record> list = snapshot.data ?? [];
          return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildItemsForListView(context, index, list[index]);
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return NewRecordDialog();
              },
            );
          }),
    );
  }

  Container _buildItemsForListView(
      BuildContext context, int index, Record record) {
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
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/record');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              record.name,
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
                textBox("credit : \n" + record.credit.toString()),
                textBox("debit : \n" + record.debit.toString()),
                textBox("balance : \n" + record.balance.toString()),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget textBox(String text) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      width: 110.0,
      height: 80.0,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.blue, fontSize: 24.0, height: 1.4),
        ),
      ),
    );
  }
}

Future<List<Record>> loadRecords() async {
  Future<List<Record>> list = AppDatabase.getAllProducts();
  return list;
}
