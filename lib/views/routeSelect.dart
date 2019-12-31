import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_train/views/routeDisplay.dart';
import 'package:flutter_train/views/seatClassOne.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter_train/utils/colors.dart';
import 'package:flutter_train/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_train/views/trainClassSelect.dart';

class  EnterLocationPage extends StatefulWidget {
  EnterLocationPage(this._UserEmail) : super();
  final String _UserEmail;
  @override
  _EnterLocationPageState createState() => _EnterLocationPageState();
}

class _EnterLocationPageState extends State< EnterLocationPage> {
  var selectedStart,selectedDestination, selectedType;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  DateTime selected;
  String _date =  "Enter the Date";
  String _time = DateFormat('EEEE').format(DateTime.now());
  String _startingPoint ='';
  String _destinationPoint = '';

  Future<void> _showDateTimePicker(BuildContext context) async {
    selected = await showDatePicker(
      context: context,
      initialDate:  DateTime.now(),
      firstDate:  DateTime(1960),
      lastDate:  DateTime(2050),
    );
    _time = DateFormat('EEEE').format(selected);
    _date = DateFormat('EEEE-yyyy-MMMM-dd').format(selected);
    if (selected != null) {
      setState(() {});
    }
  }
  @override
    Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primaryColor),
      );
    print('22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222${widget._UserEmail}');
    return Scaffold(
        appBar: AppBar(
         // backgroundColor:Colors.purpleAccent,
          title: Container(
            alignment: Alignment.center,
            child: Text("Select Your Route",
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
          child: Form(
          key: _formKeyValue,
            autovalidate: true,

          child:  ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            children: <Widget>[
              SizedBox(height: 0.0),
              RaisedButton(
                child:
                Text(_date,style: TextStyle(fontSize: 20),),
                  onPressed: (){_showDateTimePicker(context);},
                  shape:  RoundedRectangleBorder(
                      borderRadius:  BorderRadius.circular(30.0)),
                ),

              SizedBox(height: 40.0),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('Station').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItemsStart = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        // ignore: missing_return
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItemsStart.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.documentID,
                              style: TextStyle(color: Colors.black,fontSize: 20),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.locationArrow,
                              size: 25.0, color: Colors.white),
                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: currencyItemsStart,
                            onChanged: (currencyValueStart) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Start Station is $currencyValueStart',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              _startingPoint = '$currencyValueStart';
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedStart = currencyValueStart;
                              });
                            },
                            value: selectedStart,
                            isExpanded: false,
                            hint:  Text(
                              "Start Station",
                              style: TextStyle(color: Colors.white,fontSize: 20),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(height: 30.0),
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('Station').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItemsDestination = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        // ignore: missing_return
                        DocumentSnapshot snap = snapshot.data.documents[i];
                        currencyItemsDestination.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.documentID,
                              style: TextStyle(color: Colors.black,fontSize: 20),
                            ),
                            value: "${snap.documentID}",
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.locationArrow,
                              size: 25.0, color: Colors.white),
                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: currencyItemsDestination,
                            onChanged: (currencyValueDestination) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Destination Station is $currencyValueDestination',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              _destinationPoint = '$currencyValueDestination';
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedDestination = currencyValueDestination;
                              });
                            },
                            value: selectedDestination,
                            isExpanded: false,
                            hint: Text(
                              "Destination Station",
                              style: TextStyle(color: Colors.white,fontSize: 20),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(
                height: 30.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.white,
                      textColor: Colors.black,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Book Seats", style: TextStyle(fontSize: 24.0,color: Colors.black),),
                            ],
                          )),

                     //onPressed:()=> Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => TrainTimeTable(_startingPoint,_destinationPoint,_time))),
                         onPressed:() async => await(Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => TrainTimeTable(_startingPoint,_destinationPoint,_time,"${widget._UserEmail}")))),
                     // onPressed:()=> Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => TrainClassSelect(_startingPoint,_destinationPoint,_time,"${widget._UserEmail}",''))),
                      shape:  RoundedRectangleBorder(
                          borderRadius:  BorderRadius.circular(30.0))),
                ],

              ),
              SizedBox(height :0 ),
              Row(
                children: <Widget>[
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

            ],

          ),
          )
        )

    );
  }
}

