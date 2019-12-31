import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_train/_routing/routes.dart';
import 'package:flutter_train/canteenControl.dart';
import 'package:flutter_train/utils/colors.dart';
import 'package:flutter_train/utils/utils.dart';
import 'package:flutter_train/views/home.dart';

class OrderPage extends StatefulWidget{
  final String _name;
  final String _price;
  final int _quantity;
  final String userName;

      OrderPage(this._name, this._price,this._quantity,this.userName): super();
  @override
  _OrderPageState createState() => _OrderPageState();
}
class _OrderPageState extends State<OrderPage>{
  String _printConform = '';
  String trainName ='';
  String userInfo;
  @override
  Widget build(BuildContext context) {
  //  print('**********************************************************************************************************${widget.userName}');
    getSeatNumber();
    final double _total = widget._quantity* double.parse(widget._price);

    final textPrint = Column(
      children: <Widget>[
        Text("${widget._name} X ${widget._quantity} = $_total",
            style: TextStyle(
              color: Colors.white,fontSize: 30.0,
            )),
        Text("Total price = $_total",
            style: TextStyle(
              color: Colors.white,fontSize: 30.0,
            )),
         Text("$_printConform",
            style: TextStyle(
              color: Colors.white,fontSize: 30.0,
            )),
      ],

    );
    // TODO: implement build
     final conformBtn = Container(
       height: 60.0,
       width: 130.0,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(7.0),
         border: Border.all(color: Colors.white),
         color: Colors.white,
       ),
   /*    child: RaisedButton(
         elevation: 5.0,
         onPressed: () => upload(),

         color: Colors.white,
         shape: new RoundedRectangleBorder(
           borderRadius: new BorderRadius.circular(7.0),
         ),
         child: Text(
           'Conform',
           style: TextStyle(
             fontWeight: FontWeight.w600,
             fontSize: 20.0,
           ),
         ),
       )*/
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
               content: Text('Conform the Order'),
               duration: Duration(seconds: 3),
             )),upload(),
           },
           color: Colors.white,
           shape: new RoundedRectangleBorder(
             borderRadius: new BorderRadius.circular(7.0),
           ),
         ),
       ),);


     final cancelbtn = Container(
       height: 60.0,
       width: 130.0,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(7.0),
         border: Border.all(color: Colors.white),
         color: Colors.white,
       ),
    /*   child: RaisedButton(
         elevation: 5.0,
     //    onPressed: () => Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => CanteenControl())),

         color: Colors.white,
         shape: new RoundedRectangleBorder(
           borderRadius: new BorderRadius.circular(7.0),
         ),
         child: Text(
           'Cancel',
           style: TextStyle(
             fontWeight: FontWeight.w600,
             fontSize: 20.0,
           ),
         ),
       )*/
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
             onPressed: () async => {
               Scaffold.of(context).showSnackBar(SnackBar(
                 content: Text('Cancel the Order'),
                 duration: Duration(seconds: 3),
               )),await Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => CanteenControl('${widget.userName}'))),
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
         children: <Widget>[ SizedBox(width: 35),cancelbtn, SizedBox(width: 20.0), conformBtn],
       ),
     );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      
      home: Scaffold(
       appBar: AppBar(
         title :Container(
         alignment: Alignment.center,
         child: Text("Order Conform",
             style: TextStyle(
               color: Colors.white,fontSize: 30.0,
             )),
       ),
       ),
        body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 50.0),
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
                    )],
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

 upload() async{
      _printConform = 'Order Delivered';
      await Firestore.instance.collection('$trainName').document('$userInfo').setData({ 'food': '${widget._name}', 'amount': '${widget._quantity}',});
   // Firestore.instance.collection('${widget.userName}').document('888888888').setData({ 'food': '${widget._name}', 'amount': '${widget._quantity}',});
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => HomePage('${widget.userName}')));
    });
  }
  getSeatNumber() async {
    Firestore.instance.collection('UserDetails').document('${widget.userName}').snapshots().listen(StoreStart);
    Firestore.instance.collection('${widget.userName}').document('TravelDetails').snapshots().listen(getTrainName);
  }
  StoreStart(DocumentSnapshot snapshot) async{
   // print('-------------[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[----${widget.userName}');
    userInfo = snapshot.data['Name'];
 //   print('$userInfo');
    getSeatNumberRefresh();
  }
  getSeatNumberRefresh() async {
     Firestore.instance.collection('UserDetails').document('${widget.userName}').snapshots().listen(StoreStart);
  }
  StoreStartRefresh(DocumentSnapshot snapshot) async{
    userInfo = snapshot.data['Name'];
  }
  getTrainName(DocumentSnapshot snapshot) async{
    trainName = snapshot.data['Train_Name'];
  //  print('////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////');
    print(trainName);
  }
}