import 'dart:convert';

import 'package:car_washing_app/model/client.dart';
import 'package:car_washing_app/model/service.dart';
import 'package:car_washing_app/utils/string_utils.dart';
import 'package:car_washing_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientBaseScreen extends StatefulWidget {
  @override
  _ClientBaseScreenState createState() => _ClientBaseScreenState();
}

class _ClientBaseScreenState extends State<ClientBaseScreen> {
  List<Client> _clientList = [];

  @override
  void initState() {
    super.initState();
    _reloadList();
  }

  _reloadList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(CLIENT_BASE_KEY);
    if (data != null) {
      setState(() {
        var objs = jsonDecode(data) as List;
        _clientList = objs.map((e) => Client.fromJson(e)).toList();
        _clientList.sort((a, b) => a.name.compareTo(b.name));
      });
    }
  }

  _deleteItem(int index) async {
    var currentClient = _clientList[index];
    setState(() {
      _clientList.removeAt(index);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(CLIENT_BASE_KEY, jsonEncode(_clientList));

    var data = prefs.getString(WASH_SERVICE_LIST_KEY);
    if (data != null) {
      var objs = jsonDecode(data) as List;
      var serviceList = objs.map((e) => WashService.fromJson(e)).toList();

      var elementToRemove = serviceList.firstWhere(
        (element) => element.client.name == currentClient.name,
        orElse: () => null,
      );
      if (elementToRemove != null) {
        serviceList.remove(elementToRemove);
      }
      prefs.setString(WASH_SERVICE_LIST_KEY, jsonEncode(serviceList));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("lista de clientes"),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_clientList[index].name),
              subtitle: Text(_clientList[index].phone),
              onLongPress: () => showAlertDialog(context,
                  title: "confimar",
                  content: "deseja excluir esse cliente?",
                  confirmFunction: _deleteItem,
                  index: index),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: _clientList.length),
    );
  }
}
