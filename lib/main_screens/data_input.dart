import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_infermiera/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataInput extends StatefulWidget {
  final String patientName;
  final String image;
  final dynamic age;

  const DataInput({
    Key? key,
    required this.patientName,
    required this.image,
    required this.age,
  }) : super(key: key);


  @override
  _DataInputState createState() => _DataInputState();
}

class _DataInputState extends State<DataInput> {


  var scaffoldKey = GlobalKey<ScaffoldState>();
  double bp = 1.0;
  double sugar = 1.0;
  double insulin = 2.0;
  double medicine = 0.0;
  double food = 0.0;

  DateTime? _selectedDate;
  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now())
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return DateTime.now();
      }
      setState(() {
        // using state so that the UI will be rerendered when date is picked
        _selectedDate = pickedDate;
      });
    });
  }
  TimeOfDay? _selectedTime;
  void _presentTimePicker() {
    showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        )
        .then((pickedTime) {
      // Check if no date is selected
      if (pickedTime == null) {
        return TimeOfDay.now();
      }
      setState(() {
        // using state so that the UI will be rerendered when date is picked
        _selectedTime = pickedTime;
      });
    });
  }








  final bpController = TextEditingController(text: 'N');
  final sugarController = TextEditingController(text: 'N');
  String dropdownValue = 'Random Test';
  String dropdownValue2 = 'Home Made';












  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String image2 = widget.image;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: height * 0.44,
              child: Image.asset(
                'assets/images/$image2',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              height: height * 0.44,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xCC000000),
                    const Color(0x00000000),
                    const Color(0x00000000),
                    const Color(0xCC000000),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: height * 0.32,
            left: width * 0.03,
            child: Text(
              widget.patientName,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 45,
              ),
            ),
          ),
          Positioned(
            top: height * 0.06,
            left: width * 0.05,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: new Icon(Icons.arrow_back_ios),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: height * 0.6,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3.0),
                gradient: LinearGradient(
                  colors: [
                    Color(0xffB55A30),
                    Color(0xffd4835e),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: height * 0.02,
                    left: width * 0.1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      height: height * 0.07,
                      width: width * 0.38,
                      child: Center(
                        child: Text(DateTime.now().day.toString()+"."+DateTime.now().month.toString() +"."+DateTime.now().year.toString(),
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: height * 0.03,
                              color: Colors.black),),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.02,
                    right: width * 0.1,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/rid.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      height: height * 0.07,
                      width: width * 0.38,
                      child: Center(
                        child: Text(DateTime.now().hour.toString()+":"+DateTime.now().minute.toString(),
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: height * 0.03,
                              color: Colors.black),),
                      ),
                    ),
                  ),

                  ///////////////              sliders                                /////////////////////////////////////////
                  ///
                  ///
                  Positioned(
                    bottom: height * 0.14,
                    left: width * 0.05,
                    child: Container(
                        margin: EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width*0.5,
                         child: Wrap(direction: Axis.vertical, children: <Widget>[
                           IntrinsicWidth(
                             stepWidth: 220,
                             child: TextFormField(
                               style: TextStyle(fontSize: 20),
                               keyboardType: TextInputType.number,
                               controller: sugarController,
                               decoration: const InputDecoration(
                                 border: OutlineInputBorder(),
                                 labelText: 'Enter Sugar Level (Ex: 8.0)',
                                 contentPadding: EdgeInsets.all(8),
                               ),
                             ),
                           ),
                           SizedBox(height: 20),
                           IntrinsicWidth(
                             stepWidth: 220,
                             child: TextFormField(
                               style: TextStyle(fontSize: 20),
                               keyboardType: TextInputType.number,
                               controller: bpController,
                               decoration: const InputDecoration(
                                 border: OutlineInputBorder(),
                                 labelText: 'Enter Blood Pressure (Ex: 120/70)',
                                 contentPadding: EdgeInsets.all(8),
                               ),),
                           ),
                           SizedBox(height: 10,),
                           DropdownButton<String>(
                             value: dropdownValue,
                             icon: const Icon(Icons.arrow_downward),
                             iconSize: 24,
                             elevation: 16,
                             style: const TextStyle(color: Colors.white, fontSize: 20),
                             underline: Container(
                               height: 2,
                               color: Colors.deepPurpleAccent,
                             ),
                             onChanged: (String? newValue) {
                               setState(() {
                                 dropdownValue = newValue!;
                               });
                             },
                             items: <String>['Random Test', 'Fasting', '2 hrs after Breakfast', '2 hrs after LUNCH','2 hrs after DINNER']
                                 .map<DropdownMenuItem<String>>((String value) {
                               return DropdownMenuItem<String>(
                                 value: value,
                                 child: Text(value),
                               );
                             }).toList(),
                           ),

                           DropdownButton<String>(
                             value: dropdownValue2,
                             icon: const Icon(Icons.arrow_downward),
                             iconSize: 24,
                             elevation: 16,
                             style: const TextStyle(color: Colors.white, fontSize: 20),
                             underline: Container(
                               height: 2,
                               color: Colors.deepPurpleAccent,
                             ),
                             onChanged: (String? newValue) {
                               setState(() {
                                 dropdownValue2 = newValue!;
                               });
                             },
                             items: <String>['Home Made', 'Fruits', 'Store Bought', 'Polaw','Oily Food']
                                 .map<DropdownMenuItem<String>>((String value) {
                               return DropdownMenuItem<String>(
                                 value: value,
                                 child: Text(value),
                               );
                             }).toList(),
                           ),
                           ]
                         ))
          ),

///////////////////////////////////
                  ///
                  ///
                  ///
                  ///
                  ///
                  ///
                  ///
                  ///
                  Positioned(
                    bottom: height * 0.06,
                    left: 0,
                    child: InkResponse(
                      onTap: () {
                        createRecord();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2.0),
                          color: Colors.grey,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        height: height * 0.07,
                        width: width * 0.9,
                        child: Row(children: [
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'ADD DATA',
                            style: TextStyle(
                                fontFamily: 'Nunito', fontSize: height * 0.02),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                          ),
                          SizedBox(
                            width: 15,
                          )
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }




  void createRecord() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;

    if (user != null) {
      final uid = user.uid;
      print(user.uid);

    final QuerySnapshot qSnap = await FirebaseFirestore.instance
        .collection(widget.patientName)
        .doc('uid')
        .collection('Records')
        .get();
    final int documents = (qSnap.docs.length) + 1;
    final String length = documents.toString();

    final dynamic x = sugarController.text;
    final dynamic y = bpController.text;
    final dynamic z = dropdownValue;
    final dynamic p = dropdownValue2;
    final dynamic q = insulin;
    final dynamic r = DateTime.now().day.toString()+"."+DateTime.now().month.toString() +"."+DateTime.now().year.toString()+" at "+DateTime.now().hour.toString()+":"+DateTime.now().minute.toString();

    await FirebaseFirestore.instance
        .collection(widget.patientName)
        .doc('uid')
        .collection('Records')
        .doc(DateTime.now().day.toString()+"."+DateTime.now().month.toString() +"."+DateTime.now().year.toString()+" at "+DateTime.now().hour.toString()+":"+DateTime.now().minute.toString())
        .set({
      'Name': widget.patientName,
      'sugar': x,
      'bp': y,
      'when': z,
      'insulin': q,
      'food': p,
      'input time': r,
      'recorded by' : uid
    });
  }}
}
