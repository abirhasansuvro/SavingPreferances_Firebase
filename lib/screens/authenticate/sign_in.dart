import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget{
  Function toogle;
  SignIn({this.toogle});
  @override
  _SignInState createState() {
    return _SignInState();
  }
}

class _SignInState extends State<SignIn>{
  final Auth _auth=Auth();
  String _email='';
  String _pass='';
  String error_text='';
  bool loadig=false;

  final formKey=GlobalKey<FormState>();
  Function toogle;

  @override
  void initState() {
    super.initState();
    this.toogle=widget.toogle;
  }
  @override
  Widget build(BuildContext context) {
    return loadig?Loading(): Scaffold(
      backgroundColor:Colors.brown[100],
      appBar: AppBar(
        backgroundColor:Colors.brown[400],
        elevation:0.0,
        title:Text('Sign In to Brew_Crew'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: toogle, 
            icon: Icon(Icons.person_add), 
            label: Text('Register')
          ),
        ],
      ),
      body: Container(
        padding:EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 50.0,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children:<Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                onChanged: (value){
                  setState(() {
                    _email=value;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'yourname@xyz.com',
                ),
                validator: (String value){
                  if(value.contains('@'))return null;
                  return 'Email is invalid';
                },
              ),
              SizedBox(height:20.0),
              TextFormField(
                obscureText: true,
                onChanged: (value){
                  _pass=value;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter a valid password',
                ),
                validator: (String value){
                  if(value.length<8)return 'Password must be of length 8 atleast';
                  return null;
                },
              ),
              SizedBox(height:20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color:Colors.white
                  ),
                ),
                onPressed: ()async{
                  if(formKey.currentState.validate()){
                    print(_email);
                    print(_pass);
                    setState(()=>loadig=true);
                    final result=await _auth.signInWithEmailAndPassword(_email, _pass);
                    if(result==null){
                      setState(() {
                        error_text='Either email or password is incorrect';
                        loadig=false;
                      });
                    }
                  }
                }
              ),
              SizedBox(height:12.0),
              Text(
                error_text,
                style: TextStyle(
                  color:Colors.red,
                  fontSize:14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}