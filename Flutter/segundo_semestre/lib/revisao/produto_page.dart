import 'package:flutter/material.dart';

class ProdutoPage extends StatefulWidget {
  const ProdutoPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ProdutoState();
  }
}

class ProdutoState extends State<ProdutoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Produto'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Nome do Produto',
              hintText: 'Ex: Coca Cola 2 litros',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {
              // Ação ao pressionar o botão
            },
            child: Text('Salvar'),
          ),
        ],
      ),
    );
  }
}