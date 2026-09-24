import 'package:flutter/material.dart';

class Exercicio3Conta extends StatefulWidget {
	const Exercicio3Conta({super.key});

	@override
	State<Exercicio3Conta> createState() => _Exercicio3ContaState();
}

class _Exercicio3ContaState extends State<Exercicio3Conta> {
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	final TextEditingController titularController = TextEditingController();
	final TextEditingController bancoController = TextEditingController();
	final TextEditingController agenciaController = TextEditingController();
	final TextEditingController contaController = TextEditingController();
	final TextEditingController saldoController = TextEditingController();

	@override
	void dispose() {
		titularController.dispose();
		bancoController.dispose();
		agenciaController.dispose();
		contaController.dispose();
		saldoController.dispose();
		super.dispose();
	}

	void salvar() {
		if (_formKey.currentState!.validate()) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(
					content: Text(
						'Conta cadastrada com sucesso.',
					),
				),
			);
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Cadastro de Conta Bancária'),
			),
			body: SingleChildScrollView(
				padding: const EdgeInsets.all(16),
				child: Form(
					key: _formKey,
					child: Column(
						children: [
							TextFormField(
								controller: titularController,
								decoration: const InputDecoration(
									labelText: 'Nome do titular',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.person),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o nome do titular.';
									}

									if (texto.length < 3 ||
										texto.length > 80) {
										return 'O nome deve ter entre 3 e 80 caracteres.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: bancoController,
								keyboardType: TextInputType.number,
								decoration: const InputDecoration(
									labelText: 'Número do banco',
									hintText: 'Ex: 001',
									border: OutlineInputBorder(),
									prefixIcon:
										Icon(Icons.account_balance),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o número do banco.';
									}

									if (!RegExp(r'^\d{3}$')
										.hasMatch(texto)) {
										return 'O banco deve possuir exatamente 3 dígitos.';
									}

									int? banco = int.tryParse(texto);

									if (banco == null) {
										return 'O banco deve ser um número inteiro.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: agenciaController,
								keyboardType: TextInputType.number,
								decoration: const InputDecoration(
									labelText: 'Agência',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.store),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe a agência.';
									}

									if (!RegExp(r'^\d{4,5}$')
										.hasMatch(texto)) {
										return 'A agência deve possuir entre 4 e 5 dígitos.';
									}

									int? agencia = int.tryParse(texto);

									if (agencia == null) {
										return 'A agência deve ser um número inteiro.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: contaController,
								keyboardType: TextInputType.number,
								decoration: const InputDecoration(
									labelText: 'Número da conta',
									border: OutlineInputBorder(),
									prefixIcon:
										Icon(Icons.account_balance_wallet),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o número da conta.';
									}

									if (!RegExp(r'^\d{5,10}$')
										.hasMatch(texto)) {
										return 'A conta deve possuir entre 5 e 10 dígitos.';
									}

									int? conta = int.tryParse(texto);

									if (conta == null) {
										return 'A conta deve ser um número inteiro.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: saldoController,
								keyboardType:
									const TextInputType.numberWithOptions(
								decimal: true,
							),
								decoration: const InputDecoration(
									labelText: 'Saldo inicial',
									hintText: 'Ex: 1500,50',
									border: OutlineInputBorder(),
									prefixIcon:
										Icon(Icons.attach_money),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o saldo inicial.';
									}

									RegExp formato =
										RegExp(r'^\d+([.,]\d{1,2})?$');

									if (!formato.hasMatch(texto)) {
										return 'Informe um valor válido com no máximo 2 casas decimais.';
									}

									double? saldo = double.tryParse(
										texto.replaceAll(',', '.'),
									);

									if (saldo == null) {
										return 'Informe um saldo válido.';
									}

									if (saldo < 0) {
										return 'O saldo não pode ser negativo.';
									}

									if (saldo > 1000000) {
										return 'O saldo máximo é R\$ 1.000.000,00.';
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
										'Cadastrar conta',
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