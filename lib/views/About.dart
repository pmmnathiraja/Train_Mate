import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_train/views/home.dart';
import 'package:flutter_train/views/routeDisplay.dart';
import 'package:flutter_train/views/seatClassOne.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_train/utils/colors.dart';
import 'package:flutter_train/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_train/views/trainClassSelect.dart';

class  AboutConformPage extends StatefulWidget {
  AboutConformPage(this._userEmail) : super();
  final String _userEmail;
  @override
  AboutConformPageState createState() => AboutConformPageState();
}

class AboutConformPageState extends State< AboutConformPage> {
  int _StartLocation = -1;
  int _DestinationLocation = -1;
  String _trainId ;
  String _destination ='';
  String printCan = '' ;
  String _destinationTime,_start,_startTime,_trainName;
  List<int> seatListOne = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
  List<int> seatListTwo = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
 // int _currentIndex = 0;
  @override
  // TODO: implement widget
  Widget build(BuildContext context) {
    getTravelDetails();
    fixedlocationStart();
  //  print('*************************************************************************************************************************************');
  //  print(_StartLocation);
 //  print(_DestinationLocation);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: primaryColor),
    );
   // print('8888888888888888888888888888888888888888888888888888888888888888888888888888888');
    // getTravelDetails();
    final TrainName = Container(

      width: 350,
      height: 60,
      padding: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        // color: Colors.white,
      ),
      child: Text(
        'Train_Name : $_trainName',textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
        ),
      ),
    );

    final FromName = Container(
      width: 350,
      height: 60,
      padding: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        // color: Colors.white,
      ),
      child: Text(
        'From : $_start - $_startTime',textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,

        ),
      ),
    );
    final toName = Container(
      width: 350,
      height: 60,
      padding: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        // color: Colors.white,
      ),
      child: Text(
        'To : $_destination - $_destinationTime',textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
        ),
      ),
    );
    final printCancel = Container(
     /* width: 350,
      height: 60,
      padding: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        // color: Colors.white,
      ),*/
      child: Text(
        '$printCan',textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
        ),
      ),
    );



    final cancelBtn = Container(
      height: 60.0,
      width: 200.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:() => cancelSeat(),
        color: Colors.white,
        child: Text(
          'Cancel Seat',style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 25.0,
        ),
        ),
      ),
    );



    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(title: Text('          MY SEAT BOOKING',style: TextStyle(
        fontWeight: FontWeight.w300,fontSize: 20.0,color: Colors.black,),),),

   /*   body: Container(


        padding: EdgeInsets.only(top: 50.0),
        decoration: BoxDecoration(gradient: primaryGradient),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            TrainName,SizedBox(height: 50.0),FromName,SizedBox(height: 50.0),toName,SizedBox(height: 50.0),seat_01
          ],
        ),
      ),*/
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 40.0),
              decoration: BoxDecoration(gradient: primaryGradient),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  TrainName,SizedBox(height: 40.0),FromName,SizedBox(height: 25.0),toName,SizedBox(height: 35.0),cancelBtn,SizedBox(height: 35.0),printCancel,
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  /*decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AvailableImages.homePage,
                      fit: BoxFit.contain,
                    ),
                  ),*/
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  getTravelDetails(){
   // print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    setState(() {
      Firestore.instance.collection('${widget._userEmail}').document('TravelDetails').snapshots().listen(travelDetails);
      Firestore.instance.collection('${widget._userEmail}').document('BookSeatClassOne').snapshots().listen(getClassOne);
      Firestore.instance.collection('${widget._userEmail}').document('BookSeatClassTwo').snapshots().listen(getClassTwo);
    });
  }
  travelDetails(DocumentSnapshot snapshot) async {
   // print('44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444');
    _trainName = snapshot.data['Train_Name'];
    _start = snapshot.data['From'];
    _startTime = snapshot.data['Start_time'];
    _destination = snapshot.data['To'];
    _destinationTime = snapshot.data['Destination_time'];
    _trainId =snapshot.data['Train_Id'];
   // print(_trainName);
    getTravelDetailsSecond();
  //  fixedlocationStart();
  }
  getTravelDetailsSecond(){
  //  print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    setState(() {
      Firestore.instance.collection('${widget._userEmail}').document('TravelDetails').snapshots().listen(travelDetails);
    });
  }
  travelDetailsSecond(DocumentSnapshot snapshot) async {
 //   print('44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444');
    _trainName = snapshot.data['Train_Name'];
    _start = snapshot.data['From'];
    _startTime = snapshot.data['Start_time'];
    _destination = snapshot.data['To'];
    _destinationTime = snapshot.data['Destination_time'];
    _trainId =snapshot.data['Train_Id'];

  }
  getClassOne(DocumentSnapshot snapshot) async {
    String _temp = '';
    for(int x= 1 ; x < 25;x++){
      _temp = snapshot.data['Seat$x'];
      if(_temp == 'book'){
        seatListOne[x] = 2;
      }
    }

  }
  getClassTwo(DocumentSnapshot snapshot) async {
    String _temp = '';
    for(int x= 1 ; x < 25;x++){
      _temp = snapshot.data['Seat$x'];
      if(_temp == 'book'){
        seatListTwo[x] = 2;
      }
    }
  }
  fixedlocationStart() async {
    Firestore.instance.collection('$_trainId').document('$_start').snapshots().listen(StoreStart);
    Firestore.instance.collection('$_trainId').document('$_destination').snapshots().listen(StoreDestination);

  }
  StoreStart(DocumentSnapshot snapshot) async{
    _StartLocation = snapshot.data['index_NO'];
  }
  StoreDestination(DocumentSnapshot snapshot)async{
    _DestinationLocation = snapshot.data['index_NO'];
  }
  cancelSeat() async{
    for (int i = 1; i < 25; i++) {
      if (seatListOne[i] == 2) {
        for (int x =_StartLocation; x <= _DestinationLocation; x++) {
         await Firestore.instance.collection('$_trainId').document('${x}_ClassOne').setData({'Seat$i': 'no'}, merge: true);
         await Firestore.instance.collection('${widget._userEmail}').document('BookSeatClassOne').setData({'Seat$i': 'no'}, merge: true);
        }
      }
    }
    for (int i = 1; i < 25; i++) {
      if (seatListTwo[i] == 2) {
        for (int x =_StartLocation; x <= _DestinationLocation; x++) {
        await  Firestore.instance.collection('$_trainId').document('${x}_ClassTwo').setData({'Seat$i': 'no'}, merge: true);
        await Firestore.instance.collection('${widget._userEmail}').document('BookSeatClassTwo').setData({'Seat$i': 'no'}, merge: true);
        }
      }
    }
   Firestore.instance.collection('${widget._userEmail}').document('TravelDetails').setData(
        {'From': 'NO any booking','To' :'NO any booking','Train_Name' : 'NO any booking'
          ,'Train_Id' :'NO any booking','Start_time':'','Destination_time':''}, merge: true);
    printCan ='Unbook the Seat';
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => HomePage('${widget._userEmail}')));
    });
  }
}