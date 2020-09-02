import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skynet_games/main.dart';
import 'package:skynet_games/paginas/ajustes.dart';
import 'package:skynet_games/paginas/amigos.dart';
import 'package:skynet_games/paginas/biblioteca.dart';
import 'package:skynet_games/paginas/catalogo.dart';
import 'package:skynet_games/paginas/comunicacion.dart';
import 'package:skynet_games/paginas/novedades.dart';
import 'package:skynet_games/paginas/perfil.dart';
import 'package:skynet_games/paginas/videos.dart';

import '../global.dart';



class MenuDespegable extends StatefulWidget {
  @override
  Menu createState(){
    return Menu();
  }
}
class Menu extends State<MenuDespegable>{
  final _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
             '${Global.user.alias}${Global.user.nombre} ${Global.user.apellidos}',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black87,
                shadows: [
                  BoxShadow(
                    //SOMBRA
                    color: Color(0xffA4A4A4),
                    offset: Offset(1.0, 5.0),
                    blurRadius: 3.0,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image:  NetworkImage(Global.user.image),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  //SOMBRA
                  color: Color(0xffA4A4A4),
                  offset: Offset(1.0, 5.0),
                  blurRadius: 3.0,
                ),
              ],
            ),
          ),
          ListTile(
              leading: new Icon(
                  Icons.home,
                  color: Colors.white
              ),
              title: Text('Home'),
              onTap:() => Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_,__,___) => new SkynetApp(),
              ))
          ),
          ListTile(
              leading: new Icon(
                Icons.person,
                  color: Colors.white
              ),
              title: Text('Perfil'),
              onTap:() => Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_,__,___) => new Perfil(),
              ))
          ),
          ListTile(
              leading: new Icon(
                Icons.new_releases,
                  color: Colors.white
              ),
              title: Text('Novedades'),
              onTap:() => Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_,__,___) => new Novedades(),
              ))
          ),
          ListTile(
              leading: new Icon(
                Icons.archive,
                  color: Colors.white
              ),
              title: Text('Catálogo'),
              onTap:() => Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_,__,___) => new Catalogo(),
              ))
          ),
          ListTile(
              leading: new Icon(
                Icons.library_books,
                  color: Colors.white
              ),
              title: Text('Biblioteca'),
              onTap:() => Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_,__,___) => new Biblioteca(),
              ))
          ),
          ListTile(
              leading: new Icon(
                Icons.insert_emoticon,
                  color: Colors.white
              ),
              title: Text('Amigos'),
              onTap:() => Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_,__,___) => new Amigos(),
              ))
          ),
          ListTile(
              leading: new Icon(
                Icons.video_library,
                  color: Colors.white
              ),
              title: Text('Videos'),
              onTap:() => Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_,__,___) => new Videos(),
              ))
          ),
          ListTile(
              leading: new Icon(
                Icons.headset,
                  color: Colors.white
              ),
              title: Text('Comunicación'),
              onTap:() => Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_,__,___) => new Comunicacion(),
              ))
          ),
          ListTile(
              leading: new Icon(
                Icons.settings,
                  color: Colors.white
              ),
              title: Text('Ajustes'),
              onTap:() => Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_,__,___) => new Ajustes(),
              ))
          ),
          ListTile(
              leading: new Icon(
                  Icons.exit_to_app,
                  color: Colors.white
              ),
              title: Text('Salir'),
              onTap:() =>
                {
                  Global.doc = null,
                  Global.user = null,
                  signOut(),
                  Navigator.of(context).pushReplacementNamed('/Login'),
               }

      ),

              ],
    )
    );
  }
  Future<void> signOut() async{
    return Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut()
    ]);
  }

}

