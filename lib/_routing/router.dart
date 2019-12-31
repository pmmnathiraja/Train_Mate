import 'package:flutter/material.dart';
import 'package:flutter_train/_routing/routes.dart';
import 'package:flutter_train/views/home.dart';
import 'package:flutter_train/views/landing.dart';
import 'package:flutter_train/views/login.dart';
import 'package:flutter_train/views/register.dart';
import 'package:flutter_train/views/reset_password.dart';
import 'package:flutter_train/views/register.dart';
import 'package:flutter_train/views/reset_password.dart';
import 'package:flutter_train/views/seatClassOne.dart';
import 'package:flutter_train/views/routeSelect.dart';
import 'package:flutter_train/views/qrReader.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case landingViewRoute:
      return MaterialPageRoute(builder: (context) => LandingPage());
  /*  case homeViewRoute:
      return MaterialPageRoute(builder: (context) => HomePage());*/
    case loginViewRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case registerViewRoute:
      return MaterialPageRoute(builder: (context) => RegisterPage());
    case resetPasswordViewRoute:
      return MaterialPageRoute(builder: (context) => ResetPasswordPage());
  /*  case trainViewRoute:
      return MaterialPageRoute(builder: (context) => TrainPage());*/
  /*  case listViewRoute:
      return MaterialPageRoute(builder: (context) => EnterLocationPage());*/
  /*  case timeViewRoute:
      return MaterialPageRoute(builder: (context) => TimePage());*/
   /* case qrReadRoute:
      return MaterialPageRoute(builder: (context) => QrPage());*/
  /*  case chatDetailsViewRoute:
      return MaterialPageRoute(builder: (context) => ChatDetailsPage(userId: settings.arguments));
    case userDetailsViewRoute:
      return MaterialPageRoute(builder: (context) => UserDetailsPage(userId: settings.arguments));*/
      break;
    default:
      return MaterialPageRoute(builder: (context) => LandingPage());
  }
}
