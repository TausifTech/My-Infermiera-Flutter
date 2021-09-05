import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_infermiera/main.dart';
import 'package:my_infermiera/main_screens/about.dart';
import 'package:my_infermiera/main_screens/firestore1.dart';
import 'package:my_infermiera/main_screens/profile.dart';
import 'package:my_infermiera/main_screens/profile_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;


      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("My Infermiera!")),
        key: scaffoldKey,
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black54,
          ),
          child: Drawer(
            child: ListView(
              children: [

                SizedBox(
                  height: height * 0.06,
                ),
                DrawerHeader(
                  child: Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Center(
                  child: Text(
                    "My Infermiera!",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                        fontSize: width * 0.05),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text(
                    'Profile',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.access_alarms_rounded),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('Patient Details'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserInformation()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.radio),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('About'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => About()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_remove),
                  trailing: Icon(Icons.arrow_forward_ios),
                  title: Text('Sign Out'),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    setState(() {});
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.01,),
              Text("Thanks for making our day better!\nAt "+ DateTime.now().hour.toString()+":"+DateTime.now().minute.toString(),
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.w300, // light
                    fontStyle: FontStyle.italic,
                    color: Colors.black),),
              Image.asset('assets/images/team2.jpg',fit: BoxFit.cover,),
              Spacer(),
              PatientProfiles()
            ],
          ),
        ),
      );
    }
}