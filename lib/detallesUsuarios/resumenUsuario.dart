
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:skynet_games/detallesUsuarios/separador.dart';
import 'package:skynet_games/lista/usuario.dart';

import '../global.dart';
import '../main.dart';

class ResumenUsuario extends StatelessWidget {
  final bool horizontal;
  Usuario _doc;
   ResumenUsuario({this.horizontal}){
     _doc = Global.doc;
  }

  @override
  Widget build(BuildContext context) {
    final imageThumbnail = Container(
      margin: EdgeInsets.symmetric(
          vertical: 16.0
      ),
        alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: Container(
        height: 90.0,
        width: 90.0,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(50.0),
            image: DecorationImage(
              image: NetworkImage(_doc.image),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              new BoxShadow(
                //SOMBRA
                color: Color(0xffA4A4A4),
                offset: Offset(1.0, 5.0),
                blurRadius: 3.0,
              ),
            ],
          ),
      ),
    );
    Widget _userValue({String value, IconData icono}){
      return Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icono,color: Colors.white,size: 15.0,),
            Container(width: 8.0),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    final userCardContent = Container(
      margin: EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          Container(height: 4.0),
          Text(
            "${_doc.nombre} ${_doc.apellidos}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Container(height: 10.0),
          Text("${_doc.rol}"),
          Separador(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: horizontal ? 1 : 0,
                  child: _userValue(
                      value: _doc.email,
                      icono: Icons.email)
              ),
              Container (
                width: 32.0,
              ),
            ],
          )
        ],
      ),
    );

    final usertCard = Container(
      child: userCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
          ? EdgeInsets.only(left: 46.0)
          : EdgeInsets.only(top: 72.0),
      decoration: BoxDecoration(
        color: Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
    );
    return InkWell(
      onTap:() => Navigator.of(context).push(
        new PageRouteBuilder(
          pageBuilder: (_, __, ___) => new MaterialApp(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          new FadeTransition(opacity: animation, child: child),
        ) ,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: Stack(
          children: <Widget>[
          usertCard,
            imageThumbnail
          ],
        ),
      ),
    );
  }

}