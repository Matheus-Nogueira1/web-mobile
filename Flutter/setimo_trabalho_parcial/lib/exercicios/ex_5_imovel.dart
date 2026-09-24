import 'package:flutter/material.dart';

class Exercicio5Imovel extends StatefulWidget {
	const Exercicio5Imovel({super.key});

	@override
	State<Exercicio5Imovel> createState() => _Exercicio5ImovelState();
}

class _Exercicio5ImovelState extends State<Exercicio5Imovel> {
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	final TextEditingController enderecoController = TextEditingController();
	final TextEditingController numeroController = TextEditingController();
	final TextEditingController areaController = TextEditingController();
	final TextEditingController valorController = TextEditingController();

	@override
	void dispose() {
		enderecoController.dispose();
		numeroController.dispose();
		areaController.dispose();
		valorController.dispose();
		super.dispose();
	}

	void salvar() {
		if (_formKey.currentState!.validate()) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(
					content: Text(
						'Imóvel cadastrado com sucesso.',
					),
				),
			);
		}
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
								controller: enderecoController,
								decoration: const InputDecoration(
									labelText: 'Endereço',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.location_on),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o endereço.';
									}

									if (texto.length < 5 ||
										texto.length > 100) {
										return 'O endereço deve ter entre 5 e 100 caracteres.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: numeroController,
								keyboardType: TextInputType.number,
								decoration: const InputDecoration(
									labelText: 'Número',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.numbers),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o número.';
									}

									int? numero = int.tryParse(texto);

									if (numero == null) {
										return 'O número deve ser inteiro.';
									}

									if (numero < 1 || numero > 99999) {
										return 'O número deve estar entre 1 e 99.999.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: areaController,
								keyboardType:
									const TextInputType.numberWithOptions(
								decimal: true,
							),
								decoration: const InputDecoration(
									labelText: 'Área (m²)',
									hintText: 'Ex: 85,50',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.square_foot),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe a área.';
									}

									RegExp formato =
										RegExp(r'^\d+([.,]\d{1,2})?$');

									if (!formato.hasMatch(texto)) {
										return 'Informe uma área válida com no máximo 2 casas decimais.';
									}

									double? area = double.tryParse(
										texto.replaceAll(',', '.'),
									);

									if (area == null) {
										return 'Informe uma área válida.';
									}

									if (area < 10 || area > 10000) {
										return 'A área deve estar entre 10 e 10.000 m².';
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
									labelText: 'Valor do imóvel',
									hintText: 'Ex: 350000,00',
									border: OutlineInputBorder(),
									prefixIcon:
										Icon(Icons.attach_money),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o valor do imóvel.';
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

									if (valor < 20000 ||
										valor > 10000000) {
										return 'O valor deve estar entre R\$ 20.000,00 e R\$ 10.000.000,00.';
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
										'Cadastrar imóvel',
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