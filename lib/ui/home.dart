import 'package:flutter/material.dart';
import 'result.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetCampos() {
    setState(() {
      pesoController.clear();
      alturaController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetCampos,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person, size: 120, color: Colors.blueAccent),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.blueAccent),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                controller: pesoController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Insira sua altura!";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (m)",
                  labelStyle: TextStyle(color: Colors.blueAccent),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blueAccent, fontSize: 25.0),
                controller: alturaController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Insira sua altura!";
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      _calcularIMC();
                    }
                  },
                  child: Text(
                    "Calcular",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calcularIMC() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text);
    double imc = peso / (altura * altura);

    String resultado;
    String imagem;

    if (imc < 18.6) {
      resultado = "Abaixo do peso (${imc.toStringAsFixed(2)})";
      imagem = "imagens/thin.png";
    } else if (imc >= 18.6 && imc < 24.9) {
      resultado = "Peso ideal (${imc.toStringAsFixed(2)})";
      imagem = "imagens/shape.png";
    } else if (imc >= 24.9 && imc < 29.9) {
      resultado = "Levemente acima do peso (${imc.toStringAsFixed(2)})";
      imagem = "imagens/fat.png";
    } else if (imc >= 29.9 && imc < 34.9) {
      resultado = "Obesidade Grau I (${imc.toStringAsFixed(2)})";
      imagem = "imagens/fat.png";
    } else if (imc >= 34.9 && imc < 39.9) {
      resultado = "Obesidade Grau II (${imc.toStringAsFixed(2)})";
      imagem = "imagens/fat.png";
    } else {
      resultado = "Obesidade Grau III (${imc.toStringAsFixed(2)})";
      imagem = "imagens/fat.png";
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Result(imagem, resultado)),
    );
  }
}
