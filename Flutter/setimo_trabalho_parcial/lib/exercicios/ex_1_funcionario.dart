import 'package:flutter/material.dart';

class Exercicio1Funcionario extends StatefulWidget {
	const Exercicio1Funcionario({super.key});

	@override
	State<Exercicio1Funcionario> createState() =>
		_Exercicio1FuncionarioState();
}

class _Exercicio1FuncionarioState extends State<Exercicio1Funcionario> {
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	final TextEditingController nomeController = TextEditingController();
	final TextEditingController idadeController = TextEditingController();
	final TextEditingController salarioController = TextEditingController();
	final TextEditingController dependentesController =
		TextEditingController();

	@override
	void dispose() {
		nomeController.dispose();
		idadeController.dispose();
		salarioController.dispose();
		dependentesController.dispose();
		super.dispose();
	}

	void salvar() {
		if (_formKey.currentState!.validate()) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(
					content: Text(
						'Funcionário salvo com sucesso.',
					),
				),
			);
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Cadastro de Funcionário'),
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
									labelText: 'Nome',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.person),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o nome.';
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
								controller: idadeController,
								keyboardType: TextInputType.number,
								decoration: const InputDecoration(
									labelText: 'Idade',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.cake),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe a idade.';
									}

									int? idade = int.tryParse(texto);

									if (idade == null) {
										return 'A idade deve ser um número inteiro.';
									}

									if (idade < 18 || idade > 100) {
										return 'A idade deve estar entre 18 e 100.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: salarioController,
								keyboardType:
									const TextInputType.numberWithOptions(
								decimal: true,
							),
								decoration: const InputDecoration(
									labelText: 'Salário',
									hintText: 'Ex: 3500,50',
									border: OutlineInputBorder(),
									prefixIcon:
										Icon(Icons.attach_money),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o salário.';
									}

									RegExp formato =
										RegExp(r'^\d+([.,]\d{1,2})?$');

									if (!formato.hasMatch(texto)) {
										return 'Informe um valor válido com no máximo 2 casas decimais.';
									}

									String normalizado =
										texto.replaceAll(',', '.');

									double? salario =
										double.tryParse(normalizado);

									if (salario == null) {
										return 'Informe um salário válido.';
									}

									if (salario < 1000 ||
										salario > 50000) {
										return 'O salário deve estar entre R\$ 1.000,00 e R\$ 50.000,00.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: dependentesController,
								keyboardType: TextInputType.number,
								decoration: const InputDecoration(
									labelText: 'Quantidade de dependentes',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.group),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe a quantidade de dependentes.';
									}

									int? dependentes =
										int.tryParse(texto);

									if (dependentes == null) {
										return 'A quantidade deve ser um número inteiro.';
									}

									if (dependentes < 0 ||
										dependentes > 10) {
										return 'A quantidade deve estar entre 0 e 10.';
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
										'Salvar funcionário',
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