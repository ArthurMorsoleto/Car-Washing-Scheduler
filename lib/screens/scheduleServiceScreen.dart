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
        title: Text("agendar servico"),
        centerTitle: true,
      ),
    );
  }
}
