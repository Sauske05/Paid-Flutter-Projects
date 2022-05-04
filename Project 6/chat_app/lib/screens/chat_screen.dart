import 'package:chat_app/widgets/new_message.dart';
import 'package:chat_app/widgets/messages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FLutter Chat'),
        actions: [
          DropdownButton(
              items: [
                // the type string reference is important.
                DropdownMenuItem<String>(
                  child: Container(
                    child: Row(
                      children: const [Icon(Icons.exit_to_app), Text('Logout')],
                    ),
                  ),
                  value: 'logout',
                )
              ],
              onChanged: (val) {
                if (val == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance
      //       .collection('chats/WqgWvdSa7Bw41melldy5/messages')
      //       .snapshots(),
      //   builder: (ctx, streamsnapshot) {
      //     if (streamsnapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final document = streamsnapshot.data!.docs;
      //     // done with listview not with builder.
      //     return ListView.builder(
      //       itemBuilder: ((context, index) => Container(
      //             // this may throw an error!
      //             child: Text(document[index]['text']),
      //             padding: const EdgeInsets.all(8),
      //           )),
      //       itemCount: document.length,
      //       // check about cloud storage here: https://firebase.flutter.dev/docs/firestore/usage/
      //     );
      //   },
      // ),
      body: Container(
          child: Column(
        // ListView inside Column doesnt work. Wrap it inside Expanded widget.
        children: const [
          Expanded(
            child: Messages(),
          ),
          NewMessage()
        ],
      )),
    );
  }
}
