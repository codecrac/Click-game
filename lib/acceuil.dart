import 'package:flutter/material.dart';
import 'click1.dart';
import 'contact_dev.dart';
import 'package:flutter_test_app/Avancement.dart';

import 'Database.dart';
class PageAcceuil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 100.0,
              backgroundColor: Colors.brown,
              backgroundImage: AssetImage('assets/images/gong.jpg'),
            ),
            Center(
              child: Text(
                'Click game',
                style: TextStyle(fontSize: 25.0, color: Colors.brown),
              ),
            ),
            Card(
              color: Colors.transparent,
              elevation: 0.0,
                child: Padding(
                padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RaisedButton(
                            elevation: 10.0,
                            onPressed: ()=> _goToClickGame(context),
                            child: Text('Commencer', style: TextStyle(color: Colors.white),),
                            color: Colors.brown,
                          ),
                          RaisedButton(
                            elevation: 5.0,
                            onPressed: () => _goToContactDev(context),
                            child: Text('Developpeur', style: TextStyle(color: Colors.white),),
                            color: Colors.brown,
                          ),
                    ],
                    )
                  ),
                )
            )
          ]),
    );

  }

      _goToClickGame(BuildContext context) async {

        print('EXECUTION DE DK');
        dk();
//        final run = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
//                        return Click1();
//                        }
//        ));
      }

      _goToContactDev(BuildContext context) async{
        final run = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
           return ContactDev();
         }
       ));
      }
  void dk() async{
//    print('cretingggggggggggggggggggggggggggggggggggg');
//    await DatabaseClient().createNewItem();

    var p = new Avancement(1, 25, 10);
    DatabaseClient().updateItem(p);

  }
}



