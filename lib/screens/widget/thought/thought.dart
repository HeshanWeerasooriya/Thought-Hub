import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thought_hub/screens/widget/thought/thought_bubble.dart';

class Thoughts extends StatelessWidget {
  Thoughts({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection('thoughts')
      .orderBy(
        'createAt',
        descending: true,
      )
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ThoughtBubble(
              data['username'],
              data['thought'],
              data['userImage'],
            );
          }).toList(),
        );
      },
    );
  }
}
