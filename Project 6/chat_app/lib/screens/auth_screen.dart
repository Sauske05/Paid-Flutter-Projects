import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/auth_form.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  void _submitform(String username, String password, String emailID, bool login,
      File? imagefile) async {
    UserCredential userCredential;
    try {
      if (login) {
        userCredential = await auth.signInWithEmailAndPassword(
            email: emailID, password: password);
      } else {
        print(emailID);
        userCredential = await auth.createUserWithEmailAndPassword(
            email: emailID, password: password);

        final ref = FirebaseStorage.instance.ref().child('user_image').child(
            userCredential.user!.uid +
                '.jpg'); // creates user_imgaes folder in storage.
        // possible error. null check "!" check.

        await ref.putFile(imagefile!);
        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'username': username,
          'email': emailID,
          'imageurl': url
        }); // userCredential has a user object that has UID.
      }
    } on PlatformException catch (error) {
      var message = 'An Error Occured. Please check your credentials';

      if (error.message != null) {
        message = error.message.toString();
      }
      // context has no ancestor scafold. Build COntext needs to be passed as a paramter. need the buildcontext.
      // Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitform));
  }
}
