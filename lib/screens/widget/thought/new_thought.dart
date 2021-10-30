import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewThought extends StatefulWidget {
  const NewThought({Key? key}) : super(key: key);

  @override
  _NewThoughtState createState() => _NewThoughtState();
}

class _NewThoughtState extends State<NewThought> {
  var _enteredThought = '';
  final _controller = TextEditingController();

  void _sendThought() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    FirebaseFirestore.instance.collection('thoughts').add({
      'thought': _enteredThought,
      'createAt': Timestamp.now(),
      'userId': user!.uid,
      'username': userData['username'],
      'userImage': userData['image_url']
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Add a thought...'),
              onChanged: (value) {
                setState(() {
                  _enteredThought = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _enteredThought.trim().isEmpty ? null : _sendThought,
          )
        ],
      ),
    );
  }
}
