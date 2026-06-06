import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercícios Flutter',
      // =======================================================================
      // SEÇÃO DE CONFIGURAÇÃO DO "CSS" (THEME DATA)
      // =======================================================================
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), // Azul escuro corporativo
          primary: const Color(0xFF1E3A8A),
          background: const Color(0xFFF8FAFC), // Fundo claro moderno (Slate 50)
          surface: Colors.white,
        ),
        // Estilo Global da AppBar (CSS de Cabeçalhos)
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0F172A),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
            letterSpacing: 0.5,
          ),
        ),
        // Estilo Global dos Inputs (CSS dos Forms)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF1F5F9), // Fundo cinza bem claro
          labelStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
          floatingLabelStyle: const TextStyle(color: Color(0xFF1E3A8A), fontWeight: FontWeight.w600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        // Estilo Global do ElevatedButton (Botão Primário)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E3A8A),
            foregroundColor: Colors.white,
            elevation: 2,
            shadowColor: const Color(0xFF1E3A8A).withValues(alpha: 0.3),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
          ),
        ),
        // Estilo Global do OutlinedButton (Botão Secundário)
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF1E3A8A),
            side: const BorderSide(color: Color(0xFF1E3A8A), width: 1.5),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const MenuExercicios(),
    );
  }
}

class MenuExercicios extends StatelessWidget {
  const MenuExercicios({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Painel de Exercícios'),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: const Color(0xFF64748B),
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'Ex 1: Login'),
              Tab(text: 'Ex 2: Cadastro'),
              Tab(text: 'Ex 3: Preferências'),
              Tab(text: 'Ex 4: Turno'),
              Tab(text: 'Ex 5: Configs'),
              Tab(text: 'Ex 6: Curso'),
              Tab(text: 'Ex 7: Matrícula'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TelaLogin(),
            TelaCadastro(),
            TelaPreferencias(),
            TelaEscolhaTurno(),
            TelaConfiguracoes(),
            TelaSelecaoCurso(),
            TelaMatrulaCompleta(),
          ],
        ),
      ),
    );
  }
}
// ==========================================
// Exercício 1 — Tela de login
// ==========================================
class TelaLogin extends StatelessWidget {
  const TelaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // LINHA 146 CORRIGIDA DE "Center" PARA "TextAlign.center"
              const Text(
                'Bem-vindo de volta', 
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)), 
                textAlign: TextAlign.center, 
              ),
              const SizedBox(height: 8),
              // LINHA 148 CORRIGIDA DE "Center" PARA "TextAlign.center"
              const Text(
                'Insira seus dados para acessar', 
                style: TextStyle(fontSize: 14, color: Color(0xFF64748B)), 
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const TextField(
                decoration: InputDecoration(labelText: 'E-mail', prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF64748B))),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Senha', prefixIcon: Icon(Icons.lock_outlined, color: Color(0xFF64748B))),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ==========================================
// Exercício 2 — Tela de cadastro
// ==========================================
class TelaCadastro extends StatelessWidget {
  const TelaCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Nome Completo', prefixIcon: Icon(Icons.person_outline))),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Idade', prefixIcon: Icon(Icons.calendar_today_outlined))),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'E-mail', prefixIcon: Icon(Icons.email_outlined))),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// Exercício 3 — Tela de preferências
// ==========================================
class TelaPreferencias extends StatefulWidget {
  const TelaPreferencias({super.key});

  @override
  State<TelaPreferencias> createState() => _TelaPreferenciasState();
}

