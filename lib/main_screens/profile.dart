import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void inputData() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Logged In'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              width: 200,
              child: Image.asset(
                'assets/images/profile.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20,),
            Text("Thankyou for volunteering ! You're the Best!",style: TextStyle(fontFamily: 'Nunito',color: Colors.white)),
            Spacer(),
            Text("This device is currently logged in as :\n" + FirebaseAuth.instance.currentUser!.email.toString()),
            SizedBox(height: 20,),
            Text("User ID is set at:\n" + FirebaseAuth.instance.currentUser!.uid.toString()),
            Spacer()
          ],
        )
      )
    );
  }
}
