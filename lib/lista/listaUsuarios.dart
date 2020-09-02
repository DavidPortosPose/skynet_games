
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skynet_games/detallesUsuarios/detalleUsuario.dart';
import 'package:skynet_games/lista/usuario.dart';
import 'package:skynet_games/menu/menuDespegable.dart';


import '../global.dart';

class ListaUsuarios extends StatefulWidget{
  @override
  ListaUsuariosState createState() {
    // TODO: implement createState
    return ListaUsuariosState();
  }

}
class ListaUsuariosState  extends State<ListaUsuarios>{
  final _db = Firestore.instance;
  String nombre;
  List<Usuario> listaUsuarios;
  final GlobalKey<RefreshIndicatorState> _refreshKey =
  new GlobalKey<RefreshIndicatorState>();
  @override
  void initState(){
    super.initState();
    _isSearching = false;
    listaUsuarios = List<Usuario>();
    _usuarios = SizedBox();
    leerDatos();
  }
  Widget appBarTitle = Text(
    "Buscar usuarios",
    style: TextStyle(color: Colors.white),
  );
  Icon icon = Icon(
    Icons.search,
    color: Colors.white,
  );
  bool _isSearching;
  Widget _usuarios;
  final TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color(0xff1c1b1b),
      appBar: AppBar(
        title: appBarTitle,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
              icon: icon,
              onPressed:(){
                setState(() {
                  if(this.icon.icon == Icons.search){
                    this.icon = Icon(
                      Icons.close,
                      color: Colors.white,
                    );
                    this.appBarTitle = TextField(
                      controller: _controller,
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          hintText: "Buscar...",
                          hintStyle: TextStyle(color: Colors.white)
                      ),
                      onChanged: operacionBusqueda,
                    );
                    _handleSearchStart();
                  }else{
                    operacionBusqueda(null);
                    _handleSearchEnd();
                  }
                });
              }
          ),
        ],
      ),
      drawer: MenuDespegable(),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: leerDatos,
        child: ListView(
          children: <Widget>[
            _usuarios
          ],
        ),
      )

    );
  }
  Container buildItem(Usuario doc){
    return new Container(
      height: 120.0,
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),
        child: new Stack(
          children: <Widget>[
            card(doc),
            thumbnail(doc)
          ],
        )
    );
  }
  Future<void> leerDatos() async {
    Stream<QuerySnapshot> qs = _db.collection('Usuarios').snapshots();
    qs.listen((QuerySnapshot onData) =>{
    listaUsuarios.clear(),
      onData.documents.map((doc) =>{
        listaUsuarios.add(Usuario(
          doc.data['Alias'],
          doc.data['Nombre'],
          doc.data['Apellidos'],
          doc.data['Rol'],
          doc.data['Image'],
          doc.documentID,

        )),
    }).toList(),
      usuarioLista(null)
    });
  }
  GestureDetector card(Usuario doc){
    return new GestureDetector(
      onTap: () =>{
        Global.doc = doc,
        Navigator.of(context).push(new PageRouteBuilder(
          pageBuilder: (_, __, ___) => new DetalleUsuario(),
        ))
      },
      child: new Container(
        height: 124.0,
        margin: new EdgeInsets.only(left: 46.0),
        decoration: new BoxDecoration(
          color: new Color(0xFF333366),
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.green,
              blurRadius: 5.0,
              offset: new Offset(0.0, 5.0),
            ),
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                      '${doc.nombre}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${doc.apellidos}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),

                ],
              ),
              Text(
                '${doc.rol}',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Container thumbnail(Usuario doc){
    return Container(
      alignment: FractionalOffset.centerLeft,
      child: new Container(
        height: 90.0,
        width: 90.0,
        decoration: new BoxDecoration(
          color: Colors.green,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(50.0),
          image: DecorationImage(
            image: NetworkImage(doc.image),
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
  }

 void _handleSearchStart(){
    setState(() {
      _isSearching = true;
    });
 }

 void _handleSearchEnd() {
    setState(() {
      this.icon = Icon(
        Icons.search,
        color: Colors.white
      );
      this.appBarTitle = Text(
        "Buscar usuario",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _controller.clear();

    });
 }

 void operacionBusqueda(String buscarTexto){
  if(_isSearching){
    usuarioLista(buscarTexto);
  }
 }
 void usuarioLista(String buscarTexto) {
    setState(() {
      if(listaUsuarios != null) {
        if(buscarTexto == null || buscarTexto == ""){
          _usuarios = Column(
              children: listaUsuarios.map((user) => buildItem(user)).toList()
          );
        }else{
          var usuario = listaUsuarios.where((item) => item.alias.startsWith(buscarTexto)).toList();
          if(0 < usuario.length){
            _usuarios = Column(
              children: usuario.map((user) => buildItem(user)).toList()
            );
          }else{
            _usuarios = SizedBox();
          }
        }
      }else{
        _usuarios = SizedBox();
      }
    });

 }
}