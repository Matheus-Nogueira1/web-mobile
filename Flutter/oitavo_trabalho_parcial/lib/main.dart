import 'package:flutter/material.dart';

import 'exercicios/ex_1_funcionario.dart';
import 'exercicios/ex_2_cliente.dart';
import 'exercicios/ex_3_empresa.dart';
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
			title: 'Trabalho 8 - Flutter',
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
				height: 70,
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
									fontSize: 16,
									fontWeight: FontWeight.bold,
								),
							),
							const SizedBox(height: 3),
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
				title: const Text('Trabalho 8 - Flutter'),
				centerTitle: true,
			),
			body: SingleChildScrollView(
				padding: const EdgeInsets.all(20),
				child: Column(
					children: [
						const Icon(
							Icons.assignment,
							size: 70,
							color: Colors.blue,
						),
						const SizedBox(height: 10),
						const Text(
							'Validatorless, Intl e All BR Forms',
							textAlign: TextAlign.center,
							style: TextStyle(
								fontSize: 22,
								fontWeight: FontWeight.bold,
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
							'Cadastro de Cliente',
							Icons.person,
							const Exercicio2Cliente(),
						),

						botaoExercicio(
							context,
							'Exercício 3',
							'Cadastro de Empresa',
							Icons.business,
							const Exercicio3Empresa(),
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