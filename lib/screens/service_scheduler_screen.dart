import 'dart:convert';

import 'package:car_washing_app/model/client.dart';
import 'package:car_washing_app/model/service.dart';
import 'package:car_washing_app/utils/string_utils.dart';
import 'package:car_washing_app/utils/widget_utils.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ServiceType { simpleWash, completeWash, completeWashAndWax }

extension ServiceTypeExtension on ServiceType {
  static const service = {
    ServiceType.simpleWash: 'lavagem simples',
    ServiceType.completeWash: 'lavagem completa s/ cera',
    ServiceType.completeWashAndWax: 'lavagem completa c/ cera',
  };

  String get name => service[this];
}

class ScheduleServiceScreen extends StatefulWidget {
  @override
  _ScheduleServiceScreenState createState() => _ScheduleServiceScreenState();
}

class _ScheduleServiceScreenState extends State<ScheduleServiceScreen> {
  List<Client> _clientList = [];
  Client _selectedClient;
  String _selectedDateTime;
  ServiceType _serviceType = ServiceType.simpleWash;

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

  void _setDateTime(String val) {
    _selectedDateTime = val;
  }

  void _scheduleService() {
    Client client = _selectedClient;
    String dateTime = _selectedDateTime;
    ServiceType serviceType = _serviceType;

    if (client != null && dateTime != null) {
      var washService = WashService(
          client: client, serviceType: serviceType.name, dateTime: dateTime);
      _saveWashService(washService);
    } else {
      showSnackBar(context, "necessário escolher um cliente e um horário");
    }
  }

  bool _checkDateTime(String dateTime) {
    var time = DateTime.parse(dateTime);
    return (time.hour >= 8 && time.hour <= 17);
  }

  Future<void> _saveWashService(WashService washService) async {
    if (_checkDateTime(washService.dateTime)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = prefs.getString(WASH_SERVICE_LIST_KEY);

      List<WashService> washServiceList = [];
      if (data != null) {
        var objs = jsonDecode(data) as List;
        washServiceList = objs.map((e) => WashService.fromJson(e)).toList();
      }

      washServiceList.add(washService);
      prefs.setString(WASH_SERVICE_LIST_KEY, jsonEncode(washServiceList));
      Navigator.pop(context);
    } else {
      showSnackBar(
          context, "horário de funcionamento da empresa: 08:00 às 17:00");
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: DateTimePicker(
                  type: DateTimePickerType.dateTimeSeparate,
                  dateMask: 'dd/MM/yyyy',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: Icon(Icons.event),
                  dateLabelText: "Data",
                  timeLabelText: "Hora",
                  onChanged: (val) => _setDateTime(val),
                  onSaved: (val) => _setDateTime(val),
                ),
              ),
              Column(children: <Widget>[
                ListTile(
                    title: const Text('lavagem simples'),
                    leading: Radio(
                        value: ServiceType.simpleWash,
                        groupValue: _serviceType,
                        onChanged: (ServiceType value) {
                          setState(() {
                            _serviceType = value;
                          });
                        })),
                ListTile(
                    title: const Text('lavagem completa s/ cera'),
                    leading: Radio(
                        value: ServiceType.completeWash,
                        groupValue: _serviceType,
                        onChanged: (ServiceType value) {
                          setState(() {
                            _serviceType = value;
                          });
                        })),
                ListTile(
                    title: const Text('lavagem completa c/ cera'),
                    leading: Radio(
                        value: ServiceType.completeWashAndWax,
                        groupValue: _serviceType,
                        onChanged: (ServiceType value) {
                          setState(() {
                            _serviceType = value;
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
