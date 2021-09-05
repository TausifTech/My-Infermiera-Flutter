import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_infermiera/home_page.dart';

class PatientDetails extends StatefulWidget {
  final String patientName;
  final String image;
  final dynamic age;

  PatientDetails(this.patientName, this.image, this.age);

  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('MD Tausif').doc('uid').collection('Records').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(widget.patientName).doc('uid').collection('Records').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong' + widget.patientName);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Scaffold(
          appBar: AppBar(
            title:
            Text(widget.patientName + ' Details'),
          ),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              return Material(
                  child: ListTile(
                    leading: Text('BP        \n' + data['bp'],style: TextStyle(fontSize: 17),),
                    title: Text(data['input time'], ),
                    subtitle: Text(data['when'],style: TextStyle(fontSize: 17),),
                    trailing: Text('Sugar\n' + data['sugar'],style: TextStyle(fontSize: 17),),
                  ));
            }).toList(),
          ),
        );
      },
    );
  }
}