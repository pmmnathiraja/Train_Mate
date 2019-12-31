import 'package:flutter/material.dart';
import './src/screens/Dashboard.dart';
import './src/screens/ProductPage.dart';


class CanteenControl extends StatelessWidget {
  final String _userName;
  CanteenControl(this._userName): super();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fryo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Dashboard('$_userName',pageTitle: 'Welcome'),
      routes: <String, WidgetBuilder> {
        '/dashboard': (BuildContext context) => Dashboard('$_userName'),
        '/productPage': (BuildContext context) => ProductPage(),
      },
    );
  }
}
