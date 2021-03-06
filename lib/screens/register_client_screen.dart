import 'dart:convert';

import 'package:car_washing_app/model/client.dart';
import 'package:car_washing_app/utils/string_utils.dart';
import 'package:car_washing_app/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterClientScreen extends StatefulWidget {
  @override
  _RegisterClientScreenState createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
  final _clientNameController = TextEditingController();
  final _clientPhoneController = TextEditingController();
  final key = GlobalKey<ScaffoldState>();

  _inputDecoration(String labelText, [IconData icon]) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Colors.cyan,
        width: 2.0,
      ),
    );

    return InputDecoration(
      labelText: labelText,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      prefixIcon: (icon != null)
          ? Icon(
              icon,
              color: Colors.cyan,
            )
          : null,
      enabledBorder: border,
      focusedBorder: border,
    );
  }

  _saveClient() async {
    var name = _clientNameController.text;
    var phone = _clientPhoneController.text;
    if (name.isEmpty || phone.isEmpty) {
      showSnackBar(context, "ambos os campos devem estar preenchidos");
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = prefs.getString(CLIENT_BASE_KEY);

      List<Client> clientList = [];
      if (data != null) {
        var objs = jsonDecode(data) as List;
        clientList = objs.map((e) => Client.fromJson(e)).toList();
      }

      var _client = Client(name: name, phone: phone);
      clientList.add(_client);
      prefs.setString(CLIENT_BASE_KEY, jsonEncode(clientList));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("cadastro de cliente",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextField(
                  controller: _clientNameController,
                  keyboardType: TextInputType.name,
                  decoration: _inputDecoration("nome", Icons.account_circle)),
            ),
            TextField(
                inputFormatters: [phoneFormatter],
                controller: _clientPhoneController,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration("telefone", Icons.phone_iphone)),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: buttonStyle,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text("salvar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                        onPressed: () => _saveClient())),
              ),
            )
          ],
        ),
      ),
    );
  }
}
