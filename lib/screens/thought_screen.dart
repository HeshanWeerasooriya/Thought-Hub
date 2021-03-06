import 'package:flutter/material.dart';

import 'widget/thought/new_thought.dart';
import 'widget/thought/thought.dart';

class ThoughtScreen extends StatefulWidget {
  const ThoughtScreen({Key? key}) : super(key: key);

  @override
  _ThoughtScreenState createState() => _ThoughtScreenState();
}

class _ThoughtScreenState extends State<ThoughtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thought Hub'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewThought(),
                ),
              );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Thoughts(),
          ),
          // NewThought(),
        ],
      )),
    );
  }
}
