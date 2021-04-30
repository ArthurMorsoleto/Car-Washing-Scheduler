import 'package:flutter/material.dart';

class ClientBaseScreen extends StatefulWidget {
  @override
  _ClientBaseScreenState createState() => _ClientBaseScreenState();
}

class _ClientBaseScreenState extends State<ClientBaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("lista de clientes"),
        centerTitle: true,
      ),
    );
  }
}
