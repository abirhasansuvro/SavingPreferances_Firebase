import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget{
  @override
  _AuthenticateState createState() {
    return _AuthenticateState();
  }
}

class _AuthenticateState extends State<Authenticate>{
  bool showSignIn=true;
  void toogleView(){
    setState(() {
      showSignIn=!showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:showSignIn?SignIn(toogle:toogleView):SignUp(toogle:toogleView),
    );
  }
  
}