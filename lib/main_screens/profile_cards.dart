import 'package:flutter/material.dart';
import 'package:my_infermiera/main_screens/data_input.dart';
import 'dart:math' as math;

import 'package:my_infermiera/main_screens/data_output.dart';


class PatientProfiles extends StatefulWidget {

  @override
  _PatientProfilesState createState() => _PatientProfilesState();
}

class _PatientProfilesState extends State<PatientProfiles> {
  PageController _pageController = PageController();
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.48,
      child: PageView(
        onPageChanged: (num){
          setState(() {
            pageOffset = num.toDouble();
          });
        },
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          SlidingCard(
            patientName: 'MD Afrauzzaman',
            Department: 'Endocrinology Department',
            assetName: 'afr2.gif',
            offset: pageOffset,
            age: 62,
          ),
          SlidingCard(
            patientName: 'Afra Nuha',
            Department: 'Child Development Department',
            assetName: 'nuh.gif',
            age: 14,
            offset: pageOffset - 1,
          ),
          SlidingCard(
            patientName: 'Roksana Begum',
            Department: 'General Department',
            assetName: 'rok.gif',
            age: 50,
            offset: pageOffset - 2,
          ),
          SlidingCard(
            patientName: 'Abd. Tasneem',
            Department: 'General Department',
            assetName: 'tas.gif',
            age: 27,
            offset: pageOffset - 3,
          ),
          SlidingCard(
            patientName: 'MD Tausif',
            Department: 'Neuro Department',
            assetName: 'walk.gif',
            age: 24,
            offset: pageOffset - 4,
          ),
          SlidingCard(
            patientName: 'Iqra Mirza',
            Department: 'Neuro Department',
            assetName: 'iq.gif',
            age: -2,
            offset: pageOffset - 5,
          ),
        ],
      ),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String patientName;
  final dynamic age;
  final String Department;
  final String assetName;
  final double offset;

  const SlidingCard({
    Key? key,
    required this.patientName,
    required this.age,
    required this.Department,
    required this.assetName,
    required this.offset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                'assets/images/$assetName',
                height: MediaQuery.of(context).size.height * 0.28,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.fitHeight,

              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: CardContent(
                patientName: patientName,
                department: Department,
                image: assetName,
                age: age,
                offset: gauss,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String patientName;
  final String department;
  final String image;
  final dynamic age;
  final double offset;

  const CardContent(
      {Key? key,
        required this.patientName,
        required this.image,
        required this.age,
        required this.department,
        required this.offset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Text(
              patientName,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Text(
              department,
              style: TextStyle(color: Colors.black),
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              SizedBox(
                width: 1,
              ),
              Transform.translate(
                offset: Offset(48 * offset, 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataInput(
                            patientName: patientName,
                            image: image,
                            age: age,
                          )),
                    );
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        'Select',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                      color: Color(0xFF162A49),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.white, width: 2.0),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(39, 105, 171, 1),
                          Color.fromRGBO(4, 9, 35, 1),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(3, 7), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientDetails(
                          patientName,
                          image,
                          age,
                        )),
                  );
                },
                child: Container(
                  child: Center(
                    child: Text(
                      'Details',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    color: Color(0xFF162A49),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: Colors.white, width: 2.0),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(39, 105, 171, 1),
                        Color.fromRGBO(4, 9, 35, 1),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(3, 7), // changes position of shadow
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Transform.translate(
                offset: Offset(32 * offset, 0),
                child: Text(
                  age.toString() + " Yrs",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
