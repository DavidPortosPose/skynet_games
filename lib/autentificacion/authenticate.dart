import 'package:flutter/material.dart';
import 'package:skynet_games/login/login.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
  }

  class _AuthenticateState extends State<Authenticate>{
  @override
    Widget build(BuildContext context) {
    return Container(
      child:Login(),
    );
  }

  }

