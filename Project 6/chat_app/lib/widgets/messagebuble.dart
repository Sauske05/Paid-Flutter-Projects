import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final String imageurl;
  final bool isMe;
  MessageBubble(this.message, this.username, this.imageurl, this.isMe);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Container(
      decoration: BoxDecoration(
          color: isMe
              ? Colors.orangeAccent
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)),
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        children: [
          Text(username),
          Text(message),
        ],
      ),
    );
  }
}
