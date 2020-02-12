import 'package:brew_crew/models/model.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: Auth().user,
      child: MaterialApp(
        title:'New Firebase App',
        home:Wrapper()
      ),
    );
  }
}