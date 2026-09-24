import 'package:flutter/material.dart';

class Exercicio4Curso extends StatefulWidget {
	const Exercicio4Curso({super.key});

	@override
	State<Exercicio4Curso> createState() => _Exercicio4CursoState();
}

class _Exercicio4CursoState extends State<Exercicio4Curso> {
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

	final TextEditingController nomeController = TextEditingController();
	final TextEditingController codigoController = TextEditingController();
	final TextEditingController cargaController = TextEditingController();
	final TextEditingController vagasController = TextEditingController();

	@override
	void dispose() {
		nomeController.dispose();
		codigoController.dispose();
		cargaController.dispose();
		vagasController.dispose();
		super.dispose();
	}

	void salvar() {
		if (_formKey.currentState!.validate()) {
			ScaffoldMessenger.of(context).showSnackBar(
				const SnackBar(
					content: Text(
						'Curso cadastrado com sucesso.',
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
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o nome do curso.';
									}

									if (texto.length < 5 ||
										texto.length > 100) {
										return 'O nome deve ter entre 5 e 100 caracteres.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: codigoController,
								textCapitalization:
									TextCapitalization.characters,
								decoration: const InputDecoration(
									labelText: 'Código do curso',
									hintText: 'Ex: ADS-2026',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.code),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o código do curso.';
									}

									RegExp formato =
										RegExp(r'^[A-Za-z]{3}-\d{4}$');

									if (!formato.hasMatch(texto)) {
										return 'Use o formato CUR-1234.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: cargaController,
								keyboardType: TextInputType.number,
								decoration: const InputDecoration(
									labelText: 'Carga horária',
									hintText: 'Ex: 120',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.schedule),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe a carga horária.';
									}

									int? carga = int.tryParse(texto);

									if (carga == null) {
										return 'A carga horária deve ser um número inteiro.';
									}

									if (carga < 20 || carga > 2000) {
										return 'A carga horária deve estar entre 20 e 2.000 horas.';
									}

									return null;
								},
							),
							const SizedBox(height: 15),
							TextFormField(
								controller: vagasController,
								keyboardType: TextInputType.number,
								decoration: const InputDecoration(
									labelText: 'Número de vagas',
									hintText: 'Ex: 40',
									border: OutlineInputBorder(),
									prefixIcon: Icon(Icons.people),
								),
								validator: (value) {
									String texto = value!.trim();

									if (texto.isEmpty) {
										return 'Informe o número de vagas.';
									}

									int? vagas = int.tryParse(texto);

									if (vagas == null) {
										return 'O número de vagas deve ser inteiro.';
									}

									if (vagas < 1 || vagas > 500) {
										return 'As vagas devem estar entre 1 e 500.';
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
										'Cadastrar curso',
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