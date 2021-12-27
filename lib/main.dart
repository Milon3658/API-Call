import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<Albam> rawAlbam()async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/3'));
  print(response.body);
  if (response.statusCode == 200){
    return Albam.fromJson(jsonDecode(response.body));
  }else{
    throw Exception("error");
  }
}


class Albam{
  final int ID;
  final int userID;
  final String Title;


  Albam({required this.Title, required this.ID, required this.userID});

  factory Albam.fromJson(Map<String, dynamic> json){
    return Albam(Title: json['title'], ID: json['id'], userID:json['userId'] );
  }
}



 void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var superAlbam;

  @override
  void initState() {
    super.initState();
    superAlbam = rawAlbam();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Center(
          child: FutureBuilder<Albam>(
            future: superAlbam,
            builder: (context,snapshot){
              if(snapshot.hasData){
                return Text(snapshot.data!.userID.toString());
              }else if(snapshot.hasError){
                return Text('${snapshot.error}');
              }else{
                return CircularProgressIndicator();
              }
            },
          ),
        )
      ),
    );
  }
}




