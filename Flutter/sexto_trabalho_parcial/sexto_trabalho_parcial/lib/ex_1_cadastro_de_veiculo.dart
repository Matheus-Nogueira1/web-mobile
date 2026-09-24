import 'package:flutter/material.dart';

class CadastroVeiculo extends StatefulWidget {
	const CadastroVeiculo({super.key});

	@override
	State<CadastroVeiculo> createState() => _CadastroVeiculoState();
}

class _CadastroVeiculoState extends State<CadastroVeiculo> {
	final TextEditingController marcaController = TextEditingController();
	final TextEditingController modeloController = TextEditingController();
	final TextEditingController anoController = TextEditingController();
	final TextEditingController precoController = TextEditingController();

	String mensagem = '';
	bool sucesso = false;

	@override
	void dispose() {
		marcaController.dispose();
		modeloController.dispose();
		anoController.dispose();
		precoController.dispose();
		super.dispose();
	}

	void salvar() {
		String marca = marcaController.text.trim();
		String modelo = modeloController.text.trim();
		String anoTexto = anoController.text.trim();
		String precoTexto = precoController.text.trim();

		String erro = '';

		if (marca.isEmpty) {
			erro = 'Informe a marca.';
		} else if (marca.length < 2 || marca.length > 50) {
			erro = 'A marca deve ter entre 2 e 50 caracteres.';
		} else if (modelo.isEmpty) {
			erro = 'Informe o modelo.';
		} else if (modelo.length < 2 || modelo.length > 50) {
			erro = 'O modelo deve ter entre 2 e 50 caracteres.';
		} else if (anoTexto.isEmpty) {
			erro = 'Informe o ano.';
		} else {
			int? ano = int.tryParse(anoTexto);

			if (ano == null) {
				erro = 'O ano deve ser um número inteiro.';
			} else if (ano < 1900 || ano > 2026) {
				erro = 'O ano deve estar entre 1900 e 2026.';
			}
		}

		if (erro.isEmpty) {
			if (precoTexto.isEmpty) {
				erro = 'Informe o preço.';
			} else {
				String precoNormalizado = precoTexto.replaceAll(',', '.');
				double? preco = double.tryParse(precoNormalizado);

				if (preco == null) {
					erro = 'O preço deve ser um número válido.';
				} else if (!RegExp(r'^\d+([,.]\d{1,2})?$').hasMatch(precoTexto)) {
					erro = 'O preço pode ter no máximo 2 casas decimais.';
				} else if (preco < 1000 || preco > 1000000) {
					erro = 'O preço deve estar entre R\$ 1.000 e R\$ 1.000.000.';
				}
			}
		}

		setState(() {
			if (erro.isEmpty) {
				mensagem = 'Veículo salvo com sucesso';
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
					prefixIcon: Icon(icone, color: Colors.blue.shade700),
					filled: true,
					fillColor: Colors.white.withValues(alpha: 0.72),
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
							'assets/fundo_veiculo.jpg',
							fit: BoxFit.cover,
						),
					),
					Positioned.fill(
						child: Container(
							color: Colors.black.withValues(alpha: 0.35),
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
										color: Colors.white.withValues(alpha: 0.82),
										borderRadius:
											BorderRadius.circular(22),
										boxShadow: [
											BoxShadow(
												color: Colors.black
													.withValues(alpha: 0.22),
												blurRadius: 18,
												offset: const Offset(0, 8),
											),
										],
									),
									child: Column(
										children: [
											const Icon(
												Icons.directions_car_rounded,
												size: 58,
												color: Color(0xFF1565C0),
											),
											const SizedBox(height: 10),
											const Text(
												'Cadastro de Veículo',
												style: TextStyle(
													fontSize: 26,
													fontWeight: FontWeight.bold,
													color: Color(0xFF202438),
												),
											),
											const SizedBox(height: 22),
											campo(
												'Marca',
												Icons.branding_watermark,
												marcaController,
											),
											campo(
												'Modelo',
												Icons.directions_car,
												modeloController,
											),
											campo(
												'Ano',
												Icons.calendar_today,
												anoController,
												teclado: TextInputType.number,
											),
											campo(
												'Preço',
												Icons.attach_money,
												precoController,
												teclado:
													const TextInputType
														.numberWithOptions(
													decimal: true,
												),
											),
											const SizedBox(height: 5),
											SizedBox(
												width: double.infinity,
												height: 52,
												child: ElevatedButton.icon(
													onPressed: salvar,
													icon: const Icon(
														Icons.save_rounded,
													),
													label: const Text(
														'Salvar veículo',
														style: TextStyle(
															fontSize: 16,
															fontWeight:
																FontWeight.bold,
														),
													),
													style: ElevatedButton.styleFrom(
														backgroundColor:
															const Color(
																0xFF1565C0,
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