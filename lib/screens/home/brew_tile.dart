import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;
  BrewTile({this.brew});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading:CircleAvatar(
            backgroundColor:Colors.brown[brew.strength],
            backgroundImage: AssetImage('assets/coffie2.jpg'),
          ),
          title: Text(brew.name),
          subtitle: Text('takes ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}