import 'dart:convert';

import 'package:car_washing_app/model/service.dart';
import 'package:car_washing_app/utils/string_utils.dart';
import 'package:car_washing_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  List<WashService> _washServiceList = [];

  @override
  void initState() {
    super.initState();
    _reloadList();
  }

  _reloadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(WASH_SERVICE_LIST_KEY);
    if (data != null) {
      setState(() {
        var objs = jsonDecode(data) as List;
        _washServiceList = objs.map((e) => WashService.fromJson(e)).toList();
        _washServiceList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      });
    }
  }

  _deleteItem(int index) async {
    setState(() {
      _washServiceList.removeAt(index);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(WASH_SERVICE_LIST_KEY, jsonEncode(_washServiceList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("agenda"),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  '${_washServiceList[index].dateTime} - Cliente: ${_washServiceList[index].client.name}'),
              subtitle: Text(_washServiceList[index].serviceType),
              onLongPress: () => showAlertDialog(context,
                  title: "confimar",
                  content: "deseja excluir esse serviço?",
                  confirmFunction: _deleteItem,
                  index: index),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: _washServiceList.length),
    );
  }
}
