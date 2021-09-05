import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatelessWidget {
  final String patientName;
  final String image;
  final int age;

  AddUser(this.patientName, this.image, this.age);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('MD Tausif').doc('uid').collection('Records');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
        'Name': 'MD Tausif',
        'sugar': 9,
        'bp': 7,
        'med': 3,
        'insulin': 100,
        'food': 3,
        'selected time': DateTime.now().day.toString()+"."+DateTime.now().month.toString() +"."+DateTime.now().year.toString()+" at "+DateTime.now().hour.toString()+":"+DateTime.now().minute.toString(),
        'recorded by' : 'Myself'
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('MD Afrauzzaman').doc('uid').collection('Records').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Material(
                    child: ListTile(
                      leading: Text('BP        \n' + data['bp'],style: TextStyle(fontSize: 17,),),
                      title: Text(data['input time'], ),
                      subtitle: Text(data['when'],style: TextStyle(fontSize: 17),),
                      trailing: Text('Sugar\n' + data['sugar'],style: TextStyle(fontSize: 17),),
                    ));
              }).toList(),
        );
      },
    );
  }
}
