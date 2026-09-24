import 'package:all_br_forms/all_br_forms.dart';
import 'package:all_br_validations/all_br_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validatorless/validatorless.dart';

class Exercicio5Imovel extends StatefulWidget {
	const Exercicio5Imovel({super.key});

	@override
	State<Exercicio5Imovel> createState() => _Exercicio5ImovelState();
}

class _Exercicio5ImovelState extends State<Exercicio5Imovel> {
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	final proprietarioController = TextEditingController();
	final cpfController = TextEditingController();
	final cepController = TextEditingController();
	final enderecoController = TextEditingController();
	final numeroController = TextEditingController();
	final areaController = TextEditingController();
	final valorController = TextEditingController();

	@override
	void dispose() {
		proprietarioController.dispose();
		cpfController.dispose();
		cepController.dispose();
		enderecoController.dispose();
		numeroController.dispose();
		areaController.dispose();
		valorController.dispose();
		super.dispose();
	}

	double? obterNumeroDecimal(String texto) {
		String valor = texto
			.replaceAll('R\$', '')
			.replaceAll('.', '')
			.replaceAll(',', '.')
			.trim();

		return double.tryParse(valor);
	}

	void salvar() {
		if (_formKey.currentState!.validate()) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(
					content: Text(
						'Imóvel cadastrado com sucesso',
					),
				),
			);
		}
	}

	String? validarArea(String? value) {
		if (value == null || value.trim().isEmpty) {
			return 'Informe a área do imóvel.';
		}

		final valor = obterNumeroDecimal(value);

		if (valor == null) {
			return 'Informe uma área válida.';
		}

		if (valor < 10 || valor > 10000) {
			return 'A área deve estar entre 10 e 10.000 m².';
		}

		return null;
	}

	String? validarValor(String? value) {
		if (value == null || value.trim().isEmpty) {
			return 'Informe o valor do imóvel.';
		}

		final valor = obterNumeroDecimal(value);

		if (valor == null) {
			return 'Informe um valor válido.';
		}

		if (valor < 20000 || valor > 10000000) {
			return 'O valor deve estar entre R\$ 20.000,00 e R\$ 10.000.000,00.';
		}

		return null;
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Cadastro de Imóvel'),
			),
			body: SingleChildScrollView(
				padding: const EdgeInsets.all(16),
				child: Form(
					key: _formKey,
					child: Column(
						children: [
							TextFormField(
								controller: proprietarioController,
								decoration: const InputDecoration(
									labelText: 'Nome do proprietário',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.person),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe o nome do proprietário.',
									),
									Validatorless.min(
										3,
										'O nome deve possuir no mínimo 3 caracteres.',
									),
									Validatorless.max(
										80,
										'O nome deve possuir no máximo 80 caracteres.',
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
									labelText: 'CPF do proprietário',
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
								controller: cepController,
								keyboardType: TextInputType.number,
								inputFormatters: const [
									CepMask(),
								],
								decoration: const InputDecoration(
									labelText: 'CEP',
									hintText: '00000-000',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.location_on),
								),
								validator: BrZod()
									.required('Informe o CEP.')
									.cep('Informe um CEP válido.')
									.build,
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: enderecoController,
								decoration: const InputDecoration(
									labelText: 'Endereço',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.home),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe o endereço.',
									),
									Validatorless.min(
										5,
										'O endereço deve possuir no mínimo 5 caracteres.',
									),
									Validatorless.max(
										100,
										'O endereço deve possuir no máximo 100 caracteres.',
									),
								]),
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: numeroController,
								keyboardType: TextInputType.number,
								inputFormatters: [
									FilteringTextInputFormatter.digitsOnly,
								],
								decoration: const InputDecoration(
									labelText: 'Número',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.numbers),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe o número.',
									),
									Validatorless.number(
										'O número deve ser inteiro.',
									),
									Validatorless.numbersBetweenInterval(
										1,
										99999,
										'O número deve estar entre 1 e 99.999.',
									),
								]),
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: areaController,
								keyboardType:
									const TextInputType.numberWithOptions(
										decimal: true,
									),
								decoration: const InputDecoration(
									labelText: 'Área do imóvel (m²)',
									hintText: 'Ex: 85,50',
									border: OutlineInputBorder(),
									prefixIcon:
										Icon(Icons.square_foot),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe a área.',
									),
									Validatorless.regex(
										RegExp(
											r'^\d+([.,]\d{1,2})?$',
										),
										'Use no máximo 2 casas decimais.',
									),
									validarArea,
								]),
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: valorController,
								keyboardType:
									const TextInputType.numberWithOptions(
										decimal: true,
									),
								inputFormatters: const [
									CurrencyMask(),
								],
								decoration: const InputDecoration(
									labelText: 'Valor do imóvel',
									hintText: 'R\$ 20.000,00',
									border: OutlineInputBorder(),
									prefixIcon:
										Icon(Icons.attach_money),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe o valor do imóvel.',
									),
									Validatorless.regex(
										RegExp(
											r'^R\$\s?[\d.]+,\d{2}$',
										),
										'Informe o valor no formato monetário.',
									),
									validarValor,
								]),
							),

							const SizedBox(height: 20),

							SizedBox(
								width: double.infinity,
								height: 50,
								child: ElevatedButton(
									onPressed: salvar,
									child: const Text(
										'Cadastrar imóvel',
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