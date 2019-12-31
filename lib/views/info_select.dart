import 'package:flutter/material.dart';
import 'package:flutter_train/_routing/routes.dart';
import 'package:flutter_train/canteenControl.dart';
import 'package:flutter_train/utils/colors.dart';
import 'package:flutter_train/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_train/views/Location.dart';
import 'package:flutter_train/views/emergency.dart';
import 'package:flutter_train/views/routeSelect.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

class InfoSelectPage extends StatelessWidget {
  final String _userName;
  InfoSelectPage(this._userName): super();
  @override
  Widget build(BuildContext context) {
    // Change Status Bar Color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: primaryColor),
    );

    final logo = Container(
      height: 100.0,
      width: 100.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AvailableImages.appLogo,
          fit: BoxFit.cover,
        ),
      ),
    );

    final appName = Column(
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
            fontSize: 25.0,
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );

    final bookBtn = Container(
      height: 85.0,
      width: 85.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => EnterLocationPage("$_userName"))),

        color: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(7.0),
        ),
        child:Icon(LineIcons.search),
      ),
    );

    final locationBtn = Container(
      height: 85.0,
      width: 85.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: RaisedButton(
        elevation: 5.0,
        onPressed:() => Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => CanteenControl('$_userName'))),
    color: Colors.white,
          shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(7.0),
        ),
        child: Icon(FontAwesomeIcons.apple),
      ),
    );
    final timeTableBtn = Container(
      height: 85.0,
      width: 85.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () =>  Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => EmergencyPage('$_userName'))),
        color: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(7.0),
        ),
        child: Icon(LineIcons.times),
      ),
    );

    final infoBtn = Container(
      height: 85.0,
      width: 85.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () =>  Navigator.push((context),MaterialPageRoute(builder: (BuildContext context) => MapPage())),
          color: Colors.white,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0),
          ),
          child: Icon(LineIcons.location_arrow),
        ), // RaisedButton(onPressed: _scanPhoto, child: Text("Scan Photo")),/ RaisedButton(onPressed: _generateBarCode, child: Text("Generate Barcode
    );
      /*child: RaisedButton(

        elevation: 5.0,
        onPressed: () => Navigator.pushNamed(context, trainViewRoute),
        color: Colors.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(7.0),
        ),
        child: Text(
          'Info',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),

        ),

      ),*/

    final buttonsSet01 = Padding(
      padding: EdgeInsets.only(
        top: 50.0,
        bottom: 10.0,
        left: 30.0,
        right: 30.0,
      ),
      child: Row(
        children: <Widget>[SizedBox(width: 65.0),bookBtn, SizedBox(width: 50.0), locationBtn],
      ),
    );
    final buttonsSet02 = Padding(
      padding: EdgeInsets.only(
        top: 30.0,
        bottom: 30.0,
        left: 30.0,
        right: 30.0,
      ),
      child: Row(
        children: <Widget>[SizedBox(width: 65.0),timeTableBtn, SizedBox(width: 50.0), infoBtn],
      ),
    );

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 70.0),
              decoration: BoxDecoration(gradient: primaryGradient),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[appName,logo,buttonsSet01,buttonsSet02],
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
    );
  }
}
