import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/team.png',
              fit: BoxFit.contain,
            ),
            SizedBox(width: 10,),
            Container(margin: EdgeInsets.all(8),
                child: Text('"Infermiera" is the italian word for Patient Attendant',
                  style: TextStyle(fontFamily: 'Nunito',color: Colors.black),
                )),
            SizedBox(width: 10,),
            Container(margin: EdgeInsets.all(8),
            child: Text('This project was solely based on keeping track of the health of our closed ones. This mobile application helps us on updating the same "Profile Card" from multiple devices and we can keep the data in one place. This will also keep track of information of data entry from different devices.',
              style: TextStyle(fontFamily: 'Nunito',color: Colors.black),
            )),
            Spacer(),
            Text('Built on Flutter\nAndroid Target SDK 30\nProduct of TausifTech',style: TextStyle(fontFamily: 'Nunito',color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
