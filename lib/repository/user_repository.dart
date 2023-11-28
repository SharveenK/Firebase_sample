import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lionsbotremotecontroller/constants/constants.dart';
import 'package:lionsbotremotecontroller/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth firebaseAuth;

  UserRepository(this.firebaseAuth);
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final signedInUser = userCredential.user!;

    await userCollections.doc(signedInUser.uid).set({
      'name': name,
      'email': email,
      'cleaningHours': 0,
      'noOfPoints': 2,
      'noOfBadges': 1,
    });
  }

  Future<UserCredential> logIn(
      {required String email, required String password}) async {
    UserCredential userCredential =
        await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }

  Future<UserModel> getUserDetails({required String uid}) async {
    final DocumentSnapshot userDoc = await userCollections.doc(uid).get();

    if (userDoc.exists) {
      final UserModel currentUser = UserModel.fromDoc(userDoc);
      return currentUser;
    }

    throw 'User does not exist';
  }
}