class _TelaPreferenciasState extends State<TelaPreferencias> {
  bool _aceitouTermos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Nome', prefixIcon: Icon(Icons.person_outline))),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: CheckboxListTile(
                title: const Text('Aceito receber novidades e concordo com os termos', style: TextStyle(fontSize: 14, color: Color(0xFF334155))),
                value: _aceitouTermos,
                activeColor: const Color(0xFF1E3A8A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onChanged: (bool? value) {
                  setState(() {
                    _aceitouTermos = value ?? false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// Exercício 4 — Tela de escolha de turno
// ==========================================
class TelaEscolhaTurno extends StatefulWidget {
  const TelaEscolhaTurno({super.key});

  @override
  State<TelaEscolhaTurno> createState() => _TelaEscolhaTurnoState();
}

class _TelaEscolhaTurnoState extends State<TelaEscolhaTurno> {
  String? _turnoSelecionado = 'manhã';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Nome do Aluno', prefixIcon: Icon(Icons.school_outlined))),
            const SizedBox(height: 24),
            const Text('Selecione o Turno:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: ['manhã', 'tarde', 'noite'].map((turno) {
                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE2E8F0))),
                    child: RadioListTile<String>(
                      title: Text(turno[0].toUpperCase() + turno.substring(1), style: const TextStyle(fontWeight: FontWeight.w500)),
                      value: turno,
                      groupValue: _turnoSelecionado,
                      activeColor: const Color(0xFF1E3A8A),
                      onChanged: (value) => setState(() => _turnoSelecionado = value),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// Exercício 5 — Tela de configurações
// ==========================================
class TelaConfiguracoes extends StatefulWidget {
  const TelaConfiguracoes({super.key});

  @override
  State<TelaConfiguracoes> createState() => _TelaConfiguracoesState();
}

class _TelaConfiguracoesState extends State<TelaConfiguracoes> {
  bool _receberNotificacoes = true;
  bool _modoEscuro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Nome do Usuário', prefixIcon: Icon(Icons.badge_outlined))),
            const SizedBox(height: 20),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE2E8F0))),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Receber notificações'),
                    secondary: const Icon(Icons.notifications_none_outlined),
                    value: _receberNotificacoes,
                    onChanged: (value) => setState(() => _receberNotificacoes = value),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  SwitchListTile(
                    title: const Text('Modo escuro'),
                    secondary: const Icon(Icons.dark_mode_outlined),
                    value: _modoEscuro,
                    onChanged: (value) => setState(() => _modoEscuro = value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// Exercício 6 — Tela de seleção de curso
// ==========================================
class TelaSelecaoCurso extends StatefulWidget {
  const TelaSelecaoCurso({super.key});

  @override
  State<TelaSelecaoCurso> createState() => _TelaSelecaoCursoState();
}

class _TelaSelecaoCursoState extends State<TelaSelecaoCurso> {
  String? _cursoSelecionado;
  final List<String> _cursos = ['Informática', 'Administração', 'Eletrônica'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Nome do Aluno', prefixIcon: Icon(Icons.person_outline))),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Selecione o Curso', prefixIcon: Icon(Icons.book_outlined)),
              initialValue: _cursoSelecionado,
              items: _cursos.map((String curso) {
                return DropdownMenuItem<String>(value: curso, child: Text(curso));
              }).toList(),
              onChanged: (newValue) => setState(() => _cursoSelecionado = newValue),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// Exercício 7 — Tela de matrícula completa
// ==========================================
class TelaMatrulaCompleta extends StatefulWidget {
  const TelaMatrulaCompleta({super.key});

  @override
  State<TelaMatrulaCompleta> createState() => _TelaMatrulaCompletaState();
}

class _TelaMatrulaCompletaState extends State<TelaMatrulaCompleta> {
  String? _turno = 'manhã';
  String? _curso;
  final List<String> _cursos = ['Informática', 'Administração', 'Eletrônica'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Ficha de Matrícula', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            const SizedBox(height: 20),
            const TextField(decoration: InputDecoration(labelText: 'Nome do Aluno', prefixIcon: Icon(Icons.person_outline))),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Idade', prefixIcon: Icon(Icons.calendar_today_outlined))),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Nome do Responsável', prefixIcon: Icon(Icons.supervisor_account_outlined))),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Telefone', prefixIcon: Icon(Icons.phone_outlined))),
            const SizedBox(height: 24),
            
            const Text('Turno desejado:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF334155))),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE2E8F0))),
              child: Column(
                children: ['manhã', 'tarde', 'noite'].map((t) {
                  return RadioListTile<String>(
                    title: Text(t[0].toUpperCase() + t.substring(1)),
                    value: t,
                    groupValue: _turno,
                    activeColor: const Color(0xFF1E3A8A),
                    onChanged: (v) => setState(() => _turno = v),
                  );
                }).toList(),
              ),
            ),
            
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Curso Escolhido', prefixIcon: Icon(Icons.assignment_outlined)),
              initialValue: _curso,
              items: _cursos.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (v) => setState(() => _curso = v),
            ),
            
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Enviar matrícula'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}