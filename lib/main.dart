import 'package:flutter/material.dart';
import 'acceuil.dart';

void main()=> runApp(MyApp());


class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
//        appBar: new AppBar(
//          title: Text('Test app',style: TextStyle(fontSize: 15.0,color: Colors.white),),
//          backgroundColor: Colors.brown,
//        ),
        body: PageAcceuil()
      )
    );
  }

}
