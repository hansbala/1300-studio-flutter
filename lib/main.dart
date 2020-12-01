import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI/UX Studio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'UI/UX Studio - IP Address Info'),
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
    String _ipAddress = "";
    String _city = "";
    String _country = "";
    double _lat = 0.0;
    double _long = 0.0;

    String ipAPICall = "https://freegeoip.app/json/";

    void _generateIPInfo() async {
        final res = await http.get(ipAPICall);
        var response = convert.jsonDecode(res.body);
        setState(() {
            _ipAddress = response["ip"];
            _country = response["country_name"];
            _city = response["city"];
            _lat = response["latitude"];
            _long = response["longitude"];
        });
    }

    void _generateAll() {
        _generateIPInfo();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_ipAddress',
            ),
            Text(
              '$_country',
            ),
            Text(
              '$_city',
            ),
            Text(
              '$_lat',
            ),
            Text(
                '$_long',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateAll,
        tooltip: 'Generate',
        child: Icon(Icons.autorenew),
      ), 
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, 
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
