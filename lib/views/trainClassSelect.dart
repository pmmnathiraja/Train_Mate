import 'package:flutter/material.dart';
import 'package:flutter_train/utils/colors.dart';
import 'package:flutter_train/views/seatClassOne.dart';
import 'package:flutter_train/views/seatClassTwo.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/services.dart';

class TrainClassSelect extends StatefulWidget {
  TrainClassSelect(this._Start,this._Destination,this._Day,this._Train_ID,this._userEmail,this._startTIme,this._destinationTime) ;
  String _Start;
  String _Destination;
  String _Day;
  String _Train_ID;
  String _userEmail;
  String _startTIme;
  String _destinationTime;

  @override
  _TrainClassSelectState createState() => _TrainClassSelectState();
}

class _TrainClassSelectState extends State<TrainClassSelect> {

  //var _textController = new TextEditingController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
  final List<Widget> _pages = [

    TrainPageOne('${widget._Start}','${widget._Destination}','${widget._Day}','${widget._Train_ID}','${widget._userEmail}','${widget._startTIme}','${widget._destinationTime}'),
    TrainPageTwo('${widget._Start}','${widget._Destination}','${widget._Day}','${widget._Train_ID}','${widget._userEmail}','${widget._startTIme}','${widget._destinationTime}'),
    //payment()
  ];


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }



    final bottomNavBar = BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey.withOpacity(0.6),
      elevation: 0.0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(LineIcons.train),
          title: Text(
            'Class_01',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.train),
          title: Text(
            'Class_02',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
     /*   BottomNavigationBarItem(
          icon: Icon(LineIcons.train),
          title: Text(
            'Class_03',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),*/
      /*  BottomNavigationBarItem(
          icon: Icon(LineIcons.train),
          title: Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )*/
      ],
    );

    return Scaffold(
      bottomNavigationBar: bottomNavBar,
      body: _pages[_currentIndex],
    );
  }
}
