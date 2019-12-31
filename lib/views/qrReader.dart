import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_train/utils/colors.dart';
import 'package:flutter_train/views/home.dart';
import 'package:flutter_train/views/info_select.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class QrPage extends StatefulWidget {
  final String _userEmail;
  QrPage(this._userEmail): super();
  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  String barcode = '';
  int _StartLocation = -1;
  int _DestinationLocation = -1;
  String _trainId ;
  String _destination ='';
  String printCan = '' ;
  String _destinationTime,_start,_startTime,_trainName;
  List<int> seatListOne = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
  List<int> seatListTwo = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
  Uint8List bytes = Uint8List(200);

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getTravelDetails();
    fixedlocationStart();
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primaryColor),
      );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(

           backgroundColor:Colors.orange,
          title: Container(
            alignment: Alignment.center,
            child: Text("Scan your seat QR_Code",
                style: TextStyle(
                  color: Colors.white,fontSize: 30.0,
                )),
          ),
        ),

        body: Container(
          padding: EdgeInsets.only(top: 70.0),
          decoration: BoxDecoration(gradient: primaryGradient),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(

           mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 200,
                child: Image.memory(bytes),
              ),

              //Text('RESULT  $barcode'),
              RaisedButton(
                elevation: 5.0,
                onPressed: () => _scan(),
                color: Colors.white,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(7.0),
                ),
                child: Text(
                  'Scan',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
              ),
              // RaisedButton(onPressed: _scanPhoto, child: Text("Scan Photo")),
              // RaisedButton(onPressed: _generateBarCode, child: Text("Generate Barcode")),
            ],
          ),
        ),
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    setState(() => this.barcode = barcode);
    if(this.barcode != ''){
    //  print('1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111');
        print(this.barcode);
        for(int x = 1; x < 25;x++) {
          if (this.barcode == 'Seat$x${seatListOne[x]}') {
            cancelSeat();
       //     print('00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
          }
          else if (this.barcode == 'Seat$x${seatListTwo[x]}') {
            cancelSeat();
       //     print('00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
          }
        }
    // Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => InfoSelectPage()));
    }
  }

/* Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    setState(() => this.barcode = barcode);
  }

  Future _generateBarCode() async {
    Uint8List result = await scanner.generateBarCode('https://github.com/leyan95/qrcode_scanner');
    this.setState(() => this.bytes = result);
  }*/

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
   /* for (int i = 1; i < 25; i++) {
      if (seatListOne[i] == 2) {
        for (int x =_StartLocation; x <= _DestinationLocation; x++) {
       //   await Firestore.instance.collection('${widget._userEmail}').document('BookSeatClassOne').setData({'Seat$i': 'no'}, merge: true);
        }
      }
    }
    for (int i = 1; i < 25; i++) {
      if (seatListTwo[i] == 2) {
        for (int x =_StartLocation; x <= _DestinationLocation; x++) {
      //    await Firestore.instance.collection('${widget._userEmail}').document('BookSeatClassTwo').setData({'Seat$i': 'no'}, merge: true);
        }
      }
    }*/
 /*   Firestore.instance.collection('${widget._userEmail}').document('TravelDetails').setData(
        {'From': 'NO any booking','To' :'NO any booking','Train_Name' : 'NO any booking'
          ,'Train_Id' :'NO any booking','Start_time':'','Destination_time':''}, merge: true);*/
  //  printCan ='Unbook the Seat';
  //  Future.delayed(const Duration(milliseconds: 1000), () {
     await  Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => InfoSelectPage('${widget._userEmail}')));
 //   });
  }
}