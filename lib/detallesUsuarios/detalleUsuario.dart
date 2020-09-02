
import 'package:flutter/material.dart';
import 'package:skynet_games/detallesUsuarios/separador.dart';
import 'package:skynet_games/detallesUsuarios/resumenUsuario.dart';
import 'package:skynet_games/lista/usuario.dart';
import 'package:skynet_games/login/login.dart';
import 'package:skynet_games/menu/menuDespegable.dart';
import 'package:skynet_games/registros/registro.dart';

import '../global.dart';
import '../main.dart';

class DetalleUsuario extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Detalles',
      theme: ThemeData(
          primarySwatch: Colors.green
      ),
      home: DetailsUsuario(title: 'Detalles'),
      routes: <String, WidgetBuilder>{ //aplicacion de rutas
        '/SkynetApp' : (BuildContext context) => SkynetApp(),
        '/Login' : (BuildContext context) => Login(),
        '/Registro' : (BuildContext context) => Registro(),
        '/DetalleUsuario' : (BuildContext context) => DetalleUsuario(),


      },
    );
  }

}
class DetailsUsuario extends StatelessWidget{
  final String title ;
  DetailsUsuario({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: const Color(0xff1c1b1b),
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            InkWell(
              child: Icon(Icons.arrow_back_ios),
              onTap: (){
                Navigator.of(context).pushReplacementNamed('/SkynetApp');

              },
            ),
            SizedBox(width: 10),
          ],
        ),
      body: Details(),
        drawer: MenuDespegable(),
    );
  }

}
class Details extends StatefulWidget{
  @override
  DetailsFormState createState() {
    // TODO: implement createState
    return DetailsFormState();
  }

}
class DetailsFormState extends State<Details>{
  Usuario _doc;
  DetailsFormState(){
    _doc = Global.doc;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body:Container(
          constraints: BoxConstraints.expand(),
          color: Color(0xFF333366),
          child: Stack(
            children: <Widget>[
              _getBackground(),
              _getGradient(),
              _getContent()
            ],
          ),
        ),
    );
  }
  Container _getBackground(){
    return Container(
        child: Image.network( _doc.image,
          fit: BoxFit.cover,
          height: 300.0,
        ),
      constraints:  BoxConstraints.expand(height: 295.0),
    );
  }
  Container _getGradient(){
    return  Container(
      margin: EdgeInsets.only(top: 190.0),
      height: 110.0,
        decoration: BoxDecoration(
            gradient:  LinearGradient(
              colors: <Color>[
                Color(0x00736AB7),
                Color(0xFF333366)
              ],
              stops: [0.0, 0.9],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
            ),
        ),
    );
  }
  Container _getContent(){
    final _overviewTitle = "Overview".toUpperCase();
    return Container(
      child: ListView(
        padding: EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          ResumenUsuario(
            horizontal: false,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_overviewTitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Separador(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}