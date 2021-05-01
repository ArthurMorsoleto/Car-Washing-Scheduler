import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("agenda"),
        centerTitle: true,
      ),
    );
  }
}
