import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
export 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  final CollectionReference brewCollection=Firestore.instance.collection('brews');

  DatabaseService({this.uid});

  Future updateUserData(String sugars,String name,int strength)async{
    return await brewCollection.document(uid).setData(
      {
        'sugars':sugars,
        'name':name,
        'strength':strength,
      }
    );
  }

  List<Brew> _convertQStoBrews(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(name: doc.data['name']??'',sugars: doc.data['sugars']??'0',strength: doc.data['strength']??0);
    }).toList();
  }

  UserData _convertDStoUserData(DocumentSnapshot ds){
    return UserData(uid: uid,name: ds.data['name'],sugars: ds.data['sugars'],strength: ds.data['strength']);
  }

  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_convertQStoBrews);
  }

  Stream<UserData> get userdata{
    return brewCollection.document(uid).snapshots().map(_convertDStoUserData);
  }
}