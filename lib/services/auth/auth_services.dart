import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthServices {
  //getting instances
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  //login user with credentials
  Future<UserCredential> logInUser(String emailaddress, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: emailaddress, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //create new user
  Future<UserCredential> createUser(
      String emailaddress, String password, File? pickedImage, String username) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailaddress, password: password);

      //uploading image to Firebase Storage
      final storgaeRef = _firebaseStorage
          .ref()
          .child('user_images')
          .child('${userCredential.user!.uid}.jpg');

      await storgaeRef.putFile(pickedImage!);
      final imageUrl = await storgaeRef.getDownloadURL();

      //storing user data in Firebase firestore
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email' : userCredential.user!.email,
        'uid' :  userCredential.user!.uid,
        'imageUrl' : imageUrl,
        'username' : username
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // logout current user
  Future<void> logOutUser() async {
    await _firebaseAuth.signOut();
  }
}
