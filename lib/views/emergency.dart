import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train/_routing/routes.dart';
import 'package:flutter_train/canteenControl.dart';
import 'package:flutter_train/src/screens/OrderConform.dart';
import 'package:flutter_train/utils/colors.dart';
import 'package:flutter_train/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_train/views/About.dart';
import 'package:flutter_train/views/info_select.dart';
import 'package:flutter_train/views/qrReader.dart';
import 'package:flutter_train/views/routeSelect.dart';

final databaseReference = FirebaseDatabase.instance.reference();

class EmergencyPage extends StatefulWidget {
  final String userName;
  EmergencyPage(this.userName): super();

  @override
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  String telNumber = '0769052797';
  String telephoneNumber = '';
  String trainName ='';
  String userInfo;

 /* void createRecord() {
   databaseReference.child("buzzer").set({
      'title': 'ON',
    });
    databaseReference.child("tele").set({
      'title': telNumber,
    });
  }*/
  @override
  Widget build(BuildContext context) {
    getSeatNumber();
    return Scaffold(
      appBar: AppBar(

        title: Text('text'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Untitled.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          leading: Icon(Icons.report_problem, size: 50),
                          title: Text('Press the Button Below in case of EMERGENCY',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent,
                                fontFamily: 'Open Sans',
                                fontSize: 30),),
                          subtitle: Text('You will Imediately Receive a Call from the Staff',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Open Sans',
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),),
                  )
              ),


            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended (

        onPressed: createRecord,
        tooltip: 'Panic Button',
        icon: Icon(Icons.alarm_on),
        label: Text('Sound Panic Alarm'),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  createRecord() async{
    databaseReference.child("buzzer").set({
      'title': 'ON',
    });
    databaseReference.child("tele").set({
      'title': telNumber,
    });
    await Firestore.instance.collection('Emergency_$trainName').document('$userInfo').setData({ 'TelephoneNumber': '$telephoneNumber'},merge: true);

  }
  getSeatNumber() async {
    Firestore.instance.collection('UserDetails').document('${widget.userName}').snapshots().listen(StoreStart);
    Firestore.instance.collection('${widget.userName}').document('TravelDetails').snapshots().listen(getTrainName);
  }
  StoreStart(DocumentSnapshot snapshot) async{
    // print('-------------[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[----${widget.userName}');
    userInfo = snapshot.data['Name'];
    telephoneNumber =  snapshot.data['TelephoneNumber'];
    //   print('$userInfo');
    getSeatNumberRefresh();
  }
  getSeatNumberRefresh() async {
    Firestore.instance.collection('UserDetails').document('${widget.userName}').snapshots().listen(StoreStart);
  }
  StoreStartRefresh(DocumentSnapshot snapshot) async{
    userInfo = snapshot.data['Name'];
   // telephoneNumber =  snapshot.data['TelephoneNumber'];
    //print('0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');
   // print(telephoneNumber);


  }
  getTrainName(DocumentSnapshot snapshot) async{
    trainName = snapshot.data['Train_Name'];
    //  print('////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////');
   // print(trainName);
  }
}
