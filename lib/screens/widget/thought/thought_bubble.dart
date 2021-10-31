import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thought_hub/constants.dart';

class ThoughtBubble extends StatelessWidget {
  const ThoughtBubble(
    this.userName,
    this.thought,
    this.userImage,
  );

  final String userName;
  final String thought;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 4),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(userImage),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(userName, style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(thought),
            ),
          ],
        ),
      ),
    );
  }
}
