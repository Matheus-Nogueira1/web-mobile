import 'dart:math';

import 'package:flutter/material.dart';

class AdivinhePage extends StatefulWidget {
  const AdivinhePage({super.key});

  @override
  State<AdivinhePage> createState() =>
      _AdivinhePageState();
}

class _AdivinhePageState extends State<AdivinhePage> {
  final palpiteController = TextEditingController();

  int numeroSecreto =
      Random().nextInt(100) + 1;

  int tentativas = 0;

  String mensagem =
      'Tente adivinhar um número entre 1 e 100';

  void tentar() {
    int palpite =
        int.tryParse(palpiteController.text) ?? 0;

    tentativas++;

    setState(() {
      if (palpite < numeroSecreto) {
        mensagem = '📈 Maior!';
      } else if (palpite > numeroSecreto) {
        mensagem = '📉 Menor!';
      } else {
        mensagem =
            '🎉 Acertou em $tentativas tentativa(s)!';
      }
    });
  }

  void reiniciar() {
    setState(() {
      numeroSecreto =
          Random().nextInt(100) + 1;
      tentativas = 0;
      mensagem =
          'Tente adivinhar um número entre 1 e 100';
      palpiteController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivinhe o Número'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Icon(
                      Icons.casino,
                      size: 80,
                      color: Color(0xFF2563EB),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Adivinhe o Número',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    TextField(
                      controller:
                          palpiteController,
                      keyboardType:
                          TextInputType.number,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Digite seu palpite',
                      ),
                    ),

                    const SizedBox(height: 25),

                    ElevatedButton(
                      onPressed: tentar,
                      child:
                          const Text('Tentar'),
                    ),

                    const SizedBox(height: 15),

                    OutlinedButton(
                      onPressed: reiniciar,
                      child:
                          const Text('Novo Jogo'),
                    ),

                    const SizedBox(height: 25),

                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFFDBEAFE),
                        borderRadius:
                            BorderRadius.circular(
                                12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            mensagem,
                            textAlign:
                                TextAlign.center,
                            style:
                                const TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                              height: 10),
                          Text(
                            'Tentativas: $tentativas',
                            style:
                                const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
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