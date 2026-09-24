import 'package:all_br_forms/all_br_forms.dart';
import 'package:all_br_validations/all_br_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class Exercicio1Funcionario extends StatefulWidget {
	const Exercicio1Funcionario({super.key});

	@override
	State<Exercicio1Funcionario> createState() =>
		_Exercicio1FuncionarioState();
}

class _Exercicio1FuncionarioState extends State<Exercicio1Funcionario> {
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	final nomeController = TextEditingController();
	final cpfController = TextEditingController();
	final idadeController = TextEditingController();
	final salarioController = TextEditingController();
	final dependentesController = TextEditingController();

	final NumberFormat moeda = NumberFormat.currency(
		locale: 'pt_BR',
		symbol: 'R\$',
	);

	@override
	void dispose() {
		nomeController.dispose();
		cpfController.dispose();
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

	double? obterSalario() {
		String texto = salarioController.text
			.replaceAll('R\$', '')
			.replaceAll('.', '')
			.replaceAll(',', '.')
			.trim();

		return double.tryParse(texto);
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
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe o nome.',
									),
									Validatorless.min(
										3,
										'O nome deve possuir no mínimo 3 caracteres.',
									),
									Validatorless.max(
										60,
										'O nome deve possuir no máximo 60 caracteres.',
									),
								]),
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: cpfController,
								keyboardType: TextInputType.number,
								inputFormatters: const [
									CpfMask(),
								],
								decoration: const InputDecoration(
									labelText: 'CPF',
									hintText: '000.000.000-00',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.badge),
								),
								validator: BrZod()
									.required('Informe o CPF.')
									.cpf('Informe um CPF válido.')
									.build,
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: idadeController,
								keyboardType: TextInputType.number,
								inputFormatters: [
									FilteringTextInputFormatter.digitsOnly,
								],
								decoration: const InputDecoration(
									labelText: 'Idade',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.cake),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe a idade.',
									),
									Validatorless.number(
										'A idade deve ser um número.',
									),
									Validatorless.numbersBetweenInterval(
										18,
										100,
										'A idade deve estar entre 18 e 100 anos.',
									),
								]),
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: salarioController,
								keyboardType:
									const TextInputType.numberWithOptions(
										decimal: true,
									),
								inputFormatters: const [
									CurrencyMask(),
								],
								decoration: const InputDecoration(
									labelText: 'Salário',
									hintText: 'R\$ 1.000,00',
									border: OutlineInputBorder(),
									prefixIcon: Icon(
										Icons.attach_money,
									),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe o salário.',
									),
									Validatorless.regex(
										RegExp(
											r'^R\$\s?[\d.]+,\d{2}$',
										),
										'Informe o salário no formato de moeda.',
									),
									(value) {
										final salario = obterSalario();

										if (salario == null) {
											return 'Informe um salário válido.';
										}

										if (salario < 1000 ||
											salario > 50000) {
											return 'O salário deve estar entre R\$ 1.000,00 e R\$ 50.000,00.';
										}

										return null;
									},
								]),
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: dependentesController,
								keyboardType: TextInputType.number,
								inputFormatters: [
									FilteringTextInputFormatter.digitsOnly,
								],
								decoration: const InputDecoration(
									labelText: 'Quantidade de dependentes',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.group),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe a quantidade de dependentes.',
									),
									Validatorless.number(
										'Informe um número inteiro.',
									),
									Validatorless.numbersBetweenInterval(
										0,
										10,
										'A quantidade deve estar entre 0 e 10.',
									),
								]),
							),

							const SizedBox(height: 20),

							SizedBox(
								width: double.infinity,
								height: 50,
								child: ElevatedButton(
									onPressed: salvar,
									child: const Text(
										'Salvar funcionário',
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