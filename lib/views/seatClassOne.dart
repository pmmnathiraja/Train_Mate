import 'package:flutter/material.dart';
import 'package:flutter_train/_routing/routes.dart';
import 'package:flutter_train/utils/colors.dart';
import 'package:flutter_train/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_train/views/SeatconformOne.dart';
import 'package:flutter_train/views/routeDisplay.dart';
import 'package:flutter_train/views/trainClassSelect.dart';
import 'package:line_icons/line_icons.dart';

class TrainPageOne extends StatefulWidget {
  TrainPageOne(this._Start,this._Destination,this._Day,this._Train_ID,this._userEmail,this._startTime,this._destinationTime) : super();
  String _Start, _Destination,_Day,_Train_ID,_userEmail,_startTime,_destinationTime;
  @override
  _TrainPageOneState createState() => _TrainPageOneState();
}

class _TrainPageOneState extends State<TrainPageOne> {
  int _StartLocation = -1;
  int _DestinationLocation = -1;
  String _TrainName ='';
  int seatCount = 0 ;
  int startAmount = 0;
  int endAmount = 0;
  int amountForOne =0;
  int totalAmount = 0;
  List<Color> _colors = [ //Get list of colors
    Colors.blue,
    Colors.white,
    Colors.red,
    Colors.brown,
    Colors.teal,
    Colors.purple
  ];
  List<int> Seat = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];

  @override
  Widget build(BuildContext context) {
    fixedlocationStart();
    amountForOne = endAmount - startAmount;
    totalAmount = amountForOne*seatCount;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: primaryColor),
    );

    final appName = Column(
      children: <Widget>[
        Text("Class One",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  /*  final appName = Column(
      children: <Widget>[
        Text(
          AppConfig.appName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 50.0,
          ),
        ),
        Text(
          AppConfig.appTagline,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w500
          ),
        )
      ],
    );*/
    final seat_01 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(1);},
        color: _colors[Seat[1]],
        child: Text(
          '01',
        ),
      ),
    );
    final seat_02 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(2);},

        color: _colors[Seat[2]],
        child: Text(
          '02',
        ),
      ),
    );
    final seat_03 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(3);},

        color: _colors[Seat[3]],
        child: Text(
          '03',
        ),
      ),
    );
    final seat_04 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(4);},

        color: _colors[Seat[4]],
        child: Text(
          '04',
        ),
      ),
    );
    final seat_05 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(5);},

        color: _colors[Seat[5]],
        child: Text(
          '05',
        ),
      ),
    );
    final seat_06 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(6);},

        color: _colors[Seat[6]],
        child: Text(
          '06',
        ),
      ),
    );
    final seat_07 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){_onChanged(7);},

        color: _colors[Seat[7]],
        child: Text(
          '07',
        ),
      ),
    );
    final seat_08 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){_onChanged(8);},

        color: _colors[Seat[8]],
        child: Text(
          '08',
        ),
      ),
    );
    final seat_09 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(9);},

        color: _colors[Seat[9]],
        child: Text(
          '09',
        ),
      ),
    );
    final seat_10 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){_onChanged(10);},

        color: _colors[Seat[10]],
        child: Text(
          '10',
        ),
      ),
    );
    final seat_11 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){_onChanged(11);},

        color: _colors[Seat[11]],
        child: Text(
          '11',
        ),
      ),
    );
    final seat_12 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(12);},

        color: _colors[Seat[12]],
        child: Text(
          '12',
        ),
      ),
    );
    final seat_13 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(13);},

        color: _colors[Seat[13]],
        child: Text(
          '13',
        ),
      ),
    );
    final seat_14 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(14);},

        color: _colors[Seat[14]],
        child: Text(
          '14',
        ),
      ),
    );
    final seat_15 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(15);},

        color: _colors[Seat[15]],
        child: Text(
          '15',
        ),
      ),
    );
    final seat_16 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){_onChanged(16);},

        color: _colors[Seat[16]],
        child: Text(
          '16',
        ),
      ),
    );
    final seat_17 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){_onChanged(17);},

        color: _colors[Seat[17]],
        child: Text(
          '17',
        ),
      ),
    );
    final seat_18 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(18);},

        color: _colors[Seat[18]],
        child: Text(
          '18',
        ),
      ),
    ); final seat_19 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(19);},

        color: _colors[Seat[19]],
        child: Text(
          '19',
        ),
      ),
    );
    final seat_20 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){_onChanged(20);},
        color: _colors[Seat[20]],
        child: Text(
          '20',
        ),
      ),
    );
    final seat_21 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed:(){_onChanged(21);},
        color: _colors[Seat[21]],
        child: Text(
          '21',
        ),
      ),
    );
    final seat_22 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){_onChanged(22);},

        color: _colors[Seat[22]],
        child: Text(
          '22',
        ),
      ),
    );
    final seat_23 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){_onChanged(23);},
        color: _colors[Seat[23]],
        child: Text(
          '23',
        ),
      ),
    );
    final seat_24 = Container(
      height: 60.0,
      width: 60.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){_onChanged(24);},
        color: _colors[Seat[24]],
        child: Text(
          '24',
        ),
      ),
    );

    final submitBtn = Container(
      height: 50.0,
      width: 90.0,
      child: RaisedButton(
        elevation: 5.0,

         onPressed: () async => await(Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => SeatConformPageOne
           ("${widget._Train_ID}","${widget._userEmail}",Seat,_StartLocation,_DestinationLocation,_TrainName,
             "${widget._Start}","${widget._Destination}",'${widget._startTime}','${widget._destinationTime}',totalAmount)))),
        color: Colors.white,//_colors[Seat[24]

        child: Icon(LineIcons.paypal),

      ),
    );
    //********************************************************************************************************************
    final buttonsSet01 = Padding(
      padding: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        left: 45.0,
        right: 30.0,
      ),
      child: Row(
        children: <Widget>[seat_01, SizedBox(width: 10.0), seat_02, SizedBox(width: 60.0),seat_03, SizedBox(width: 10.0), seat_04],
      ),
    );
    final buttonsSet02 = Padding(
      padding: EdgeInsets.only(
        top: 20.0,
        bottom: 10.0,
        left: 45.0,
        right: 30.0,
      ),
      child: Row(
        children: <Widget>[seat_05, SizedBox(width: 10.0), seat_06, SizedBox(width: 60.0),seat_07, SizedBox(width: 10.0), seat_08],
      ),
    );
    final buttonsSet03 = Padding(
      padding: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        left: 45.0,
        right: 30.0,
      ),
      child: Row(
        children: <Widget>[seat_09, SizedBox(width: 10.0), seat_10, SizedBox(width: 60.0),seat_11, SizedBox(width: 10.0), seat_12],
      ),
    );
    final buttonsSet04 = Padding(
      padding: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        left: 45.0,
        right: 30.0,
      ),
      child: Row(
        children: <Widget>[seat_13, SizedBox(width: 10.0), seat_14, SizedBox(width: 60.0),seat_15, SizedBox(width: 10.0), seat_16],
      ),
    );
    final buttonsSet05 = Padding(
      padding: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        left: 45.0,
        right: 30.0,
      ),
      child: Row(
        children: <Widget>[seat_17, SizedBox(width: 10.0), seat_18, SizedBox(width: 60.0),seat_19, SizedBox(width: 10.0), seat_20],
      ),
    );
    final buttonsSet06 = Padding(
      padding: EdgeInsets.only(
        top: 10.0,
        bottom: 10.0,
        left: 45.0,
        right: 30.0,
      ),
      child: Row(
        children: <Widget>[seat_21, SizedBox(width: 10.0), seat_22, SizedBox(width: 60.0),seat_23, SizedBox(width: 10.0), seat_24],
      ),
    );

    final buttonsSet07 = Padding(
      padding: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
        left: 45.0,
        right: 30.0,
      ),
      child: Row(
        children: <Widget>[SizedBox(width: 240.0), submitBtn],
      ),
    );

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 40.0),
              decoration: BoxDecoration(gradient: primaryGradient),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[appName,buttonsSet01,buttonsSet02,buttonsSet03,buttonsSet04,buttonsSet05,buttonsSet06,buttonsSet07],
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

    Future<void> _onChanged(int _seat_num) async { //update with a new color when the user taps button
      setState(() {

        if (Seat[_seat_num] == 0) {
        }
        else if(Seat[_seat_num] != 2) {
          Seat[_seat_num] = 2;
          seatCount++;
        }
        else if(Seat[_seat_num] == 2) {
          seatCount--;
          Seat[_seat_num] = 1;
        }
      });
  }



  fixedlocationStart() {
    Firestore.instance.collection('${widget._Train_ID}').document('${widget._Start}').snapshots().listen(StoreStart);
    Firestore.instance.collection('${widget._Train_ID}').document('Train_Name').snapshots().listen(Getname);
    Firestore.instance.collection('${widget._Train_ID}').document('${widget._Destination}').snapshots().listen(StoreDestination);

  }
  StoreStart(DocumentSnapshot snapshot) async{
    _StartLocation = snapshot.data['index_NO'];
    startAmount = snapshot.data['amount'];
  }
  Getname(DocumentSnapshot snapshot)async{
    _TrainName = snapshot.data['Name'];
  }
  StoreDestination(DocumentSnapshot snapshot)async{
    _DestinationLocation = snapshot.data['index_NO'];
    endAmount = snapshot.data['amount'];
    SeatCheck();
  }
  SeatCheck() async{
    for(int x = _StartLocation;x <= _DestinationLocation;x++){
      Firestore.instance.collection('${widget._Train_ID}').document('${x}_ClassOne').snapshots().listen(SeatChecker);
     // print(x);
    }
  }

  SeatChecker(DocumentSnapshot snapshot)async{
    for (int i = 1; i < 25; i++) {
      setState(() {
        if (snapshot.data['Seat$i'] == 'book') {
          Seat[i] = 0 ;

        }
      });
    }
  }

}


