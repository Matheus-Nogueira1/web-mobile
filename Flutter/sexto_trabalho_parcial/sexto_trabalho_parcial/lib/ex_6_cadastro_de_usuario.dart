import 'package:flutter/material.dart';

class CadastroUsuario extends StatefulWidget {
	const CadastroUsuario({super.key});

	@override
	State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
	final TextEditingController nomeController = TextEditingController();
	final TextEditingController emailController = TextEditingController();
	final TextEditingController senhaController = TextEditingController();
	final TextEditingController confirmarSenhaController =
		TextEditingController();

	String mensagem = '';
	bool sucesso = false;

	@override
	void dispose() {
		nomeController.dispose();
		emailController.dispose();
		senhaController.dispose();
		confirmarSenhaController.dispose();
		super.dispose();
	}

	void salvar() {
		String nome = nomeController.text.trim();
		String email = emailController.text.trim();
		String senha = senhaController.text.trim();
		String confirmarSenha = confirmarSenhaController.text.trim();

		String erro = '';

		if (nome.isEmpty) {
			erro = 'Informe o nome.';
		} else if (nome.length < 3 || nome.length > 50) {
			erro = 'O nome deve ter entre 3 e 50 caracteres.';
		} else if (email.isEmpty) {
			erro = 'Informe o e-mail.';
		} else if (!email.contains('@')) {
			erro = 'O e-mail deve conter @.';
		} else {
			int posicaoArroba = email.indexOf('@');
			String depoisDoArroba =
				email.substring(posicaoArroba + 1);

			if (!depoisDoArroba.contains('.')) {
				erro = 'O e-mail deve conter um ponto após o @.';
			}
		}

		if (erro.isEmpty) {
			if (senha.isEmpty) {
				erro = 'Informe a senha.';
			} else if (senha.length < 6 || senha.length > 20) {
				erro = 'A senha deve ter entre 6 e 20 caracteres.';
			} else if (confirmarSenha.isEmpty) {
				erro = 'Confirme a senha.';
			} else if (senha != confirmarSenha) {
				erro = 'As senhas não são iguais.';
			}
		}

		setState(() {
			if (erro.isEmpty) {
				mensagem = 'Usuário cadastrado com sucesso';
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
		bool senha = false,
		TextInputType teclado = TextInputType.text,
	}) {
		return Padding(
			padding: const EdgeInsets.only(bottom: 14),
			child: TextField(
				controller: controller,
				obscureText: senha,
				keyboardType: teclado,
				decoration: InputDecoration(
					labelText: label,
					prefixIcon: Icon(
						icone,
						color: Colors.green.shade700,
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
							'assets/fundo_usuario.jpg',
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
												Icons.person_add_rounded,
												size: 58,
												color: Color(0xFF2E7D32),
											),
											const SizedBox(height: 10),
											const Text(
												'Cadastro de Usuário',
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
												'E-mail',
												Icons.email_outlined,
												emailController,
												teclado:
													TextInputType.emailAddress,
											),
											campo(
												'Senha',
												Icons.lock_outline,
												senhaController,
												senha: true,
											),
											campo(
												'Confirmar senha',
												Icons.lock_reset,
												confirmarSenhaController,
												senha: true,
											),
											SizedBox(
												width: double.infinity,
												height: 52,
												child: ElevatedButton.icon(
													onPressed: salvar,
													icon: const Icon(
														Icons.person_add_rounded,
													),
													label: const Text(
														'Cadastrar usuário',
														style: TextStyle(
															fontSize: 16,
															fontWeight:
																FontWeight.bold,
														),
													),
													style: ElevatedButton.styleFrom(
														backgroundColor:
															const Color(
																0xFF2E7D32,
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