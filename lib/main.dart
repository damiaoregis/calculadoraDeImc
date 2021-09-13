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
  TextEditingController weinghtController = TextEditingController();
  TextEditingController heinghtController = TextEditingController();

  GlobalKey<FormState>_formkey = GlobalKey<FormState>();
  String _infoText = 'Informe seus dados!';

  void _resetFields(){
    weinghtController.text = '';
    heinghtController.text = '';
    setState(() {
      _infoText = 'Informe seus dados!';
      _formkey = GlobalKey<FormState>();
    });
  }
  void _calculate(){
    setState(() {
      double weinght = double.parse(weinghtController.text);
      double heinght = double.parse(heinghtController.text)/ 100;
      double imc = weinght / (heinght * heinght);
      if(imc < 18.6){
        _infoText = 'Abaixo do peso (${imc.toStringAsPrecision(4)})';
      }else if (imc >= 18.6 && imc < 24.9){
        _infoText = 'Peso ideal (${imc.toStringAsPrecision(4)})';
      }else if(imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levimente acima do peso (${imc.toStringAsPrecision(4)})';
      }else if(imc >= 29.9 && imc < 34.9){
        _infoText = 'Obesidade Grau I(${imc.toStringAsPrecision(4)})';
      }else if(imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade Grau II(${imc.toStringAsPrecision(4)})';
      }else if (imc >= 40.0){
        _infoText = 'Obesidade Grau III(${imc.toStringAsPrecision(4)})';
      }
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key:_formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.green,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Peso (Kg)',
                      labelStyle: TextStyle(color: Colors.green, fontSize: 29.0)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: weinghtController,
                  validator: (valor){
                    if (valor.isEmpty){
                      return"Insira seu peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(color: Colors.green, fontSize: 29.0)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heinghtController,
                  validator: (valor) {
                    if (valor.isEmpty) {
                      return "Insira sua altura";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                      if(_formkey.currentState.validate())
                        _calculate();
                      },
                      child: Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 29.0),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  'info',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 29.0),
                )
              ],
            ),
          ),
        ));
  }
}
