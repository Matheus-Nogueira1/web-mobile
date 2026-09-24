import 'package:all_br_forms/all_br_forms.dart';
import 'package:all_br_validations/all_br_validations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class Exercicio2Cliente extends StatefulWidget {
	const Exercicio2Cliente({super.key});

	@override
	State<Exercicio2Cliente> createState() => _Exercicio2ClienteState();
}

class _Exercicio2ClienteState extends State<Exercicio2Cliente> {
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	final nomeController = TextEditingController();
	final cpfController = TextEditingController();
	final emailController = TextEditingController();
	final telefoneController = TextEditingController();
	final nascimentoController = TextEditingController();

	final DateFormat formatoData = DateFormat(
		'dd/MM/yyyy',
		'pt_BR',
	);

	@override
	void dispose() {
		nomeController.dispose();
		cpfController.dispose();
		emailController.dispose();
		telefoneController.dispose();
		nascimentoController.dispose();
		super.dispose();
	}

	void salvar() {
		if (_formKey.currentState!.validate()) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(
					content: Text(
						'Cliente cadastrado com sucesso',
					),
				),
			);
		}
	}

	String? validarMaioridade(String? value) {
		if (value == null || value.trim().isEmpty) {
			return 'Informe a data de nascimento.';
		}

		try {
			final data = formatoData.parseStrict(value.trim());
			final hoje = DateTime.now();

			int idade = hoje.year - data.year;

			if (hoje.month < data.month ||
				(hoje.month == data.month &&
					hoje.day < data.day)) {
				idade--;
			}

			if (idade < 18) {
				return 'O cliente deve possuir pelo menos 18 anos.';
			}

			return null;
		} catch (_) {
			return 'Informe uma data válida no formato dd/MM/yyyy.';
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Cadastro de Cliente'),
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
								controller: nascimentoController,
								keyboardType: TextInputType.datetime,
								inputFormatters: const [
									DateMask(),
								],
								decoration: const InputDecoration(
									labelText: 'Data de nascimento',
									hintText: 'dd/MM/yyyy',
									border: OutlineInputBorder(),
									prefixIcon:
										Icon(Icons.calendar_today),
								),
								validator: validarMaioridade,
							),

							const SizedBox(height: 20),

							SizedBox(
								width: double.infinity,
								height: 50,
								child: ElevatedButton(
									onPressed: salvar,
									child: const Text(
										'Cadastrar cliente',
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