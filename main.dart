import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoControler = TextEditingController();
  TextEditingController alturaControler = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados!";

  void _resetFields() {
    pesoControler.text = "";
    alturaControler.text = "";
    setState(() {
      _infoText = "Informe os seus dados!";
      _formkey = GlobalKey<FormState>();
    });
  }

  void _calcular() {
    setState(() {
      double peso = double.parse(pesoControler.text);
      double altura = double.parse(alturaControler.text) / 100;
      double imc = peso / (altura * altura);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 34.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra de cima da tela
        appBar: AppBar(
          title: Text("Calcularoda de IMC"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        //SingleChildScrollView permite que a tela não tenha problema com sobreposição de widgets
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 120,
                    color: Colors.deepPurple,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.deepPurple)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                    controller: pesoControler,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      border: OutlineInputBorder(),
                      labelStyle:
                      TextStyle(color: Colors.deepPurple, fontSize: 25),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 25),
                    controller: alturaControler,
                    validator: (value){
                      if(value.isEmpty){
                        return "insira sua Altura!";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: (){
                          if(_formkey.currentState.validate()){
                            _calcular();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25, color: Colors.deepPurple),
                  )
                ],
              ),
            )));
  }
}
