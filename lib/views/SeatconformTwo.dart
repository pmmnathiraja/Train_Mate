import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train/_routing/routes.dart';
import 'package:flutter_train/canteenControl.dart';
import 'package:flutter_train/utils/colors.dart';
import 'package:flutter_train/utils/utils.dart';
import 'package:flutter_train/views/home.dart';

class SeatConformPageTwo extends StatefulWidget{
  final int _StartLocation;
  final int _DestinationLocation;
  final String _train_ID;
  final String _user_Email;
  final List<int> DistanceBook;
  final String _TrainName;
  final String _StartString;
  final String _DestinationString;
  final String _startTIme;
  final String _destinationTime;
  final int totalAmount ;
  SeatConformPageTwo(this._train_ID,this._user_Email,this.DistanceBook,
      this._StartLocation,this._DestinationLocation,this._TrainName,this._StartString,this._DestinationString
      ,this._startTIme,this._destinationTime,this.totalAmount): super();
  @override
  _SeatConformPageTwoState createState() => _SeatConformPageTwoState();
}
class _SeatConformPageTwoState extends State<SeatConformPageTwo> {
  /* SnackBar get snackBar => SnackBar(
    content: Text('Yay! A SnackBar!'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );*/

  Future<void> SeatChecker() async {
    for (int i = 1; i < 25; i++) {
      if (widget.DistanceBook[i] == 2) {
        for (int x = widget._StartLocation; x <=
            widget._DestinationLocation; x++) {
          Firestore.instance.collection('${widget._train_ID}').document(
              '${x}_ClassTwo').setData(
              {'Seat$i': 'book'}, merge: true);
        }
      }
    }
    await SaveUserInfo();
  }

  Future<void> SaveUserInfo() async{
    Firestore.instance.collection('${widget._user_Email}').document('BookSeatClassTwo').setData({ 'Seat1': 'no','Seat2': 'no','Seat3': 'no','Seat4': 'no','Seat5': 'no','Seat6': 'no','Seat7': 'no','Seat8': 'no','Seat9': 'no','Seat10': 'no',
      'Seat11': 'no','Seat12': 'no','Seat13': 'no','Seat14': 'no','Seat15': 'no','Seat16': 'no','Seat17': 'no','Seat18': 'no','Seat19': 'no','Seat20': 'no',
      'Seat21': 'no','Seat22': 'no','Seat23': 'no','Seat24': 'no'}, merge: true);
    for (int i = 1; i < 25; i++) {
      if (widget.DistanceBook[i] == 2) {
        Firestore.instance.collection('${widget._user_Email}').document('BookSeatClassTwo').setData({'Seat$i': 'book'}, merge: true);
      }
    }
    Firestore.instance.collection('${widget._user_Email}').document('TravelDetails').setData(
        {'From': '${widget._StartString}','To' :'${widget._DestinationString}','Train_Name' : '${widget._TrainName}'
          ,'Train_Id' :'${widget._train_ID}','Start_time':'${widget._startTIme}','Destination_time':'${widget._destinationTime}'}, merge: true);
    await(Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => HomePage('${widget._user_Email}'))));
  }


  @override
  Widget build(BuildContext context) {

    final textPrint = Column(
      children: <Widget>[

        Text( " FROM - ${widget._StartString}",textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,fontSize: 30.0,
            )),
        Text( " TO - ${widget._DestinationString}",textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,fontSize: 30.0,
            )),
        Text("Amount - RS.${widget.totalAmount}.00",textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,fontSize: 30.0,
            )),
        /*  Text("Total price = ${widget._user_Email}",
            style: TextStyle(
              color: Colors.white,fontSize: 30.0,
            )),*/
      ],

    );
    // TODO: implement build
    final conformbtn = Container(
      height: 60.0,
      width: 130.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: Builder(
        builder: (context) => RaisedButton(
          elevation: 5.0,
          child: Text(
            'Conform',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          onPressed: () => {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Conform the Booking'),
              duration: Duration(seconds: 3),
            )),SeatChecker(),
          },
          color: Colors.white,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0),
          ),
        ),
      ),
    );


    final cancelbtn = Container(
      height: 60.0,
      width: 130.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: Builder(
        builder: (context) => RaisedButton(
          elevation: 5.0,
          child: Text(
            'Cancel',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          onPressed: () => {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Stop the Booking'),
              duration: Duration(seconds: 3),
            )),snackBar(),
          },
          color: Colors.white,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0),
          ),
        ),
      ),
    );

    final buttons = Padding(
      padding: EdgeInsets.only(
        top: 75.0,
        bottom: 30.0,
        left: 30.0,
        right: 30.0,
      ),
      child: Row(
        children: <Widget>[ SizedBox(width: 35),cancelbtn, SizedBox(width: 20.0), conformbtn,
        ],
      ),
    );


    /*   final snackBar = SnackBar(
      content: Text('Yay! A SnackBar!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
*/

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),

      home: Scaffold(
        appBar: AppBar(
          title :Container(
            alignment: Alignment.center,
            child:  Text('Conform',
              textAlign: TextAlign.center,
              style: TextStyle
                (fontWeight: FontWeight.w600,
                fontSize: 30.0,color: Colors.black, ),),
          ),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 70.0),
                decoration: BoxDecoration(gradient: primaryGradient),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[textPrint,buttons,
                    Container(
                      height: 250.0,
                      width: 340,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AvailableImages.homePage,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],

                ),
              ),
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Container(
                    height: 250.0,
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
        /*   body: Container(
          alignment: Alignment.center,
          child: Text("Order Conform",
              style: TextStyle(
                color: Colors.green,fontSize: 30.0,
              )),

        ),*/
      ),
    );

  }
  void snackBar(){
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => HomePage('${widget._user_Email}')));
    });
    //async =>   await(Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => HomePage('${widget._user_Email}')))),
  }


}