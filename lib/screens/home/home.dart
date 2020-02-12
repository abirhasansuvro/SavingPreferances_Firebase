import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';

class Home extends StatelessWidget{
  final _auth=Auth();
  @override
  Widget build(BuildContext context) {
    void handlePopUp(){
      showModalBottomSheet(
        context: context, 
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal:60.0,
              vertical:20.0,
            ),
            child: SettingsForm(),
          );
        }
      );
    }
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar:AppBar(
          title:Text('Home'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: ()async{
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),
            FlatButton.icon(
              onPressed: ()=>handlePopUp(), 
              icon: Icon(Icons.settings), 
              label: Text('Settings')
            ),
          ],
        ),
        body:Container(
          decoration:BoxDecoration(
            image:DecorationImage(
              image:AssetImage('assets/coffie1.jpeg'),
              fit:BoxFit.cover,
            ),
          ),
          child:BrewList(),
        ),
      ),
    );
  }
}