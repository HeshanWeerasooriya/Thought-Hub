import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thought_hub/constants.dart';
import 'package:thought_hub/screens/thought_screen.dart';

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
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => ThoughtScreen(),
    //   ),
    // );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Add a thought...'),
              onChanged: (value) {
                setState(() {
                  _enteredThought = value;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _enteredThought.trim().isEmpty ? null : _sendThought,
            )
          ],
        ),
      ),
    );
  }
}
