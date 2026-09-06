import 'package:flutter/material.dart';

class CadastroAluno extends StatefulWidget {
	const CadastroAluno({super.key});

	@override
	State<CadastroAluno> createState() => _CadastroAlunoState();
}

class _CadastroAlunoState extends State<CadastroAluno> {
	final TextEditingController nomeController = TextEditingController();
	final TextEditingController idadeController = TextEditingController();
	final TextEditingController emailController = TextEditingController();

	String mensagem = '';
	bool sucesso = false;

	@override
	void dispose() {
		nomeController.dispose();
		idadeController.dispose();
		emailController.dispose();
		super.dispose();
	}

	void salvar() {
		String nome = nomeController.text.trim();
		String idadeTexto = idadeController.text.trim();
		String email = emailController.text.trim();

		String erro = '';

		if (nome.isEmpty) {
			erro = 'Informe o nome.';
		} else if (nome.length < 3 || nome.length > 50) {
			erro = 'O nome deve ter entre 3 e 50 caracteres.';
		} else if (idadeTexto.isEmpty) {
			erro = 'Informe a idade.';
		} else {
			int? idade = int.tryParse(idadeTexto);

			if (idade == null) {
				erro = 'A idade deve ser um número inteiro.';
			} else if (idade < 10 || idade > 100) {
				erro = 'A idade deve estar entre 10 e 100 anos.';
			}
		}

		if (erro.isEmpty) {
			if (email.isEmpty) {
				erro = 'Informe o e-mail.';
			} else if (!email.contains('@')) {
				erro = 'O e-mail deve conter @.';
			}
		}

		setState(() {
			if (erro.isEmpty) {
				mensagem = 'Aluno salvo com sucesso';
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
						color: Colors.teal.shade700,
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
							'assets/fundo_aluno.jpg',
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
												Icons.school_rounded,
												size: 58,
												color: Color(0xFF00796B),
											),
											const SizedBox(height: 10),
											const Text(
												'Cadastro de Aluno',
												style: TextStyle(
													fontSize: 26,
													fontWeight: FontWeight.bold,
													color: Color(0xFF202438),
												),
											),
											const SizedBox(height: 22),
											campo(
												'Nome',
												Icons.person_outline,
												nomeController,
											),
											campo(
												'Idade',
												Icons.cake_outlined,
												idadeController,
												teclado: TextInputType.number,
											),
											campo(
												'E-mail',
												Icons.email_outlined,
												emailController,
												teclado:
													TextInputType.emailAddress,
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
														'Salvar aluno',
														style: TextStyle(
															fontSize: 16,
															fontWeight:
																FontWeight.bold,
														),
													),
													style: ElevatedButton.styleFrom(
														backgroundColor:
															const Color(
																0xFF00796B,
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