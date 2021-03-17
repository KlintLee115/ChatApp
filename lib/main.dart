import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

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
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future futureData;
  Future fetchData() {
    print("Got the datas");
    return http
        .read(Uri.https('jsonblob.com',
            'api/jsonBlob/f70ef30b-85bc-11eb-9929-6fbc47681238'))
        .then((value) => value.split('"')[3]);
  }

  continueGetData() {
    Timer.periodic(Duration(milliseconds: 3000), (timer) {
      setState(() {
        futureData = fetchData();
      });
    });
  }

  void initState() {
    super.initState();
    continueGetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
          future: futureData,
          builder: (context, snapshot) {
            return Text(snapshot.data);
          },
        ),
      ),
    );
  }
}
