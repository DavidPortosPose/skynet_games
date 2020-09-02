import 'dart:async';

import 'dart:ui';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:skynet_games/detallesUsuarios/detalleUsuario.dart';
import 'package:skynet_games/global.dart';
import 'package:skynet_games/login/login.dart';
import 'package:skynet_games/main.dart';
import 'package:skynet_games/menu/menuDespegable.dart';
import './imagenUsuario.dart';

class Registro extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registrar',
      theme: ThemeData(
          primarySwatch: Colors.green
      ),
      home: RegistroMain(title: 'Regístrate'),
      routes: <String, WidgetBuilder>{ //aplicacion de rutas
        '/SkynetApp' : (BuildContext context) => SkynetApp(),
        '/Login' : (BuildContext context) => Login(),
        '/Registro' : (BuildContext context) => Registro(),
        '/DetalleUsuario' : (BuildContext context) => DetalleUsuario(),


      },
    );
  }
}
class RegistroMain extends StatelessWidget{
  final String title;
  RegistroMain({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

        appBar: AppBar(title: Text(title),
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


        body: UsuarioForm(),
        drawer: MenuDespegable(),

    );
  }
}
class UsuarioForm extends StatefulWidget{
  @override
  UsuarioFormState createState() {
    // TODO: implement createState
    return UsuarioFormState();
  }
}
class UsuarioFormState extends State<UsuarioForm>{
  final _formKey = GlobalKey<FormState>();
  var alias = TextEditingController();
  var nombre = TextEditingController();
  var apellidos = TextEditingController();
  var direccion = TextEditingController();
  var telefono = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmarPassword = TextEditingController();
  List _tipoUSuario = ["Usuario", "Administrador", "SuperAdministrador", "Desarrollador"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _rolActual, _image;
  bool _isEnabled = true;

  @override
  void initState(){
    _dropDownMenuItems = getDropDownMenuItems();
    _rolActual = _dropDownMenuItems[0].value;
    _image = null;
    _isEnabled = true;
    if(Global.doc != null){
      alias.text = Global.doc.alias;
      nombre.text = Global.doc.nombre;
      apellidos.text = Global.doc.apellidos;
      email.text = Global.doc.email;
      _rolActual = Global.doc.rol;
      _image = Global.doc.image;
      password.text = "*******";
      _isEnabled = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(

      key: _formKey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 10.0),
            child:ImagenesUsuarios(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
            child:TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20.0),
              decoration: new InputDecoration(
                labelText: "Alias",
                fillColor: Colors.white,
                prefixIcon: Icon (Icons.person ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              // ignore: missing_return
              validator: validarAlias,


              controller: alias,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
            child:TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20.0),
              decoration: new InputDecoration(
                labelText: "Nombre",
                fillColor: Colors.white,
                prefixIcon: Icon (Icons.person ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              // ignore: missing_return
              validator: validarNombre,
              controller: nombre,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
            child:TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20.0),
              decoration: new InputDecoration(
                labelText: "Apellidos",
                fillColor: Colors.white,
                prefixIcon: Icon (Icons.person ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              // ignore: missing_return
              validator: validarApellidos,
              controller: apellidos,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
            child:TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20.0),
              decoration: new InputDecoration(
                labelText: "Dirección",
                fillColor: Colors.white,
                prefixIcon: Icon (Icons.add_location ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              // ignore: missing_return
              validator: validarDireccion,
              controller: direccion,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
            child:TextFormField(
              keyboardType: TextInputType.text,
              style: TextStyle(fontSize: 20.0),
              decoration: new InputDecoration(
                labelText: "Teléfono",
                fillColor: Colors.white,
                prefixIcon: Icon (Icons.phone),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              validator: validarTelefono,
              controller: telefono,

            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
            child:TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: 20.0),
              decoration: new InputDecoration(
                labelText: "Correo electrónico",
                fillColor: Colors.white,
                prefixIcon: Icon (Icons.email ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              validator: validarEmail,
              controller: email,
              enabled: _isEnabled,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
            child:TextFormField(
              obscureText: true ,
              style: TextStyle(fontSize: 20.0),
              decoration: new InputDecoration(
                labelText: "Contraseña",
                fillColor: Colors.white,
                prefixIcon: Icon (Icons.enhanced_encryption ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
            //  validator: validarPassword,
              controller: password,
              enabled: _isEnabled,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
            child:TextFormField(
              obscureText: true,
              style: TextStyle(fontSize: 20.0),
              decoration: new InputDecoration(
                labelText: "Confirmar contraseña",
                fillColor: Colors.white,
                prefixIcon: Icon (Icons.enhanced_encryption ),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(
                  ),
                ),
              ),
              validator: validarPassword,
              controller: confirmarPassword,
              enabled: _isEnabled,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
            child:DropdownButton(
              value: _rolActual,
              items: _dropDownMenuItems,
              onChanged: changedDropDownItem,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10.0),
            child: MaterialButton(
              minWidth: 200.0,
              height: 60.0,
              onPressed: (){
                if (_formKey.currentState.validate()){
                  registrar(context);
               }else{
                 actualizar();
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data  $_rolActual')));
                }
              },
              color: Colors.lightGreen,
              child: setUpButtonChild()
            ),
          ),
        ],
      ),
    );
  }
  List<DropdownMenuItem<String>> getDropDownMenuItems(){
    List<DropdownMenuItem<String>> items = new List();
    for (String item in _tipoUSuario){
      items.add(new DropdownMenuItem(
        value: item,
        child: new Text(
            item,
            style: TextStyle(
              fontSize: 35,
            )
        ),
      ));
    }
    return items;
  }
  void changedDropDownItem(String seleccionarRol){
    setState(() {
      _rolActual = seleccionarRol;
    });
  }

  String validarAlias(String value){
    if (value.isEmpty){
    return 'Por favor ingrese el alias';
    }else{
      return value;
    }
    }


String validarNombre(String value){
  if (value.isEmpty){
    return 'Por favor ingrese el nombre';
  }else{
    return value;
  }
}

  String validarApellidos(String value){
    if (value.isEmpty){
      return 'Por favor ingrese los apellidos';
    }else{
      return value;
    }
  }

  String validarDireccion(String value){
    if (value.isEmpty){
      return 'Por favor ingrese la direccion';
    }else{
      return value;
    }
  }


String validarTelefono(String value) {
    Pattern pattern = r'(^[0-9]*$)';
    if (value.isEmpty){
      return 'Por favor ingrese el teléfono';
    }else{
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)){
  return 'No es un teléfono correcto';
  }else{
  return null;
  }
  }
}

  String validarEmail(String value){
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (value.isEmpty){
      return 'Por favor ingrese el email';
    }else{
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value)){
        return 'Introduzca un Email correcto';
      }else{
        return null;
      }
    }
  }

  String validarPassword(String value) {
    if (value.isEmpty) {
      return 'Por favor introduzca la contraseña';
    } else {
      if (value != password.text) {
        return "Las contraseñas no coinciden";
      }
      return null;
    }
  }


  int _state = 0;
  Widget setUpButtonChild() {
    if(_state == 0){
      return new Text(
        'Registrarse',
        style: const TextStyle(
          color:  Colors.white,
          fontSize: 20,
        ),

      );
    }else if(_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }else{
      return new Text(
        'Registrarse',
        style: const TextStyle(
          color:  Colors.white,
          fontSize: 20,
        ),

      );

    }

  }

  void animacionBoton(){
    setState(() {
      _state = 1;
    });
    Timer(Duration(milliseconds: 5000),() {
      setState(() {
        _state = 2;
      });
  });
  }


  registrar(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    final _firebaseStorageRef = FirebaseStorage.instance;
    final _db = Firestore.instance;
    var image = ImagenUsuario.galleryFile;
    if(_image != null) {
      setState(() {
      if(_state == 1) {
        animacionBoton();
      }
    });
    await _auth.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    ).then((AuthResult user) async{

    final StorageUploadTask tarea = _firebaseStorageRef.ref().child('Usuarios').child('${email.text}.png').putFile(registrar(context));
    if(await tarea.onComplete != null) {
      StorageTaskSnapshot storageTaskSnapshot = await tarea.onComplete;
      String imgUrl = await storageTaskSnapshot.ref.getDownloadURL();
      DocumentReference ref = _db.collection('Usuarios').document(email.text);
      ref.setData({
        'Alias': '${alias.text}',
        'Nombre': '${nombre.text}',
        'Apellidos': '${apellidos.text}',
        'Dirección': '${direccion.text}',
        'Teléfono': '${telefono.text}',
        'Correo Electrónico': '${email.text}',
        'Rol': '$_rolActual',
        'Imagen': '$imgUrl'
      }).then((onValue){
        Navigator.of(context).push(new PageRouteBuilder(
            pageBuilder: (_,__,___) => new HomePageMain()
        ));
      });
    }

    }).catchError((e) =>{
      Scaffold.of(context)
      .showSnackBar(SnackBar(content: Text(e.message))),

    });
  }
}
actualizar() async{
  final _firebaseStorageRef = FirebaseStorage.instance;
  final _db = Firestore.instance;
  //var image = ImagenUsuario.galleryFile;
  DocumentReference ref = _db.collection('Usuarios').document(email.text);
  setState(() {
    if (_state == 0) {
      animacionBoton();
    }
  });
  if(_image != null){
    final StorageUploadTask task = _firebaseStorageRef.ref().child("Usuarios")
        .child("${email.text}").putFile(registrar(context));
    if(await task.onComplete != null){
      StorageTaskSnapshot storageTaskSnapshot = await task.onComplete;
      String imgUrl = await storageTaskSnapshot.ref.getDownloadURL();
      ref.setData({
        'Alias': '${alias.text}',
        'Nombre': '${nombre.text}',
        'Apellidos': '${apellidos.text}',
        'Dirección': '${direccion.text}',
        'Teléfono': '${telefono.text}',
        'Rol': '$_rolActual',
        'Image': '$imgUrl'
      }).then((onValue){
        Navigator.of(context).pushReplacementNamed('/SkynetApp');
      });
    }

  }else{
    if(_image != null){
      ref.setData({
        'Alias': '${alias.text}',
        'Nombre': '${nombre.text}',
        'Apellido': '${apellidos.text}',
        'Dirección': '${direccion.text}',
        'Teléfono': '${telefono.text}',
        'Rol': '$_rolActual',
        'Image': '$_image'
      }).then((onValue){
        Navigator.of(context).pushReplacementNamed('/SkynetApp');
      });
    }else{
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Seleccione una imagen')));
    }
  }
}


}
