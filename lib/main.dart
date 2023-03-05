import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyhomePage(),
    );
  }
}

class MyhomePage extends StatefulWidget {
  const MyhomePage({super.key});

  @override
  State<MyhomePage> createState() => _MyhomePageState();
}

class _MyhomePageState extends State<MyhomePage> {
  List<Item> basketItems = [];
  @override
  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  fetchData() async {
    var records =
        await FirebaseFirestore.instance.collection('basket_items').get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs
        .map((item) =>
            Item(id: item.id, name: item['name'], quantity: item['quantity']))
        .toList();

    setState(() {
      basketItems = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future fetchData() async {
    //   var records =
    //       await FirebaseFirestore.instance.collection('basket_items').get();

    //   print(records.docs.length);
    // }

    return Scaffold(
        appBar: AppBar(
          title: Text('hello'),
        ),
        body: ListView.builder(
          itemCount: basketItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(basketItems[index].name),
              subtitle: Text(basketItems[index].quantity),
            );
          },
        ));
  }
}
