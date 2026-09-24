import 'package:all_br_forms/all_br_forms.dart';
import 'package:all_br_validations/all_br_validations.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class Exercicio3Empresa extends StatefulWidget {
	const Exercicio3Empresa({super.key});

	@override
	State<Exercicio3Empresa> createState() => _Exercicio3EmpresaState();
}

class _Exercicio3EmpresaState extends State<Exercicio3Empresa> {
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	final razaoSocialController = TextEditingController();
	final cnpjController = TextEditingController();
	final emailController = TextEditingController();
	final telefoneController = TextEditingController();
	final capitalController = TextEditingController();

	@override
	void dispose() {
		razaoSocialController.dispose();
		cnpjController.dispose();
		emailController.dispose();
		telefoneController.dispose();
		capitalController.dispose();
		super.dispose();
	}

	double? obterCapital() {
		String texto = capitalController.text
			.replaceAll('R\$', '')
			.replaceAll('.', '')
			.replaceAll(',', '.')
			.trim();

		return double.tryParse(texto);
	}

	void salvar() {
		if (_formKey.currentState!.validate()) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(
					content: Text(
						'Empresa cadastrada com sucesso',
					),
				),
			);
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Cadastro de Empresa'),
			),
			body: SingleChildScrollView(
				padding: const EdgeInsets.all(16),
				child: Form(
					key: _formKey,
					child: Column(
						children: [
							TextFormField(
								controller: razaoSocialController,
								decoration: const InputDecoration(
									labelText: 'Razão social',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.business),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe a razão social.',
									),
									Validatorless.min(
										3,
										'A razão social deve possuir no mínimo 3 caracteres.',
									),
									Validatorless.max(
										100,
										'A razão social deve possuir no máximo 100 caracteres.',
									),
								]),
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: cnpjController,
								keyboardType: TextInputType.number,
								inputFormatters: const [
									CnpjMask(),
								],
								decoration: const InputDecoration(
									labelText: 'CNPJ',
									hintText: '00.000.000/0000-00',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.badge),
								),
								validator: BrZod()
									.required('Informe o CNPJ.')
									.cnpj('Informe um CNPJ válido.')
									.build,
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: emailController,
								keyboardType: TextInputType.emailAddress,
								decoration: const InputDecoration(
									labelText: 'E-mail',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.email),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe o e-mail.',
									),
									Validatorless.email(
										'Informe um e-mail válido.',
									),
								]),
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: telefoneController,
								keyboardType: TextInputType.phone,
								inputFormatters: const [
									PhoneMask(),
								],
								decoration: const InputDecoration(
									labelText: 'Telefone',
									hintText: '(11) 99999-9999',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.phone),
								),
								validator: BrZod()
									.required('Informe o telefone.')
									.phone('Informe um telefone válido.')
									.build,
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: capitalController,
								keyboardType:
									const TextInputType.numberWithOptions(
										decimal: true,
									),
								inputFormatters: const [
									CurrencyMask(),
								],
								decoration: const InputDecoration(
									labelText: 'Capital social',
									hintText: 'R\$ 1.000,00',
									border: OutlineInputBorder(),
									prefixIcon:
										Icon(Icons.attach_money),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe o capital social.',
									),
									Validatorless.regex(
										RegExp(
											r'^R\$\s?[\d.]+,\d{2}$',
										),
										'Informe o capital no formato monetário.',
									),
									(value) {
										final capital = obterCapital();

										if (capital == null) {
											return 'Informe um valor válido.';
										}

										if (capital < 1000 ||
											capital > 100000000) {
											return 'O capital deve estar entre R\$ 1.000,00 e R\$ 100.000.000,00.';
										}

										return null;
									},
								]),
							),

							const SizedBox(height: 20),

							SizedBox(
								width: double.infinity,
								height: 50,
								child: ElevatedButton(
									onPressed: salvar,
									child: const Text(
										'Cadastrar empresa',
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