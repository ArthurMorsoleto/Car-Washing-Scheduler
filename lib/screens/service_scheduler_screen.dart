import 'package:car_washing_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class ScheduleServiceScreen extends StatefulWidget {
  @override
  _ScheduleServiceScreenState createState() => _ScheduleServiceScreenState();
}

class _ScheduleServiceScreenState extends State<ScheduleServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("agendar serviço"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: buttonStyle,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text("agendar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                    onPressed: () => {})),
          )
        ]),
      ),
    );
  }
}
