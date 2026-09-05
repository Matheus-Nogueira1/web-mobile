import 'package:flutter/material.dart';

void main() {
	runApp(const MeuAplicativo());
}

class MeuAplicativo extends StatelessWidget {
	const MeuAplicativo({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Cadastro de Veículo',
			theme: ThemeData(
				colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
				useMaterial3: true,
			),
			home: const CadastroVeiculo(),
		);
	}
}

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

		setState(() {
			mensagem = '';
			sucesso = false;
		});

		// Validação da marca
		if (marca.isEmpty) {
			setState(() {
				mensagem = 'Informe a marca do veículo.';
			});
			return;
		}

		if (marca.length < 2 || marca.length > 50) {
			setState(() {
				mensagem = 'A marca deve possuir entre 2 e 50 caracteres.';
			});
			return;
		}

		// Validação do modelo
		if (modelo.isEmpty) {
			setState(() {
				mensagem = 'Informe o modelo do veículo.';
			});
			return;
		}

		if (modelo.length < 2 || modelo.length > 50) {
			setState(() {
				mensagem = 'O modelo deve possuir entre 2 e 50 caracteres.';
			});
			return;
		}

		// Validação do ano
		if (anoTexto.isEmpty) {
			setState(() {
				mensagem = 'Informe o ano do veículo.';
			});
			return;
		}

		int? ano = int.tryParse(anoTexto);

		if (ano == null) {
			setState(() {
				mensagem = 'O ano deve ser um número inteiro.';
			});
			return;
		}

		if (ano < 1900 || ano > 2026) {
			setState(() {
				mensagem = 'O ano deve estar entre 1900 e 2026.';
			});
			return;
		}

		// Validação do preço
		if (precoTexto.isEmpty) {
			setState(() {
				mensagem = 'Informe o preço do veículo.';
			});
			return;
		}

		// Aceita ponto ou vírgula como separador decimal.
		String precoNormalizado = precoTexto.replaceAll(',', '.');

		// Verifica se possui no máximo duas casas decimais.
		RegExp formatoPreco = RegExp(r'^\d+([.]\d{1,2})?$');

		if (!formatoPreco.hasMatch(precoNormalizado)) {
			setState(() {
				mensagem =
					'O preço deve ser um número válido com no máximo duas casas decimais.';
			});
			return;
		}

		double? preco = double.tryParse(precoNormalizado);

		if (preco == null) {
			setState(() {
				mensagem = 'Informe um preço válido.';
			});
			return;
		}

		if (preco < 1000 || preco > 1000000) {
			setState(() {
				mensagem =
					'O preço deve estar entre R\$ 1.000,00 e R\$ 1.000.000,00.';
			});
			return;
		}

		// Todos os dados estão corretos.
		setState(() {
			mensagem = 'Veículo salvo com sucesso';
			sucesso = true;
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Cadastro de Veículo'),
			),
			body: SingleChildScrollView(
				padding: const EdgeInsets.all(20),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						TextField(
							controller: marcaController,
							decoration: const InputDecoration(
								labelText: 'Marca',
								border: OutlineInputBorder(),
							),
						),

						const SizedBox(height: 16),

						TextField(
							controller: modeloController,
							decoration: const InputDecoration(
								labelText: 'Modelo',
								border: OutlineInputBorder(),
							),
						),

						const SizedBox(height: 16),

						TextField(
							controller: anoController,
							keyboardType: TextInputType.number,
							decoration: const InputDecoration(
								labelText: 'Ano',
								border: OutlineInputBorder(),
							),
						),

						const SizedBox(height: 16),

						TextField(
							controller: precoController,
							keyboardType: const TextInputType.numberWithOptions(
								decimal: true,
							),
							decoration: const InputDecoration(
								labelText: 'Preço',
								prefixText: 'R\$ ',
								border: OutlineInputBorder(),
							),
						),

						const SizedBox(height: 20),

						ElevatedButton(
							onPressed: salvar,
							child: const Text('Salvar'),
						),

						const SizedBox(height: 20),

						if (mensagem.isNotEmpty)
							Text(
								mensagem,
								textAlign: TextAlign.center,
								style: TextStyle(
									fontSize: 16,
									fontWeight: FontWeight.bold,
									color: sucesso ? Colors.green : Colors.red,
								),
							),
					],
				),
			),
		);
	}
}