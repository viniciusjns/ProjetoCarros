import 'package:carros/firebase/firebase_service.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritoService {

//  CollectionReference get _carros => Firestore.instance.collection("carros");

  CollectionReference get _users => Firestore.instance.collection("users");
  CollectionReference get _carros => _users.document(firebaseUserUid).collection("carros");
  Stream<QuerySnapshot> get stream => _carros.snapshots();

  Future<bool> favoritar(Carro carro) async {

    DocumentReference docRef = _carros.document("${carro.id}");
    DocumentSnapshot doc = await docRef.get();

    final exists = doc.exists;

    if (exists) {
      docRef.delete();
      return false;
    } else {
      docRef.setData(carro.toMap());
      return true;
    }
  }

  Future<bool> isFavorito(Carro carro) async {
    DocumentReference docRef = _carros.document("${carro.id}");
    DocumentSnapshot doc = await docRef.get();

    return doc.exists;
  }

  Future<bool> deleteCarros() async {
    final query = await _carros.getDocuments();
    for (DocumentSnapshot doc in query.documents) {
      await doc.reference.delete();
    }

    _users.document(firebaseUserUid).delete();

    return true;
  }
}