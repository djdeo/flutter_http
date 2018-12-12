import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(home: StarWarsData()));
}

class StarWarsData extends StatefulWidget {
  _StarWarsDataState createState() => _StarWarsDataState();
}

class _StarWarsDataState extends State<StarWarsData> {
  final String url = "https://swapi.co/api/starships";
  List data;

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var resBody = json.decode(res.body);
      data = resBody["results"];
    });
    return "Sucess!";
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Wars Starships'),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Name: ${data[index]["name"]}",
                    style: TextStyle(fontSize: 18.0, color: Colors.black87),
                  ),
                  Text(
                    "model: ${data[index]["model"]}",
                    style: TextStyle(fontSize: 18.0, color: Colors.red),
                  ),
                  Text(
                    "Cargo Capacity: ${data[index]["cargo_capacity"]}",
                    style: TextStyle(fontSize: 18.0, color: Colors.teal),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
