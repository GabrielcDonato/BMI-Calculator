import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Enter your data!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Enter your data!";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      // ignore: avoid_print
      print(imc);
      if (imc < 18.6) {
        _infoText = "Under weight (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Ideal weight (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "slightly overweight (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesity grade I  (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesity grade II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesity grade III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("BMI Calculator"),
          centerTitle: true,
          backgroundColor: Colors.blue.shade400,
          actions: [
            IconButton(
                onPressed: _resetFields, icon: const Icon(Icons.refresh)),
          ],
        ),
        backgroundColor: Colors.blue.shade100,
        body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10.0, .0, 10.0, 0.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(Icons.fitness_center_outlined,
                          size: 150.0, color: Colors.black45),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Weight (Kg)",
                            labelStyle: TextStyle(color: Colors.black45)),
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 25.0),
                        controller: weightController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your Weight";
                          }
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Height (Cm)",
                            labelStyle: TextStyle(color: Colors.black45)),
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 25.0),
                        controller: heightController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your height";
                          }
                        },
                      ),
                      SizedBox(
                        height: 50.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black45,
                            elevation: 0,
                          ),
                          child: const Text(
                            'Calculate',
                            style: TextStyle(fontSize: 25),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _calculate();
                            }
                          },
                        ),
                      ),
                      Text(
                        _infoText,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 25.0),
                      )
                    ]))));
  }
}
