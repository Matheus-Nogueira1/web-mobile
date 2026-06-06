import 'package:flutter/material.dart';

class TemperaturaPage extends StatefulWidget {
  const TemperaturaPage({super.key});

  @override
  State<TemperaturaPage> createState() => _TemperaturaPageState();
}

class _TemperaturaPageState extends State<TemperaturaPage> {
  final temperaturaController = TextEditingController();

  String opcaoSelecionada = 'C→F';
  String resultado = '';

  void converterTemperatura() {
    double temperatura = double.tryParse(
          temperaturaController.text.replaceAll(',', '.'),
        ) ??
        0;

    double convertido;

    if (opcaoSelecionada == 'C→F') {
      convertido = (temperatura * 9 / 5) + 32;

      setState(() {
        resultado =
            '${temperatura.toStringAsFixed(1)} °C = ${convertido.toStringAsFixed(1)} °F';
      });
    } else {
      convertido = (temperatura - 32) * 5 / 9;

      setState(() {
        resultado =
            '${temperatura.toStringAsFixed(1)} °F = ${convertido.toStringAsFixed(1)} °C';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Temperatura'),
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
                      Icons.thermostat,
                      size: 80,
                      color: Color(0xFF2563EB),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Conversor de Temperatura',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),

                    TextField(
                      controller: temperaturaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Temperatura',
                      ),
                    ),

                    const SizedBox(height: 20),

                    DropdownButtonFormField<String>(
                      value: opcaoSelecionada,
                      decoration: const InputDecoration(
                        labelText: 'Conversão',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'C→F',
                          child: Text(
                            'Celsius para Fahrenheit',
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'F→C',
                          child: Text(
                            'Fahrenheit para Celsius',
                          ),
                        ),
                      ],
                      onChanged: (valor) {
                        setState(() {
                          opcaoSelecionada = valor!;
                        });
                      },
                    ),

                    const SizedBox(height: 25),

                    ElevatedButton(
                      onPressed: converterTemperatura,
                      child: const Text('Converter'),
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
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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