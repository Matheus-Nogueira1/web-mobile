import 'package:all_br_forms/all_br_forms.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:intl/intl.dart';

class Exercicio4Curso extends StatefulWidget {
	const Exercicio4Curso({super.key});

	@override
	State<Exercicio4Curso> createState() => _Exercicio4CursoState();
}

class _Exercicio4CursoState extends State<Exercicio4Curso> {
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	final nomeController = TextEditingController();
	final descricaoController = TextEditingController();
	final emailController = TextEditingController();
	final dataController = TextEditingController();
	final vagasController = TextEditingController();
	final mensalidadeController = TextEditingController();

	final DateFormat formatoData = DateFormat(
		'dd/MM/yyyy',
		'pt_BR',
	);

	@override
	void dispose() {
		nomeController.dispose();
		descricaoController.dispose();
		emailController.dispose();
		dataController.dispose();
		vagasController.dispose();
		mensalidadeController.dispose();
		super.dispose();
	}

	double? obterMensalidade() {
		String texto = mensalidadeController.text
			.replaceAll('R\$', '')
			.replaceAll('.', '')
			.replaceAll(',', '.')
			.trim();

		return double.tryParse(texto);
	}

	String? validarDataInicio(String? value) {
		if (value == null || value.trim().isEmpty) {
			return 'Informe a data de início.';
		}

		try {
			final data = formatoData.parseStrict(value.trim());

			final hoje = DateTime.now();

			final dataSemHora = DateTime(
				hoje.year,
				hoje.month,
				hoje.day,
			);

			if (!data.isAfter(dataSemHora)) {
				return 'A data deve ser posterior à data atual.';
			}

			return null;
		} catch (_) {
			return 'Informe uma data válida no formato dd/MM/yyyy.';
		}
	}

	void salvar() {
		if (_formKey.currentState!.validate()) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(
					content: Text(
						'Curso cadastrado com sucesso',
					),
				),
			);
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Cadastro de Curso'),
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
									labelText: 'Nome do curso',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.school),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe o nome do curso.',
									),
									Validatorless.min(
										5,
										'O nome deve possuir no mínimo 5 caracteres.',
									),
									Validatorless.max(
										100,
										'O nome deve possuir no máximo 100 caracteres.',
									),
								]),
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: descricaoController,
								maxLines: 4,
								decoration: const InputDecoration(
									labelText: 'Descrição',
									border: OutlineInputBorder(),
									alignLabelWithHint: true,
									prefixIcon: Icon(Icons.description),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe a descrição.',
									),
									Validatorless.min(
										10,
										'A descrição deve possuir no mínimo 10 caracteres.',
									),
									Validatorless.max(
										500,
										'A descrição deve possuir no máximo 500 caracteres.',
									),
								]),
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: emailController,
								keyboardType: TextInputType.emailAddress,
								decoration: const InputDecoration(
									labelText: 'E-mail do responsável',
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
								controller: dataController,
								keyboardType: TextInputType.datetime,
								inputFormatters: const [
									DateMask(),
								],
								decoration: const InputDecoration(
									labelText: 'Data de início',
									hintText: 'dd/MM/yyyy',
									border: OutlineInputBorder(),
									prefixIcon:
										Icon(Icons.calendar_today),
								),
								validator: validarDataInicio,
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: vagasController,
								keyboardType: TextInputType.number,
								decoration: const InputDecoration(
									labelText: 'Número de vagas',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.people),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe o número de vagas.',
									),
									Validatorless.number(
										'Informe um número inteiro.',
									),
									Validatorless.numbersBetweenInterval(
										1,
										500,
										'O número de vagas deve estar entre 1 e 500.',
									),
								]),
							),

							const SizedBox(height: 15),

							TextFormField(
								controller: mensalidadeController,
								keyboardType:
									const TextInputType.numberWithOptions(
										decimal: true,
									),
								inputFormatters: const [
									CurrencyMask(),
								],
								decoration: const InputDecoration(
									labelText: 'Mensalidade',
									hintText: 'R\$ 50,00',
									border: OutlineInputBorder(),
									prefixIcon:
										Icon(Icons.attach_money),
								),
								validator: Validatorless.multiple([
									Validatorless.required(
										'Informe a mensalidade.',
									),
									Validatorless.regex(
										RegExp(
											r'^R\$\s?[\d.]+,\d{2}$',
										),
										'Informe a mensalidade no formato monetário.',
									),
									(value) {
										final mensalidade =
											obterMensalidade();

										if (mensalidade == null) {
											return 'Informe um valor válido.';
										}

										if (mensalidade < 50 ||
											mensalidade > 10000) {
											return 'A mensalidade deve estar entre R\$ 50,00 e R\$ 10.000,00.';
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
										'Cadastrar curso',
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