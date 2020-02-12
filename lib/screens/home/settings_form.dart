import 'package:brew_crew/models/model.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey=GlobalKey<FormState>();
  final List<String> S=['0','1','2','3','4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    return StreamBuilder(
      stream: DatabaseService(uid: user.uid).userdata,
      builder: (context,snapshot){
        if(snapshot.hasData){
          UserData udata=snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  udata.name,
                  style: TextStyle(
                    fontSize:18.0,
                  ),
                ),
                SizedBox(height:20.0),
                TextFormField(
                  decoration: textInputDecoration,
                  validator: (val)=>val.isEmpty?'Please provide a name':null,
                  onChanged: (val)=>setState(()=>_currentName=val),
                ),
                SizedBox(height: 20.0,),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars??udata.sugars,
                  items: S.map((s){
                    return DropdownMenuItem(
                      child: Text('$s sugar(s)'),
                      value: s,
                    );
                  }).toList(), 
                  onChanged: (val)=>setState(()=>_currentSugars=val),
                ),
                Slider(
                  activeColor: Colors.brown[_currentStrength??100],
                  inactiveColor: Colors.brown[_currentStrength??100],
                  min: 100,
                  max:900,
                  divisions: 8,
                  onChanged: (val)=>setState(()=>_currentStrength=val.round()),
                  value: (_currentStrength??100).toDouble(),
                ),
                RaisedButton(
                  child: Text(
                    'Update',
                    style: TextStyle(color:Colors.pink),
                  ),

                  onPressed: ()async{
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid:udata.uid).updateUserData(
                        _currentSugars??udata.sugars,
                        _currentName??udata.name,
                        _currentStrength??udata.strength
                      );
                      Navigator.pop(context);
                    }
                  }
                ),
              ],
            ),
          );
        }else{
          return Loading();
        }
      },
    );
  }
}