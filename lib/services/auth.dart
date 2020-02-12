import 'package:brew_crew/models/model.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final FirebaseAuth _auth=FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return (user!=null)?User(uid: user.uid):null;
  }
  //detecting sign in/sign out state change
  Stream<User> get user=>_auth.onAuthStateChanged.map(_userFromFirebaseUser);

  Future signInAnon()async{
    try{
      AuthResult result=await _auth.signInAnonymously();
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email,String pass)async{
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signUpwithEmailPassword(String email,String pass)async{
    try{
      final result=await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user=result.user;
      await DatabaseService(uid:user.uid).updateUserData('0', 'New Member' , 100);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut()async{
    try{
      return _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}