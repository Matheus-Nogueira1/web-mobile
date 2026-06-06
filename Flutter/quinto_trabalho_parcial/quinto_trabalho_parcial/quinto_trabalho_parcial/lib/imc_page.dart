import 'package:flutter/material.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();

  String resultado = '';

  void calcularIMC() {
    double peso = double.tryParse(
          pesoController.text.replaceAll(',', '.'),
        ) ??
        0;

    double altura = double.tryParse(
          alturaController.text.replaceAll(',', '.'),
        ) ??
        0;

    if (peso <= 0 || altura <= 0) {
      setState(() {
        resultado = 'Digite valores válidos.';
      });
      return;
    }

    double imc = peso / (altura * altura);

    String classificacao;

    if (imc < 18.5) {
      classificacao = 'Abaixo do peso';
    } else if (imc < 25) {
      classificacao = 'Normal';
    } else if (imc < 30) {
      classificacao = 'Sobrepeso';
    } else {
      classificacao = 'Obesidade';
    }

    setState(() {
      resultado =
          'IMC: ${imc.toStringAsFixed(2)}\nClassificação: $classificacao';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Icon(
                      Icons.monitor_weight,
                      size: 80,
                      color: Color(0xFF2563EB),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Calculadora de IMC',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    TextField(
                      controller: pesoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Peso (kg)',
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: alturaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Altura (m)',
                      ),
                    ),

                    const SizedBox(height: 25),

                    ElevatedButton(
                      onPressed: calcularIMC,
                      child: const Text('Calcular IMC'),
                    ),

                    const SizedBox(height: 25),

                    if (resultado.isNotEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDBEAFE),
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: Text(
                          resultado,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}