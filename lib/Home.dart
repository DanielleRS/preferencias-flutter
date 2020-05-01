import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _saveText = "Nada salvo!";
  TextEditingController _controllerCampo = TextEditingController();

  _save() async {
    String typedText = _controllerCampo.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", typedText);

    print("operacao (salvar): $typedText");
  }

  _recover() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _saveText = prefs.getString("name") ?? "Sem valor";
    });

    print("operacao (recuperar): $_saveText");
  }

  _remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("name");

    print("operacao (remover)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manipulação de dados"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            Text(
              _saveText,
              style: TextStyle(
                fontSize: 20
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Digite algo"
              ),
              controller: _controllerCampo,
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Salvar",
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                  onPressed: _save,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Recuperar",
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                  onPressed: _recover,
                ),
                RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Remover",
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                  onPressed: _remove,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
