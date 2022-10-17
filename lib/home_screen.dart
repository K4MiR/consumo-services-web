import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _controllerCep = TextEditingController();

  String _resultado = "Resultado";

  _recuperarCep() async {
    String cepDigitado = _controllerCep.text;
    String url = "https://viacep.com.br/ws/${cepDigitado}/json/";
    http.Response response;

    response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];
    String ddd = retorno["ddd"];

    setState(() {
      _resultado =
          "${logradouro}, ${complemento}, ${bairro}, ${localidade}, ${uf}, ${ddd}";
    });

    // print(
    //   "Respota logradouro: ${logradouro}, complemento: ${complemento}, bairro ${bairro}, localidade ${localidade}"
    // );

    //print(response.statusCode.toString());
    //print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de serviço web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            SizedBox(height: 20),
            Lottie.asset("assets/lottie/location.json", width: 200),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite o cep ex: 00900900",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(150),
                ),
              ),
              style: TextStyle(
                fontSize: 15,
              ),
              controller: _controllerCep,
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _recuperarCep,
              child: Text("Clique aqui"),
            ),
            SizedBox(height: 20),
            Text(
              _resultado,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
