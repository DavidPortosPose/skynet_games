import 'dart:async';
//import 'com.facebook.FacebookSdk';
//import 'com.facebook.appevents.AppEventsLogger';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skynet_games/global.dart';
import 'package:skynet_games/lista/usuario.dart';
import 'package:skynet_games/login/loginResumen.dart';
import 'package:skynet_games/main.dart';
import 'package:skynet_games/paginas/perfil.dart';
import 'package:skynet_games/registros/auth.dart';



class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: LoginUsuario(title: 'Login'),
      routes: <String, WidgetBuilder>{ //aplicacion de rutas
        '/Perfil' : (BuildContext context) => Perfil()
      },
    );
  }
  
}

class LoginUsuario extends StatelessWidget{

  final String title;
  LoginUsuario({this.title});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xFF333366),
    ));
    return Scaffold(
        backgroundColor: const Color(0xff1c1b1b),
        body: LoginForm(),
    ) ;
  }

}

class LoginForm extends StatefulWidget{
  @override
  LoginFormState createState() {
    return LoginFormState();
  }

}

class LoginFormState extends State<LoginForm>{
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            _getContent()
          ],
        )

      ),
    );
  }
Container _getContent() {
    return Container(
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            LoginResumen(
              horizontal: false
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
                validator: validarPassword,
                controller: password,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10.0),
              child: RaisedButton(
                child: Text('Log in'),
                color: Colors.green,
                onPressed: () async {
                  dynamic result =  await _auth.signIn();
                  if(result == null) {
                    print('Error Log in');
                  } else{
                    print('Log in');
                    print(result);

                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 10.0),

              child: _signInButton(),
            )
          ],

        ),
      ),

    );
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
    if(value.isEmpty) {
      return 'Por favor introduzca la contraseña';
    }else{
      if(6 > value.length) {
        return 'La contraseña debe de tener como mínimo 6 caracteres';
      }
    }
  }
 /* int _state = 0;
  Widget setUpButtonChild() {
    if(_state == 0){
      return new Text(
        'Log in',
        style: const TextStyle(
          color:  Colors.green,
          fontSize: 20,
        ),

      );
    }else if(_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      );
    }else{
      return new Text(
        'Log in',
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
    Timer(Duration(seconds: 60),() {
      setState(() {
        _state = 2;
      });
    });
  }
  */


  void ingresarConCredenciales(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final _db = Firestore.instance;
    _auth.signInAnonymously();
    _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text
    ).then((AuthResult user) {
      Future<DocumentSnapshot> snapshot = _db.collection('Usuarios').document(email.text).get();
      snapshot.then((DocumentSnapshot user){
        Global.user = Usuario(
            user.data['Nombre'],
            user.data['Apellidos'],
            user.data['Alias'],
            user.data['Rol'],
            user.data['Image'],
            user.documentID

        );

      });
      Navigator.of(context).pushReplacementNamed('/Perfil');
    }).catchError((e)=>{
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)))
    });
  }

  Widget _signInButton() { //boton Google
    final _db = Firestore.instance;
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: (){
        googleSignIn();

  },



    /*    googleSignIn().then((){
          Future<DocumentSnapshot> snapshot = _db.collection('Usuarios').document(user.email).get();
          snapshot.then((DocumentSnapshot user){
            Global.user = Usuario(
                user.data['Apellidos'],
                user.data['Apellidos'],
                user.data['Alias'],
                user.data['Rol'],
                user.data['Image'],
                user.documentID

            );

          });
          Navigator.of(context).pushReplacementNamed('/InicioApp');

        });
      },
        */
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              child: Text(
                'Ingresar con Google',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey
                    )
              ),
            ),
          ],
        ),
      )
    );
  }

  Future<FirebaseUser> googleSignIn() async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final FirebaseUser user = (googleAuth) as FirebaseUser;
    assert(user.email != null);
    assert(user.displayName != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    return user;
  }

  /*Future<String> googleSignIn() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final  credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

*/
/*Future<FirebaseUser> googleSignIn() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken : googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    return user;
}
*/
}