import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  final CollectionReference productCollection =
      FirebaseFirestore.instance.collection('product');
  final CollectionReference chartCollection =
      FirebaseFirestore.instance.collection('chart');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
}
