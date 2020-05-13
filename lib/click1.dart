import 'package:flutter/material.dart';
import 'dart:async';

class Click1 extends StatefulWidget{
  @override
  _clickGame createState() => _clickGame();
}


class _clickGame extends State<Click1> {


  Timer _timer;
  int _start;
  int _conserver_pour_changer;

//VARIABLE
  int nbreCoupObjectif,tempsRestant,nombreAtteind,niveauAtteinds;
  bool gameStarted;
  String gagnerOuPerdu,forDesign;
  //VARIABLE
    @override
      initState() {
        _start = 10;
        _conserver_pour_changer = 10;

        nbreCoupObjectif = 25;
        nombreAtteind = 0;forDesign='0';

        niveauAtteinds = 1;
        gagnerOuPerdu ='';
        gameStarted =false;
        super.initState();
      }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      Widget Cercle = new Container(
        width: 100,
        height: 100,
        decoration: new BoxDecoration(
          color: Color(0xff009900),
          shape: BoxShape.circle
        ),
      );

      //METHODE
      //INCREMENTER QUAND ON TAPE LE BOUTTON FLOTTANT
      Incrementation() {
        setState(() {
          if(++nombreAtteind >9){
            forDesign='';
          };

        });
      }
      
      void gagner(){
        setState( (){
          gagnerOuPerdu = 'gagner';
          gameStarted = false;
          print('atteinds avant le temps');

          nbreCoupObjectif+= 15;
          _conserver_pour_changer+=1;
          _start = _conserver_pour_changer;
          
          niveauAtteinds++;
          gagnerOuPerdu ='gagner';
          gameStarted =false;

        });
      }

      void perdu(){
        setState( (){
          gagnerOuPerdu = 'perdu';
          gameStarted = false;
          print('fin du temps , perdu');

          if(nbreCoupObjectif >25){
            _conserver_pour_changer--;
            nbreCoupObjectif -= 15;
            niveauAtteinds--;
          }

          _start = _conserver_pour_changer;
          gagnerOuPerdu ='perdu';
          gameStarted =false;
        });
      }


      //GESTION DU CHRONO
      void startTimer() {
        const oneSec = const Duration(seconds: 1);
        _timer = new Timer.periodic(
          oneSec,
              (Timer timer) => setState(
                () {
              if (_start < 1) {
                if(nombreAtteind < nbreCoupObjectif){
                  perdu();
                }else{
                  gagner();
                }
                timer.cancel();
              } else {
                _start = _start - 1;
                if(nombreAtteind >= nbreCoupObjectif){
                  timer.cancel();
                  gagner();
                }
              }
            },
          ),
        );
      }


      //LANCER LE JEU
     void startGame(){
        setState(() {
          gameStarted = true;
          gagnerOuPerdu ='';
          nombreAtteind =0;forDesign='0';
          print('game started');
        });
        startTimer();
     }

      //ACTIVER OU DESACTIVER LE BOTTON D"INCREMENTATION
      verifierEtatJeu() {
        if(gameStarted) {
          return Incrementation();
        }else{
          return null;
        }
      }

      //SCREEN
    return Scaffold(
      appBar: new AppBar(
        title: Center( child :Text('Click game',style: TextStyle(fontSize: 20.0))),
          backgroundColor: Color(0xff009900)
        ),
      body: new SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //DESCRIPTION DU JEU
            Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                  child: Card(
                      color: Color(0xaa000000),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'essayez de faire le nombre de coups indiqué avant l\'ecoulement du temps limite',
                          style: TextStyle(fontSize: 14.0),
                          textAlign: TextAlign.center,
                        ),
                      )),
                )),

                //LIGNE NOMBRE DE COUPS ET TEMPS RESTANT
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          'Objectif : ',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          '$nbreCoupObjectif',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          ' Coups',
                          style: TextStyle(fontSize: 14),
                        ),


                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0,0,0,0),
                          child: Text(
                            'Temps : ',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Text(
                          '$_start',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                        Text(
                          ' s',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    )),

            //NOMBRE DE COUPS ATTEINDS PAR L'UTILISATEUR
                   Padding(
                     padding: const EdgeInsets.fromLTRB(8,10,8,8),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Center(
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Stack(
                                children: <Widget>[
                                  Cercle,
                                  Positioned(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text('$forDesign'+'$nombreAtteind',style: TextStyle(fontSize :20.0,color: Colors.white)),
                                      ],
                                    ),
                                    top: 35,
                                    left: 36.0,
                                  ),

                                ],
                             ),
                           )
                         )
                       ],
                     ),
                   ),

            //NIVEAU ATTEINDS ET BOUTTON COMMENCER QUI REAPPARAITRAS AU NIVEAU SUIVANT
            Text(
              gagnerOuPerdu,
              style: TextStyle(fontSize: 30,color: gagnerOuPerdu=='gagner' ? Color(0xffeed300): Colors.red),
            ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Niveau : ', style: TextStyle(fontSize: 16,color: Color(0xff222222)),),
                    Text('$niveauAtteinds', style: TextStyle(fontSize: 18,color: Color(0xff000000)),),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
                child: Visibility(
                  child: RaisedButton(
                    onPressed: (){
                        startGame();
                      },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Commencer',style: TextStyle(fontSize: 18,color: Colors.white),)
                    ),
                    color: Color(0xff009900),
                  ),
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                visible: gameStarted ? false : true,
                ),
          ),
          ]),
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){verifierEtatJeu();},
          backgroundColor: Color(0xffeed300),
      ),
    );
}//context

}//class



