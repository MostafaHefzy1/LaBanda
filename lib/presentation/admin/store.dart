import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection('orders').snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore
        .collection('orders')
        .doc(documentId)
        .collection('orderDetails')
        .snapshots();
  }


  Stream<QuerySnapshot> deleteorder(documentId) {
    return _firestore
        .collection('orders')
        .doc(documentId)
        .collection('orderDetails')
        .snapshots();
  }







}