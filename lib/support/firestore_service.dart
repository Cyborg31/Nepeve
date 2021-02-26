import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nepeve/support/user.dart';
import 'package:nepeve/util/checkoutuser.dart';

class FirestoreService {
  final String uid;

  FirestoreService({this.uid});

  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future createUser(AppUser user) async {
    try {
      await _usersCollectionReference.doc(user.uid).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }
}

class CheckoutService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection('checkout');

  Future createCheckoutUser(CheckoutUser checkoutuser) async {
    try {
      await _usersCollectionReference
          .doc(
            checkoutuser.name,
          )
          .set(checkoutuser.toJson());
    } catch (e) {
      return e.message;
    }
  }
}
