import 'package:car_washing_app/screens/clientBase.dart';
import 'package:car_washing_app/screens/registerClientScreen.dart';
import 'package:car_washing_app/screens/scheduleScreen.dart';
import 'package:car_washing_app/screens/scheduleServiceScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var buttonStyle = ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.black))));

    Widget homeButton(String buttonText) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
    }

    _navigate(BuildContext context, Widget screen) {
      return Navigator.push(
          context, MaterialPageRoute(builder: (context) => screen));
    }

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.local_car_wash),
        title: Text("CarWashing",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: buttonStyle,
                    child: homeButton("cadastro de clientes"),
                    onPressed: () => _navigate(context, RegisterClientScreen()),
                  )),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: buttonStyle,
                      child: homeButton("agendar serviço"),
                      onPressed: () =>
                          _navigate(context, ScheduleServiceScreen()))),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: buttonStyle,
                      child: homeButton("agenda"),
                      onPressed: () => _navigate(context, ScheduleScreen()))),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: buttonStyle,
                      child: homeButton("lista de clientes"),
                      onPressed: () => _navigate(context, ClientBaseScreen()))),
            ],
          ),
        ),
      ),
    );
  }
}
