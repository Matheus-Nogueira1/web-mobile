import 'package:flutter/material.dart';

import 'imc_page.dart';
import 'temperatura_page.dart';
import 'media_page.dart';
import 'adivinhe_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  Widget menuCard(
    BuildContext context,
    String titulo,
    IconData icone,
    Widget pagina,
  ) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFDBEAFE),
          child: Icon(
            icone,
            color: const Color(0xFF2563EB),
          ),
        ),
        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => pagina,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atividade Flutter'),
      ),
      body: SafeArea(
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Icon(
            Icons.flutter_dash,
            size: 90,
            color: Color(0xFF2563EB),
          ),

          const SizedBox(height: 10),

          const Text(
            'Widgets e Eventos',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          menuCard(
            context,
            'Calculadora IMC',
            Icons.monitor_weight,
            const ImcPage(),
          ),

          menuCard(
            context,
            'Conversor de Temperatura',
            Icons.thermostat,
            const TemperaturaPage(),
          ),

          menuCard(
            context,
            'Média Escolar',
            Icons.school,
            const MediaPage(),
          ),

          menuCard(
            context,
            'Adivinhe o Número',
            Icons.casino,
            const AdivinhePage(),
          ),
        ],
      ),
    ),
  ),
),
    );
  }
}