import 'package:flutter/material.dart';

class CadastroLivro extends StatefulWidget {
	const CadastroLivro({super.key});

	@override
	State<CadastroLivro> createState() => _CadastroLivroState();
}

class _CadastroLivroState extends State<CadastroLivro> {
	final TextEditingController tituloController = TextEditingController();
	final TextEditingController autorController = TextEditingController();
	final TextEditingController paginasController = TextEditingController();
	final TextEditingController codigoController = TextEditingController();

	String mensagem = '';
	bool sucesso = false;

	@override
	void dispose() {
		tituloController.dispose();
		autorController.dispose();
		paginasController.dispose();
		codigoController.dispose();
		super.dispose();
	}

	void salvar() {
		String titulo = tituloController.text.trim();
		String autor = autorController.text.trim();
		String paginasTexto = paginasController.text.trim();
		String codigo = codigoController.text.trim();

		String erro = '';

		if (titulo.isEmpty) {
			erro = 'Informe o título.';
		} else if (titulo.length < 2 || titulo.length > 100) {
			erro = 'O título deve ter entre 2 e 100 caracteres.';
		} else if (autor.isEmpty) {
			erro = 'Informe o autor.';
		} else if (autor.length < 3 || autor.length > 100) {
			erro = 'O autor deve ter entre 3 e 100 caracteres.';
		} else if (paginasTexto.isEmpty) {
			erro = 'Informe o número de páginas.';
		} else {
			int? paginas = int.tryParse(paginasTexto);

			if (paginas == null) {
				erro = 'As páginas devem ser um número inteiro.';
			} else if (paginas < 1 || paginas > 10000) {
				erro = 'O número de páginas deve estar entre 1 e 10.000.';
			}
		}

		if (erro.isEmpty) {
			if (codigo.isEmpty) {
				erro = 'Informe o código.';
			} else if (!RegExp(r'^[A-Za-z]{3}-\d{4}$').hasMatch(codigo)) {
				erro = 'O código deve seguir o formato ABC-1234.';
			}
		}

		setState(() {
			if (erro.isEmpty) {
				mensagem = 'Livro salvo com sucesso';
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
						color: Colors.orange.shade800,
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
							'assets/fundo_livro.jpg',
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
												Icons.menu_book_rounded,
												size: 58,
												color: Color(0xFFE65100),
											),
											const SizedBox(height: 10),
											const Text(
												'Cadastro de Livro',
												style: TextStyle(
													fontSize: 26,
													fontWeight: FontWeight.bold,
													color: Color(0xFF202438),
												),
											),
											const SizedBox(height: 22),
											campo(
												'Título',
												Icons.title,
												tituloController,
											),
											campo(
												'Autor',
												Icons.person_outline,
												autorController,
											),
											campo(
												'Número de páginas',
												Icons.menu_book_outlined,
												paginasController,
												teclado: TextInputType.number,
											),
											campo(
												'Código (ABC-1234)',
												Icons.qr_code_2,
												codigoController,
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
														'Salvar livro',
														style: TextStyle(
															fontSize: 16,
															fontWeight:
																FontWeight.bold,
														),
													),
													style: ElevatedButton.styleFrom(
														backgroundColor:
															const Color(
																0xFFE65100,
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