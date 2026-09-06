import 'package:flutter/material.dart';

import 'ex_1_cadastro_de_veiculo.dart';
import 'ex_2_cadastro_de_filme.dart';
import 'ex_3_cadastro_de_alunos.dart';
import 'ex_4_cadastro_de_livro.dart';
import 'ex_5_cadastro_de_evento.dart';
import 'ex_6_cadastro_de_usuario.dart';

void main() {
	runApp(const MeuAplicativo());
}

class MeuAplicativo extends StatelessWidget {
	const MeuAplicativo({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Lista de Exercícios',
			theme: ThemeData(
				useMaterial3: true,
				colorScheme: ColorScheme.fromSeed(
					seedColor: Colors.indigo,
				),
			),
			home: const MenuPrincipal(),
		);
	}
}

class MenuPrincipal extends StatelessWidget {
	const MenuPrincipal({super.key});

	Widget botaoExercicio(
		BuildContext context,
		String titulo,
		String descricao,
		IconData icone,
		Color cor,
		Widget tela,
	) {
		return Container(
			margin: const EdgeInsets.only(bottom: 14),
			child: Material(
				color: Colors.transparent,
				child: InkWell(
					borderRadius: BorderRadius.circular(18),
					onTap: () {
						Navigator.push(
							context,
							MaterialPageRoute(
								builder: (context) => tela,
							),
						);
					},
					child: Container(
						padding: const EdgeInsets.all(16),
						decoration: BoxDecoration(
							color: Colors.white.withOpacity(0.88),
							borderRadius: BorderRadius.circular(18),
							border: Border.all(
								color: Colors.white.withOpacity(0.7),
							),
							boxShadow: [
								BoxShadow(
									color: Colors.black.withOpacity(0.18),
									blurRadius: 10,
									offset: const Offset(0, 5),
								),
							],
						),
						child: Row(
							children: [
								Container(
									width: 52,
									height: 52,
									decoration: BoxDecoration(
										color: cor.withOpacity(0.15),
										borderRadius:
											BorderRadius.circular(14),
									),
									child: Icon(
										icone,
										color: cor,
										size: 28,
									),
								),
								const SizedBox(width: 15),
								Expanded(
									child: Column(
										crossAxisAlignment:
											CrossAxisAlignment.start,
										children: [
											Text(
												titulo,
												style: const TextStyle(
													fontSize: 17,
													fontWeight: FontWeight.bold,
													color: Color(0xFF202438),
												),
											),
											const SizedBox(height: 4),
											Text(
												descricao,
												style: TextStyle(
													fontSize: 13,
													color: Colors.grey.shade700,
												),
											),
										],
									),
								),
								Icon(
									Icons.arrow_forward_ios_rounded,
									size: 18,
									color: cor,
								),
							],
						),
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
							'assets/fundo_home.jpg',
							fit: BoxFit.cover,
						),
					),
					Positioned.fill(
						child: Container(
							color: Colors.black.withOpacity(0.32),
						),
					),
					SafeArea(
						child: Center(
							child: SingleChildScrollView(
								padding: const EdgeInsets.all(20),
								child: Container(
									constraints:
										const BoxConstraints(maxWidth: 600),
									padding: const EdgeInsets.all(25),
									decoration: BoxDecoration(
										color: Colors.white.withOpacity(0.82),
										borderRadius:
											BorderRadius.circular(24),
										border: Border.all(
											color:
												Colors.white.withOpacity(0.65),
										),
										boxShadow: [
											BoxShadow(
												color: Colors.black
													.withOpacity(0.25),
												blurRadius: 20,
												offset: const Offset(0, 10),
											),
										],
									),
									child: Column(
										children: [
											Container(
												width: 80,
												height: 80,
												decoration: BoxDecoration(
													color: Colors.indigo
														.withOpacity(0.14),
													shape: BoxShape.circle,
												),
												child: const Icon(
													Icons.assignment_rounded,
													size: 44,
													color: Color(0xFF3949AB),
												),
											),
											const SizedBox(height: 16),
											const Text(
												'Lista de Exercícios',
												textAlign: TextAlign.center,
												style: TextStyle(
													fontSize: 28,
													fontWeight: FontWeight.bold,
													color: Color(0xFF202438),
												),
											),
											const SizedBox(height: 6),
											Text(
												'Flutter — Validação Manual',
												textAlign: TextAlign.center,
												style: TextStyle(
													fontSize: 15,
													color: Colors.grey.shade700,
												),
											),
											const SizedBox(height: 25),
											botaoExercicio(
												context,
												'Exercício 1 — Veículo',
												'Cadastro de veículo',
												Icons.directions_car_rounded,
												Colors.blue,
												const CadastroVeiculo(),
											),
											botaoExercicio(
												context,
												'Exercício 2 — Filme',
												'Cadastro de filme',
												Icons.movie_rounded,
												Colors.deepPurple,
												const CadastroFilme(),
											),
											botaoExercicio(
												context,
												'Exercício 3 — Aluno',
												'Cadastro de aluno',
												Icons.school_rounded,
												Colors.teal,
												const CadastroAluno(),
											),
											botaoExercicio(
												context,
												'Exercício 4 — Livro',
												'Cadastro de livro',
												Icons.menu_book_rounded,
												Colors.orange.shade800,
												const CadastroLivro(),
											),
											botaoExercicio(
												context,
												'Exercício 5 — Evento',
												'Cadastro de evento',
												Icons.event_rounded,
												Colors.pink,
												const CadastroEvento(),
											),
											botaoExercicio(
												context,
												'Exercício 6 — Usuário',
												'Cadastro de usuário',
												Icons.person_add_rounded,
												Colors.green.shade700,
												const CadastroUsuario(),
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