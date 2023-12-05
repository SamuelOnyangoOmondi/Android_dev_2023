import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/my_textfield.dart';
import 'package:flutter_app/components/wall_post.dart';
class HomePage extends StatefulWidget{
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // current user
  final currentuser = FirebaseAuth.instance.currentUser!;

  // text controller
  final textcontroller =TextEditingController();

  // sign out user method
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void postmessage() {
    // Only post if there is something in the text field
    if (textcontroller.text.isNotEmpty) {
      // Store in Firestore
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentuser.email,
        'Message': textcontroller.text,
        'TimeStamp': Timestamp.now(),
      });

      // Clear the text field after input
      setState(() {
        textcontroller.clear();
      });
    }
  }

  // clear text field
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("The wall"),
        backgroundColor: Colors.grey[900],
        actions: [
        //   sign out button
          IconButton(
            onPressed: signOut,
            icon: Icon(Icons.logout),
          )
        ]
      ),
      body: Center(
        child: Column(
          children: [
          //   the wall
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.
              collection("User Posts")
                  .orderBy('TimeStamp',
                  descending: false,)
              .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount:snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
    //                 get the message
                        final post = snapshot.data!.docs[index];
                        return WallPost(message:post['Message'],
                            user: post['UserEmail'],
                        );
                        },
                  );
    } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error:${snapshot.error}'),
                  );
                } else {
                //   return circular progress indicator if there is no data
                  return const Center(
                      child: CircularProgressIndicator(),
                  );
                }
    },
            ),
          ),
          //   post the message
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
              //text field
              Expanded (
                child: MyTextField(
                controller: textcontroller,
                hintText: 'Write something on the wall...',
                obscureText: false,
    ),
    ),

    //   post the message

    IconButton(
    onPressed: postmessage,
      icon: const Icon(Icons.arrow_circle_up))
    ],
    ),
          ),
          //  Logged in as
          Text("Logged in as:" + currentuser.email!,
          style: TextStyle(color: Colors.grey),
          ),
            const SizedBox(
              height: 50,

            )
        ],
      ),
      ),
    );
  }
}