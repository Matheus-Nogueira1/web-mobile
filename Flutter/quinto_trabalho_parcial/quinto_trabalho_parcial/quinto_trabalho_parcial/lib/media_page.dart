import 'package:flutter/material.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  final nota1Controller = TextEditingController();
  final nota2Controller = TextEditingController();
  final recuperacaoController = TextEditingController();

  bool temRecuperacao = false;

  String resultado = '';

  void calcularMedia() {
    double nota1 = double.tryParse(
          nota1Controller.text.replaceAll(',', '.'),
        ) ??
        0;

    double nota2 = double.tryParse(
          nota2Controller.text.replaceAll(',', '.'),
        ) ??
        0;

    double media = (nota1 + nota2) / 2;

    if (temRecuperacao) {
      double recuperacao = double.tryParse(
            recuperacaoController.text.replaceAll(',', '.'),
          ) ??
          0;

      media = (media + recuperacao) / 2;
    }

    String situacao =
        media >= 6 ? '✅ Aprovado' : '❌ Reprovado';

    setState(() {
      resultado =
          'Média Final: ${media.toStringAsFixed(2)}\n$situacao';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Média Escolar'),
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
                      Icons.school,
                      size: 80,
                      color: Color(0xFF2563EB),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Média Escolar',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    TextField(
                      controller: nota1Controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nota 1',
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: nota2Controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nota 2',
                      ),
                    ),

                    const SizedBox(height: 15),

                    CheckboxListTile(
                      value: temRecuperacao,
                      title: const Text(
                        'Tem recuperação?',
                      ),
                      onChanged: (valor) {
                        setState(() {
                          temRecuperacao = valor!;
                        });
                      },
                    ),

                    if (temRecuperacao)
                      TextField(
                        controller:
                            recuperacaoController,
                        keyboardType:
                            TextInputType.number,
                        decoration:
                            const InputDecoration(
                          labelText:
                              'Nota da Recuperação',
                        ),
                      ),

                    const SizedBox(height: 25),

                    ElevatedButton(
                      onPressed: calcularMedia,
                      child:
                          const Text('Calcular Média'),
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