import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'envoi_de_message.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ContactDev extends StatefulWidget{
  @override
  _ContactDevState createState() => new _ContactDevState();
}

//ENVOYER MESSAGE
final TextEditingController contactController = new TextEditingController();
final TextEditingController messageController = new TextEditingController();

class _ContactDevState extends State<ContactDev>{
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return new FlutterEasyLoading(
        child: new Scaffold(
          appBar: new AppBar(
            title: Text("Developper par"),
            backgroundColor: Colors.brown,
          ),
          body: new SingleChildScrollView(
            child : new Center(
                child: Column(
                  children: <Widget>[
                    Image.asset(
                        "assets/images/moi.jpg",
                        width: width,
                        height: height/2.5,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child : Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  "LADDE AUGUSTIN JEAN YVES",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                  )
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container( height: 50.0),
                              Icon(Icons.mail),
                              Text(
                                  "    yvesladde@gmail.com",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic
                                  )
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.phone_android),
                              Text(
                                  " 78 73 57 84 / 55 99 40 41",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic
                                  )
                              )
                            ],
                          ),
                        ],
                      )

                    ),

                    new Text("Pas de credit ?"),
                    Icon(Icons.arrow_downward),
                    new RaisedButton(
                        color: Colors.brown,
                        child: Text(
                            "Envoyer un sms via internet",
                            style: TextStyle(color: Colors.white),
                        ),
                        onPressed: showModalEnvoi
                    )
                  ],
                )
              ),
          )
        )
    );
  }

  Future<Null> showModalEnvoi() async{
    print('as click');
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new SimpleDialog(
              title: Text("Envoyer un message via internet"),
              contentPadding: EdgeInsets.all(10.0),
              children: <Widget>[
                Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new IconButton(icon: new Icon(Icons.clear), onPressed: closeModal,iconSize: 40.0,color: Colors.brown,)
                        ],
                      ),
                      Text("Votre contact"),
                      TextField(controller: contactController,keyboardType: TextInputType.number),
                      Text("Votre message"),
                      TextField(maxLines: 3,controller: messageController),
                      RaisedButton(
                        onPressed: ()=>{Envoyer(contactController.text, messageController.text)},
                        child: Text("Envoyer",style: TextStyle(color: Colors.white)),color: Colors.brown,
                      ),

                    ],
                  )
              ],

          );
        }
    );
  }

  Future<Null> showAlertReponse(String notif,bool reponsePostive,String contactExpediteur,String messageEntrer) async{
    print('reponse recue');
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          if(reponsePostive){
            contactController.clear();
            messageController.clear();
          }
          return new SimpleDialog(
              title: Text(""),
              contentPadding: EdgeInsets.all(10.0),
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child : Text(
                            notif,
                            style: TextStyle(color: (reponsePostive) ? Colors.green : Colors.red ),
                          )
                      ),
                      Text("Contact : $contactExpediteur",),
                       SizedBox(height:32.0),
                      Text("Message : $messageEntrer"),
                        SizedBox(height:32.0),
                      RaisedButton(
                        onPressed: closeModal,
                        child: Text("Ok",style: TextStyle(color: Colors.white)),
                        color: (reponsePostive) ? Colors.green : Colors.red,
                      ),

                    ],
                  )
              ],

          );
        }
    );
  }

  void Envoyer(String contact, String msg) {
    print("send message");
    initRequete(contact,msg);
//    closeModal();
  }

  void closeModal() {
    print("juste close modal");
    Navigator.pop(context);
  }


  bool problemeDeConnection = false;
  Future<Null> initRequete(String contact, String message) async{

        closeModal();
        EasyLoading.show(status:'Chargement...');

        //for prod
        final urlCible = 'https://stricka.000webhostapp.com/sms_api/traitement_requete.php';
        //for dev
//        final urlCible = 'http://192.168.43.247/tout%20seul/sms_api/traitement_requete.php';

//        var reponseBienFormer = true;
        final reponse = await http.post(urlCible,body:{
          "contact" : contact,
          "message" : message
        });

//    EasyLoading.dismiss();
        if(reponse.statusCode==200){
          final String reponseEnString = reponse.body;
          print(reponseEnString);
            var obj = envoiDeMessageFromJson(reponseEnString);

            if(obj.statut=='succes'){
                contactController.clear();
                messageController.clear();

              EasyLoading.showSuccess(obj.notif,duration: Duration(seconds: 3));
//              showAlertReponse(obj.notif, true,obj.contact, obj.message);
            }else{
//              await EasyLoading.showError(obj.notif,duration: Duration(seconds: 3));
              showModalEnvoi();
              showAlertReponse(obj.notif,false,obj.contact, obj.message);
            }
    ////    return envoiDeMessageFromJson(reponseEnString);
          return new Future(null);
        }else{
          EasyLoading.showError("Echec d'envoi verifier votre connexion, rééssayer",duration: Duration(seconds: 4));
          var timer = Timer(Duration(seconds: 4), ()=> showModalEnvoi());

//          showAlertReponse("Erreur de connexion, rééssayer",false,contact,message);
        return new Future(null);
        }

  }

}//_stateContactDev