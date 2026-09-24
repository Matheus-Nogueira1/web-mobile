import 'package:flutter/material.dart';

class Exercicio2Pedido extends StatefulWidget {
	const Exercicio2Pedido({super.key});

	@override
	State<Exercicio2Pedido> createState() => _Exercicio2PedidoState();
}

class _Exercicio2PedidoState extends State<Exercicio2Pedido> {
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	final TextEditingController nomeController = TextEditingController();
	final TextEditingController valorController = TextEditingController();
	final TextEditingController quantidadeController =
		TextEditingController();
	final TextEditingController descontoController =
		TextEditingController();

	@override
	void dispose() {
		nomeController.dispose();
		valorController.dispose();
		quantidadeController.dispose();
		descontoController.dispose();
		super.dispose();
	}

	void salvar() {
		if (_formKey.currentState!.validate()) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(
					content: Text(
						'Pedido salvo com sucesso.',
					),
				),
			);
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Cadastro de Pedido'),
			),
			body: SingleChildScrollView(
				padding: const EdgeInsets.all(16),
				child: Form(
					key: _formKey,
					child: Column(
						children: [
							TextFormField(
								controller: nomeController,
								decoration: const InputDecoration(
									labelText: 'Nome do cliente',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.person),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o nome do cliente.';
									}

									if (texto.length < 3 ||
										texto.length > 60) {
										return 'O nome deve ter entre 3 e 60 caracteres.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: valorController,
								keyboardType:
									const TextInputType.numberWithOptions(
								decimal: true,
							),
								decoration: const InputDecoration(
									labelText: 'Valor do pedido',
									hintText: 'Ex: 150,50',
									border: OutlineInputBorder(),
									prefixIcon:
										Icon(Icons.attach_money),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o valor do pedido.';
									}

									RegExp formato =
										RegExp(r'^\d+([.,]\d{1,2})?$');

									if (!formato.hasMatch(texto)) {
										return 'Informe um valor válido com no máximo 2 casas decimais.';
									}

									double? valor = double.tryParse(
										texto.replaceAll(',', '.'),
									);

									if (valor == null) {
										return 'Informe um valor válido.';
									}

									if (valor < 1 || valor > 99999.99) {
										return 'O valor deve estar entre R\$ 1,00 e R\$ 99.999,99.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: quantidadeController,
								keyboardType: TextInputType.number,
								decoration: const InputDecoration(
									labelText: 'Quantidade de itens',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.shopping_bag),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe a quantidade de itens.';
									}

									int? quantidade =
										int.tryParse(texto);

									if (quantidade == null) {
										return 'A quantidade deve ser um número inteiro.';
									}

									if (quantidade < 1 ||
										quantidade > 100) {
										return 'A quantidade deve estar entre 1 e 100.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: descontoController,
								keyboardType: TextInputType.number,
								decoration: const InputDecoration(
									labelText: 'Percentual de desconto',
									hintText: 'Ex: 10',
									border: OutlineInputBorder(),
									prefixIcon:
										Icon(Icons.percent),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o percentual de desconto.';
									}

									int? desconto =
										int.tryParse(texto);

									if (desconto == null) {
										return 'O desconto deve ser um número inteiro.';
									}

									if (desconto < 0 ||
										desconto > 100) {
										return 'O desconto deve estar entre 0 e 100.';
									}

									return null;
								},
							),
							const SizedBox(height: 20),
							SizedBox(
								width: double.infinity,
								height: 50,
								child: ElevatedButton(
									onPressed: salvar,
									child: const Text(
										'Salvar pedido',
										style: TextStyle(fontSize: 16),
									),
								),
							),
						],
					),
				),
			),
		);
	}
}