import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget{
  Function toogle;
  SignUp({this.toogle});
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp>{
  final formKey=GlobalKey<FormState>();
  final Auth _auth=Auth();

  String _email='';
  String _pass='';
  String error_text='';
  bool loading=false;

  Function toogle;

  @override
  void initState() {
    super.initState();
    this.toogle=widget.toogle;
  }
  
  @override
  Widget build(BuildContext context) {
    return loading?Loading(): Scaffold(
      backgroundColor:Colors.brown[100],
      appBar: AppBar(
        backgroundColor:Colors.brown[400],
        elevation:0.0,
        title:Text('Register to Brew_Crew'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: toogle, 
            icon: Icon(Icons.people), 
            label: Text('Sign In')
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
                  'Sign Up',
                  style: TextStyle(
                    color:Colors.white
                  ),
                ),
                onPressed: ()async{
                  if(formKey.currentState.validate()){
                    print(_email);
                    print(_pass);
                    setState(() {
                      loading=true;
                    });
                    final result=await _auth.signUpwithEmailPassword(_email, _pass);
                    if(result==null){
                      setState(() {
                        error_text='Please provide a valid email';
                        loading=false;
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