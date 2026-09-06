import 'package:flutter/material.dart';

class CadastroFilme extends StatefulWidget {
	const CadastroFilme({super.key});

	@override
	State<CadastroFilme> createState() => _CadastroFilmeState();
}

class _CadastroFilmeState extends State<CadastroFilme> {
	final TextEditingController nomeController = TextEditingController();
	final TextEditingController dataController = TextEditingController();
	final TextEditingController duracaoController = TextEditingController();

	String mensagem = '';
	bool sucesso = false;

	@override
	void dispose() {
		nomeController.dispose();
		dataController.dispose();
		duracaoController.dispose();
		super.dispose();
	}

	void salvar() {
		String nome = nomeController.text.trim();
		String data = dataController.text.trim();
		String duracaoTexto = duracaoController.text.trim();

		String erro = '';

		if (nome.isEmpty) {
			erro = 'Informe o nome do filme.';
		} else if (nome.length < 2 || nome.length > 100) {
			erro = 'O nome deve ter entre 2 e 100 caracteres.';
		} else if (data.isEmpty) {
			erro = 'Informe a data.';
		} else if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(data)) {
			erro = 'A data deve estar no formato DD/MM/AAAA.';
		} else if (duracaoTexto.isEmpty) {
			erro = 'Informe a duração.';
		} else {
			int? duracao = int.tryParse(duracaoTexto);

			if (duracao == null) {
				erro = 'A duração deve ser um número inteiro.';
			} else if (duracao < 1 || duracao > 500) {
				erro = 'A duração deve estar entre 1 e 500 minutos.';
			}
		}

		setState(() {
			if (erro.isEmpty) {
				mensagem = 'Filme salvo com sucesso';
				sucesso = true;
			} else {
				mensagem = erro;
				sucesso = false;
			}
		});
	}

	Widget campo(
		String label,
		IconData icone,
		TextEditingController controller, {
		TextInputType teclado = TextInputType.text,
	}) {
		return Padding(
			padding: const EdgeInsets.only(bottom: 14),
			child: TextField(
				controller: controller,
				keyboardType: teclado,
				decoration: InputDecoration(
					labelText: label,
					prefixIcon: Icon(
						icone,
						color: Colors.deepPurple.shade700,
					),
					filled: true,
					fillColor: Colors.white.withOpacity(0.72),
					border: OutlineInputBorder(
						borderRadius: BorderRadius.circular(14),
						borderSide: BorderSide.none,
					),
				),
			),
		);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Stack(
				children: [
					Positioned.fill(
						child: Image.asset(
							'assets/fundo_filme.jpg',
							fit: BoxFit.cover,
						),
					),
					Positioned.fill(
						child: Container(
							color: Colors.black.withOpacity(0.35),
						),
					),
					SafeArea(
						child: Center(
							child: SingleChildScrollView(
								padding: const EdgeInsets.all(20),
								child: Container(
									constraints:
										const BoxConstraints(maxWidth: 550),
									padding: const EdgeInsets.all(24),
									decoration: BoxDecoration(
										color: Colors.white.withOpacity(0.82),
										borderRadius:
											BorderRadius.circular(22),
										boxShadow: [
											BoxShadow(
												color: Colors.black
													.withOpacity(0.22),
												blurRadius: 18,
												offset: const Offset(0, 8),
											),
										],
									),
									child: Column(
										children: [
											const Icon(
												Icons.movie_rounded,
												size: 58,
												color: Color(0xFF6A1B9A),
											),
											const SizedBox(height: 10),
											const Text(
												'Cadastro de Filme',
												style: TextStyle(
													fontSize: 26,
													fontWeight: FontWeight.bold,
													color: Color(0xFF202438),
												),
											),
											const SizedBox(height: 22),
											campo(
												'Nome do filme',
												Icons.movie_outlined,
												nomeController,
											),
											campo(
												'Data (DD/MM/AAAA)',
												Icons.calendar_month,
												dataController,
											),
											campo(
												'Duração em minutos',
												Icons.timer_outlined,
												duracaoController,
												teclado: TextInputType.number,
											),
											SizedBox(
												width: double.infinity,
												height: 52,
												child: ElevatedButton.icon(
													onPressed: salvar,
													icon: const Icon(
														Icons.save_rounded,
													),
													label: const Text(
														'Salvar filme',
														style: TextStyle(
															fontSize: 16,
															fontWeight:
																FontWeight.bold,
														),
													),
													style: ElevatedButton.styleFrom(
														backgroundColor:
															const Color(
																0xFF6A1B9A,
															),
														foregroundColor:
															Colors.white,
														shape:
															RoundedRectangleBorder(
															borderRadius:
																BorderRadius
																	.circular(14),
														),
													),
												),
											),
											if (mensagem.isNotEmpty)
												Padding(
													padding:
														const EdgeInsets.only(
															top: 16,
														),
													child: Text(
														mensagem,
														textAlign:
															TextAlign.center,
														style: TextStyle(
															color: sucesso
																? Colors
																	.green
																	.shade700
																: Colors
																	.red
																	.shade700,
															fontWeight:
																FontWeight.bold,
														),
													),
												),
										],
									),
								),
							),
						),
					),
				],
			),
		);
	}
}