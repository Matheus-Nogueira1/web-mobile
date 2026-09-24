import 'package:flutter/material.dart';

import 'exercicios/ex_1_funcionario.dart';
import 'exercicios/ex_2_pedido.dart';
import 'exercicios/ex_3_conta.dart';
import 'exercicios/ex_4_curso.dart';
import 'exercicios/ex_5_imovel.dart';

void main() {
	runApp(const AMSApp());
}

class AMSApp extends StatelessWidget {
	const AMSApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Lista de Exercícios',
			theme: ThemeData(
				colorScheme: ColorScheme.fromSeed(
					seedColor: Colors.blue,
				),
				useMaterial3: true,
			),
			home: const MenuPrincipal(),
		);
	}
}

class MenuPrincipal extends StatelessWidget {
	const MenuPrincipal({super.key});

	void abrirTela(BuildContext context, Widget tela) {
		Navigator.push(
			context,
			MaterialPageRoute(
				builder: (context) => tela,
			),
		);
	}

	Widget botaoExercicio(
		BuildContext context,
		String titulo,
		String descricao,
		IconData icone,
		Widget tela,
	) {
		return Padding(
			padding: const EdgeInsets.only(bottom: 12),
			child: SizedBox(
				width: double.infinity,
				height: 65,
				child: ElevatedButton.icon(
					onPressed: () {
						abrirTela(context, tela);
					},
					icon: Icon(icone),
					label: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text(
								titulo,
								style: const TextStyle(
									fontWeight: FontWeight.bold,
									fontSize: 16,
								),
							),
							Text(
								descricao,
								style: const TextStyle(
									fontSize: 12,
								),
							),
						],
					),
					style: ElevatedButton.styleFrom(
						alignment: Alignment.centerLeft,
						padding: const EdgeInsets.symmetric(
							horizontal: 18,
						),
					),
				),
			),
		);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Lista de Exercícios'),
				centerTitle: true,
			),
			body: SingleChildScrollView(
				padding: const EdgeInsets.all(20),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.stretch,
					children: [
						const Icon(
							Icons.assignment,
							size: 70,
							color: Colors.blue,
						),
						const SizedBox(height: 10),
						const Text(
							'Formulários Flutter',
							textAlign: TextAlign.center,
							style: TextStyle(
								fontSize: 25,
								fontWeight: FontWeight.bold,
							),
						),
						const SizedBox(height: 5),
						const Text(
							'Form, TextFormField e Validator',
							textAlign: TextAlign.center,
							style: TextStyle(
								color: Colors.grey,
							),
						),
						const SizedBox(height: 25),
						botaoExercicio(
							context,
							'Exercício 1',
							'Cadastro de Funcionário',
							Icons.badge,
							const Exercicio1Funcionario(),
						),
						botaoExercicio(
							context,
							'Exercício 2',
							'Cadastro de Pedido',
							Icons.shopping_cart,
							const Exercicio2Pedido(),
						),
						botaoExercicio(
							context,
							'Exercício 3',
							'Cadastro de Conta Bancária',
							Icons.account_balance,
							const Exercicio3Conta(),
						),
						botaoExercicio(
							context,
							'Exercício 4',
							'Cadastro de Curso',
							Icons.school,
							const Exercicio4Curso(),
						),
						botaoExercicio(
							context,
							'Exercício 5',
							'Cadastro de Imóvel',
							Icons.home,
							const Exercicio5Imovel(),
						),
					],
				),
			),
		);
	}
}