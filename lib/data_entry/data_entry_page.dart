import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class DataEntryPage extends StatefulWidget{
  final String collectionName;
  final String documentId;

  DataEntryPage({
    required this.collectionName,
    required this.documentId
});
  @override
  _DataEntryPageState createState() => _DataEntryPageState();
}
class _DataEntryPageState extends State<DataEntryPage>{
  final TextEditingController datacontroller = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initstate() {
    super.initState();

    //Fetch the data for editing
    fetchDataForEditing();
  }
  Future<void> fetchDataForEditing() async{
    DocumentSnapshot document = await firestore
        .collection(widget.collectionName)
        .doc(widget.documentId)
        .get();
    if (document.exists) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      String initialValue = data['age'];
      datacontroller.text = initialValue;
    }
  }
  void updateData(){
    String newData = datacontroller.text;

    //update the data in firestore
    firestore
    .collection(widget.collectionName)
    .doc(widget.documentId)
    .update({
      'age' : newData});
    //transition to another page/ display success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Success! Your data has been updated.'),
      ),
    );
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data'),
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller:datacontroller,
              decoration: InputDecoration(labelText: 'Edit Data'),
            ),
            ElevatedButton(onPressed: () {
              updateData();
              },
                child: Text('Update Data'),
            ),
          ],
        ),
      ),
    );
}
}