import 'dart:async';

import 'package:flutter/material.dart';
import 'package:skynet_games/login/login.dart';


class Inicio extends StatefulWidget {
  @override
  InicioState createState() => InicioState();

}

  class InicioState extends State<Inicio> {
    @override
    initState(){
      super.initState();
      temporizador();
    }

    temporizador() async{
      Timer(Duration(seconds: 3), irALogin);
    }

    irALogin(){
      Navigator.of(context).pushNamed('/Registro');

    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1c1b1b),
      body: Stack(
        children: <Widget>[
          Align(alignment: Alignment.center),

          Transform.translate(
            offset: Offset(73.0, 179.0),
            child:
            /*onTap: () {
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
              );*/
            Image.asset('assets/images/skynet_games.png')
          ),
          Transform.translate(
            offset: Offset(141.0, 557.0),
            child: Text(
              'Powered by \n    Flutter',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15,
                color: const Color(0xffefe6e6),
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(163.0, 513.0),
            child:

           Image.asset('assets/images/logotipo.png',
           width: 40,
           height: 40,)
          ),
        ],
      ),
    );
  }




  }