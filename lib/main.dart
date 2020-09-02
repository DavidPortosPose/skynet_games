import 'package:flutter/material.dart';
import 'package:skynet_games/detallesUsuarios/detalleUsuario.dart';
import 'package:skynet_games/detallesUsuarios/resumenUsuario.dart';
import 'package:skynet_games/inicio.dart';
import 'package:skynet_games/lista/listaUsuarios.dart';
import 'package:skynet_games/login/login.dart';
import 'package:skynet_games/menu/menuDespegable.dart';
import 'package:skynet_games/registros/registro.dart';




void main() => runApp(SkynetApp());

class SkynetApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkynetApp',
      theme: ThemeData(
          primarySwatch: Colors.green
      ),
      home: HomePageMain(),
      routes: <String, WidgetBuilder>{ //aplicacion de rutas
        '/SkynetApp' : (BuildContext context) => SkynetApp(),
        '/Login' : (BuildContext context) => Login(),
        '/Registro' : (BuildContext context) => Registro(),
        '/DetalleUsuario' : (BuildContext context) => DetalleUsuario(),


      },

    );
  }
}




/*void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Usuarios',
  theme: ThemeData(
      primarySwatch: Colors.green
  ),
  home: InicioApp(),
));

class SkynetApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Registro()
    );
  }

}

*/

class HomePageMain extends StatefulWidget{
  @override
  _SearchListState createState() => new _SearchListState();

}
class _SearchListState extends State<HomePageMain> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Inicio(),
    );
  }

}

