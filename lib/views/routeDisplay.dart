import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_train/utils/colors.dart';
import 'package:flutter_train/views/trainClassSelect.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TrainTimeTable extends StatefulWidget {
  TrainTimeTable(this._Start,this._Destination,this._Day,this._userEmail) : super();
  final String _Start, _Destination,_Day,_userEmail;
  @override
  _TrainTimeTableState createState() => _TrainTimeTableState();
}

class _TrainTimeTableState extends State<TrainTimeTable> {
  void write()async{
    Firestore.instance.collection('0X01').document('4_ClassOne').setData({ 'Seat1': 'no','Seat2': 'no','Seat3': 'no','Seat4': 'no','Seat5': 'no','Seat6': 'no','Seat7': 'no','Seat8': 'no','Seat9': 'no','Seat10': 'no',
      'Seat11': 'no','Seat12': 'no','Seat13': 'no','Seat14': 'no','Seat15': 'no','Seat16': 'no','Seat17': 'no','Seat18': 'no','Seat19': 'no','Seat20': 'no',
      'Seat21': 'no','Seat22': 'no','Seat23': 'no','Seat24': 'no'});
  }
  int count = 0;
 // String _train_ID = '';

  final TextEditingController eCtrl = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
  //  write();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: primaryColor),
    );
    return Scaffold(
        appBar: AppBar(

          title:Text('        TIME TABLE',
            textAlign: TextAlign.center,
            style: TextStyle
              (fontWeight: FontWeight.w600,
              fontSize: 25.0,color: Colors.black, ),),),
        body: Container (
          padding: EdgeInsets.only(top: 0.0),
          decoration: BoxDecoration(gradient: primaryGradient),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('${widget._Day}').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: return  Text('Loading...');
                default:
                  return  ListView(

                    children:  snapshot.data.documents.map((DocumentSnapshot document) {
                      // ignore: unused_label
                      if( document['${widget._Start}'] == null) return CircularProgressIndicator();
                      if( document['${widget._Destination}'] == null) return CircularProgressIndicator();
                      return  ListTile(
                        leading: Icon(FontAwesomeIcons.train,
                            size: 25.0, color: Colors.black),

                        title: Text("   ${widget._Start} - " +document['${widget._Start}'],style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18.0,
                        ),),

                        subtitle: Text("      ${widget._Destination} - " + document['${widget._Destination}'],style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18.0,
                        ),),


                        onLongPress: (){read(document.documentID,document['${widget._Start}'],document['${widget._Destination}']);},




                      );
                    }).toList(),
                  );
              }
            },
          ),
        )
    );
  }
  read(String _trainId,String _startTime,String _destinationTime ){

    Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => TrainClassSelect("${widget._Start}","${widget._Destination}","${widget._Day}",_trainId,"${widget._userEmail}",_startTime,_destinationTime)));

  }
}
