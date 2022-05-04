import 'package:chat_app/widgets/messagebuble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // QuerySnapShot is important.
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return ListView.builder(
            reverse: true,
            itemBuilder: (ctx, i) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              print(snapshot.data!.docs[i]['userID']);
              print('arun');
              // snapshot is from Streambuilder
              return MessageBubble(
                  snapshot.data!.docs[i]['text'],
                  snapshot.data!.docs[i]['username'],
                  snapshot.data!.docs[i]['user_image'],
                  snapshot.data!.docs[i]['userID'] ==
                      FirebaseAuth.instance.currentUser?.uid); // mistake
            },
            itemCount: snapshot.data!.docs.length,
          );
        }
      },
    );
  }
}
