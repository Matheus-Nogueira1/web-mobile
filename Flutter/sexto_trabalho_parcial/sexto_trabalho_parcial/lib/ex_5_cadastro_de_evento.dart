import 'package:flutter/material.dart';

class CadastroEvento extends StatefulWidget {
	const CadastroEvento({super.key});

	@override
	State<CadastroEvento> createState() => _CadastroEventoState();
}

class _CadastroEventoState extends State<CadastroEvento> {
	final TextEditingController nomeController = TextEditingController();
	final TextEditingController quantidadeMinController =
		TextEditingController();
	final TextEditingController quantidadeMaxController =
		TextEditingController();
	final TextEditingController valorController = TextEditingController();

	String mensagem = '';
	bool sucesso = false;

	@override
	void dispose() {
		nomeController.dispose();
		quantidadeMinController.dispose();
		quantidadeMaxController.dispose();
		valorController.dispose();
		super.dispose();
	}

	void salvar() {
		String nome = nomeController.text.trim();
		String minTexto = quantidadeMinController.text.trim();
		String maxTexto = quantidadeMaxController.text.trim();
		String valorTexto = valorController.text.trim();

		String erro = '';

		int? quantidadeMin;
		int? quantidadeMax;

		if (nome.isEmpty) {
			erro = 'Informe o nome do evento.';
		} else if (nome.length < 5 || nome.length > 100) {
			erro = 'O nome deve ter entre 5 e 100 caracteres.';
		} else if (minTexto.isEmpty) {
			erro = 'Informe a quantidade mínima.';
		} else {
			quantidadeMin = int.tryParse(minTexto);

			if (quantidadeMin == null) {
				erro = 'A quantidade mínima deve ser um número inteiro.';
			} else if (quantidadeMin < 1) {
				erro = 'A quantidade mínima deve ser pelo menos 1.';
			}
		}

		if (erro.isEmpty) {
			if (maxTexto.isEmpty) {
				erro = 'Informe a quantidade máxima.';
			} else {
				quantidadeMax = int.tryParse(maxTexto);

				if (quantidadeMax == null) {
					erro = 'A quantidade máxima deve ser um número inteiro.';
				} else if (quantidadeMax < 1 ||
					quantidadeMax > 50000) {
					erro =
						'A quantidade máxima deve estar entre 1 e 50.000.';
				} else if (quantidadeMin != null &&
					quantidadeMax < quantidadeMin) {
					erro =
						'A quantidade máxima não pode ser menor que a mínima.';
				}
			}
		}

		if (erro.isEmpty) {
			if (valorTexto.isEmpty) {
				erro = 'Informe o valor do ingresso.';
			} else {
				String valorNormalizado = valorTexto.replaceAll(',', '.');
				double? valor = double.tryParse(valorNormalizado);

				if (valor == null) {
					erro = 'O valor deve ser um número válido.';
				} else if (!RegExp(r'^\d+([,.]\d{1,2})?$')
					.hasMatch(valorTexto)) {
					erro = 'O valor pode ter no máximo 2 casas decimais.';
				} else if (valor < 0 || valor > 10000) {
					erro = 'O valor deve estar entre R\$ 0 e R\$ 10.000.';
				}
			}
		}

		setState(() {
			if (erro.isEmpty) {
				mensagem = 'Evento salvo com sucesso';
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
						color: Colors.pink.shade700,
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
							'assets/fundo_evento.jpg',
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
												Icons.event_rounded,
												size: 58,
												color: Color(0xFFC2185B),
											),
											const SizedBox(height: 10),
											const Text(
												'Cadastro de Evento',
												style: TextStyle(
													fontSize: 26,
													fontWeight: FontWeight.bold,
													color: Color(0xFF202438),
												),
											),
											const SizedBox(height: 22),
											campo(
												'Nome do evento',
												Icons.event,
												nomeController,
											),
											campo(
												'Quantidade mínima',
												Icons.group_outlined,
												quantidadeMinController,
												teclado: TextInputType.number,
											),
											campo(
												'Quantidade máxima',
												Icons.groups_outlined,
												quantidadeMaxController,
												teclado: TextInputType.number,
											),
											campo(
												'Valor do ingresso',
												Icons.attach_money,
												valorController,
												teclado:
													const TextInputType
														.numberWithOptions(
													decimal: true,
												),
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
														'Salvar evento',
														style: TextStyle(
															fontSize: 16,
															fontWeight:
																FontWeight.bold,
														),
													),
													style: ElevatedButton.styleFrom(
														backgroundColor:
															const Color(
																0xFFC2185B,
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