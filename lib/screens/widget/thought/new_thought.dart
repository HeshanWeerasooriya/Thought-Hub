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
  bool isLoading = false;

  void _sendThought() async {
    if (_enteredThought.trim().isNotEmpty) {
      setState(() {
        isLoading = true;
      });
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

      setState(() {
        isLoading = false;
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            const SizedBox(
              height: defaultPadding * 2,
            ),
            if (isLoading) Center(child: const CircularProgressIndicator()),
            ElevatedButton(
              onPressed: _sendThought,
              child: const Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
