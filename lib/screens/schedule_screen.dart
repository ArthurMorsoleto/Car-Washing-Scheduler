import 'dart:convert';

import 'package:car_washing_app/model/service.dart';
import 'package:car_washing_app/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
TODO Implementar a lógica para exibir a lista com a agenda dos
 serviços (wireframe 5), essa lista possuirá uma função para concluir o serviço ao selecionar o item da lista

TODO essa tela terá a lista de serviços agendados em ordem crescente da data de agendamento.
 Ao selecionar um serviço, deverá ser apresentada para o usuário a opção de concluir o serviço (excluir da agenda).
*/

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
        _washServiceList.sort((a,b) => a.dateTime.compareTo(b.dateTime));
      });
    }
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
                    '${_washServiceList[index].dateTime} - ${_washServiceList[index].serviceType}'));
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: _washServiceList.length),
    );
  }
}
