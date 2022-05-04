import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var entermessage = " ";
  final _controller = TextEditingController();

  void sendmessgae() async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    final userData =
        await FirebaseFirestore.instance.collection('users').doc(userID).get();
    FocusScope.of(context).unfocus;
    FirebaseFirestore.instance.collection('chat').add({
      'text': entermessage,
      'timestamp': Timestamp.now(),
      'userID': userID,
      'username': userData['username'],
      'user_image': userData['imageurl']
    }); // TimeStamp is made available by cloud firestore.
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(label: Text('Send a messgae')),
              onChanged: (val) {
                setState(() {
                  entermessage = val;
                });
              },
            ),
          ),
          IconButton(
              onPressed: entermessage.isEmpty ? null : sendmessgae,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
