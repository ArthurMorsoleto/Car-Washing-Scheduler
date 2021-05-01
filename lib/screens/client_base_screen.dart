import 'dart:convert';

import 'package:car_washing_app/model/client.dart';
import 'package:car_washing_app/utils/utils.dart';
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
      });
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
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: _clientList.length),
    );
  }
}
