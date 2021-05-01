import 'dart:convert';

import 'package:car_washing_app/model/client.dart';
import 'package:car_washing_app/utils/string_utils.dart';
import 'package:car_washing_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ServiceType { simpleWash, completeWash, completeWashAndWax }

class ScheduleServiceScreen extends StatefulWidget {
  @override
  _ScheduleServiceScreenState createState() => _ScheduleServiceScreenState();
}

class _ScheduleServiceScreenState extends State<ScheduleServiceScreen> {
  List<Client> _clientList = [];
  Client _selectedClient;
  ServiceType serviceType = ServiceType.simpleWash;

  @override
  void initState() {
    super.initState();
    loadClientList();
  }

  void loadClientList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(CLIENT_BASE_KEY);
    if (data != null) {
      setState(() {
        var objs = jsonDecode(data) as List;
        _clientList = objs.map((e) => Client.fromJson(e)).toList();
      });
    }
  }

  void _setSelectedClient(String value) {
    _selectedClient = _clientList.firstWhere((e) => e.name == value);
  }

  void _scheduleService() {
    if (_selectedClient != null) {
      debugPrint(_selectedClient.name);
    } else {
      showSnackBar(context, "necessário escolher um cliente");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("agendar serviço"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.max, children: [
              DropdownSearch<String>(
                mode: Mode.DIALOG,
                showSearchBox: true,
                showSelectedItem: true,
                items: _clientList.map((e) => e.name).toList(),
                label: "selecione um cliente",
                onChanged: (value) => _setSelectedClient(value),
              ),
              Column(children: <Widget>[
                ListTile(
                    title: const Text('lavagem simples'),
                    leading: Radio(
                        value: ServiceType.simpleWash,
                        groupValue: serviceType,
                        onChanged: (ServiceType value) {
                          setState(() {
                            serviceType = value;
                          });
                        })),
                ListTile(
                    title: const Text('lavagem completa s/ cera'),
                    leading: Radio(
                        value: ServiceType.completeWash,
                        groupValue: serviceType,
                        onChanged: (ServiceType value) {
                          setState(() {
                            serviceType = value;
                          });
                        })),
                ListTile(
                    title: const Text('lavagem completa c/ cera'),
                    leading: Radio(
                        value: ServiceType.completeWashAndWax,
                        groupValue: serviceType,
                        onChanged: (ServiceType value) {
                          setState(() {
                            serviceType = value;
                          });
                        }))
              ]),
              Expanded(
                child: Align(
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
                          onPressed: () => _scheduleService())),
                ),
              )
            ])));
  }
}
