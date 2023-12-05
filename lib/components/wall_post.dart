import 'package:flutter/material.dart';
class WallPost extends StatelessWidget {
  final String message;
  final String user;

  const WallPost({
    Key? key,
    required this.message,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(top: 25, right: 25),
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          // profile picture
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[400],
            ),
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20,),
          // message and user email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user,
                  style: TextStyle(color: Colors.grey[500]),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  // Wrap the Text widget in a Flexible or Expanded widget
                  // to allow text to wrap to the next line if it's too long
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
