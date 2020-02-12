import 'package:brew_crew/models/model.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final userObj=Provider.of<User>(context);
    return userObj==null ?Authenticate():Home();
  }
}