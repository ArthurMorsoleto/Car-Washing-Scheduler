import 'package:car_washing_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    home: _introScreen(),
    theme: ThemeData(primarySwatch: Colors.cyan),
  ));
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 2,
        gradientBackground: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.white,
            Colors.cyanAccent,
          ],
        ),
        navigateAfterSeconds: HomeScreen(),
        loaderColor: Colors.transparent,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/logo.png"),
              fit: BoxFit.scaleDown,
              alignment: Alignment.center),
        ),
      ),
    ],
  );
}
