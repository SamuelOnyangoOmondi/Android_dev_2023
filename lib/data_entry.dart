import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'data_display_page.dart';

class DataEntryPage extends StatefulWidget {
  final String collectionName;

  DataEntryPage({required this.collectionName});

  @override
  _DataEntryPageState createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  final TextEditingController datacontroller = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<void> addData() async {
    String newData = datacontroller.text;

    // Add the data to Firestore as a new document
    await firestore.collection(widget.collectionName).add({
      'age': newData, // Replace 'age' with the field name you want to use
    });

    // Clear the text field after adding the data
    datacontroller.clear();

    // Transition to another page or display a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Success! Data has been added.'),
      ),
    );
  }

  Future<void>deleteData() async{
    if (widget.collectionName.isNotEmpty) {
      try{
        // create a reference to the firestore collection
        CollectionReference collection = firestore.collection(widget.collectionName);

        // Fetch the first 2 documents in the collection
        QuerySnapshot querySnapshot = await collection.limit(2).get();

        // Iterate over each document and delete each one

        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          await doc.reference.delete();
        }

        // clear the textfield

        datacontroller.clear();

        // show success message for deletion

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Success!, First two documents have been deleted. '),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
            ),
        );
      }
    } else{

      //handle cases where the CollectionName is missing or invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Collection Name is invalid or missing'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: datacontroller,
              decoration: InputDecoration(labelText: 'Add Data'),
            ),
            ElevatedButton(
              onPressed: () {
                addData(); // Call the addData method when the button is pressed
              },
              child: Text('Add Data'),
            ),
            ElevatedButton(onPressed: (){
              deleteData();
              },
                child: Text('Delete Data'),
            ),
            ElevatedButton(onPressed: () {
            //   Navigate to the Display data page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DisplayDataPage()),
              );
            }, child: Text('Display Data'))
          ],
        ),
      ),
    );
  }
}
