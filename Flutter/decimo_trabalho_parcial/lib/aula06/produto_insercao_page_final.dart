
import 'package:all_br_forms/all_br_forms.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:validatorless/validatorless.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProdutoInsercaoPage extends StatefulWidget {
  const ProdutoInsercaoPage({super.key});

  @override
  State<ProdutoInsercaoPage> createState() {
    return ProdutoInsercaoState();
  }
}

class ProdutoInsercaoState extends State<ProdutoInsercaoPage> {
  // Chave utilizada para controlar e validar o formulário.
  final GlobalKey<FormState> formularioChave = GlobalKey<FormState>();

  // Controladores dos campos.
  final TextEditingController nomeControlador = TextEditingController();
  final TextEditingController precoControlador = TextEditingController();
  final TextEditingController quantidadeControlador =
      TextEditingController();

  // Controla o estado do botão durante o salvamento.
  bool salvando = false;

  // Converte o preço digitado para um valor numérico.
  double? converterPreco(String? texto) {
    String digitos = (texto ?? '').replaceAll(RegExp(r'\D'), '');

    return digitos.isEmpty ? null : int.parse(digitos) / 100;
  }

  // Valida o intervalo permitido para o preço.
  String? validarPreco(String? valor) {
    double? preco = converterPreco(valor);

    if (preco == null) {
      return 'O campo preço é obrigatório';
    }

    return Validatorless.numbersBetweenInterval(
      0.10,
      99999.99,
      'O preço deve estar entre R\$ 0,10 e R\$ 99.999,99',
    )(preco.toString());
  }

  // Envia os dados do formulário para o Supabase.
  Future<void> salvar() async {
    final formularioEstado = formularioChave.currentState;

    // Impede o envio caso o formulário seja inválido.
    if (formularioEstado == null || !formularioEstado.validate()) {
      return;
    }

    // Impede múltiplos envios simultâneos.
    if (salvando) return;

    setState(() {
      salvando = true;
    });

    try {
      // Insere um novo produto na tabela produtos.
      await Supabase.instance.client.from('produtos').insert({
        'nome': nomeControlador.text.trim(),
        'preco': converterPreco(precoControlador.text),
        'quantidade': int.parse(quantidadeControlador.text),
      });

      if (!mounted) return;

      // Limpa os campos após o cadastro.
      formularioEstado.reset();

      nomeControlador.clear();
      precoControlador.clear();
      quantidadeControlador.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produto cadastrado com sucesso!'),
        ),
      );
    } on PostgrestException catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao cadastrar produto: ${erro.message}'),
        ),
      );
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro inesperado: $erro'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          salvando = false;
        });
      }
    }
  }

  // Libera os controladores quando a página é encerrada.
  @override
  void dispose() {
    nomeControlador.dispose();
    precoControlador.dispose();
    quantidadeControlador.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF3FA),
      body: Stack(
        children: [
          // Fundo decorativo com elementos geométricos.
          Positioned(
            top: -100,
            right: -70,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                color: const Color(0xFFD8E8FC),
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),

          Positioned(
            bottom: -100,
            left: -70,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: const Color(0xFFDCEBFA),
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 520,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Cabeçalho da aplicação.
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2459A6),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.inventory_2_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),

                          const SizedBox(width: 12),

                          const Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'StockFlow',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF172B4D),
                                ),
                              ),
                              Text(
                                'CONTROLE DE ESTOQUE',
                                style: TextStyle(
                                  fontSize: 10,
                                  letterSpacing: 1.3,
                                  color: Color(0xFF64748B),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Color(0xFF16A34A),
                                  size: 8,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Online',
                                  style: TextStyle(
                                    color: Color(0xFF166534),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Cartão principal do formulário.
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1E3A5F)
                                  .withOpacity(0.09),
                              blurRadius: 30,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Form(
                          key: formularioChave,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'GERENCIAMENTO / PRODUTOS',
                                style: TextStyle(
                                  fontSize: 10,
                                  letterSpacing: 1.2,
                                  color: Color(0xFF64748B),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                'Novo produto',
                                style: TextStyle(
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF172B4D),
                                ),
                              ),

                              const SizedBox(height: 8),

                              const Text(
                                'Preencha os dados abaixo para '
                                'adicionar um produto ao estoque.',
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.5,
                                  color: Color(0xFF64748B),
                                ),
                              ),

                              const SizedBox(height: 25),

                              // Campo nome.
                              const Text(
                                'Nome do produto',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF334155),
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 8),

                              TextFormField(
                                controller: nomeControlador,
                                validator: Validatorless.multiple([
                                  Validatorless.required(
                                    'O campo nome é obrigatório',
                                  ),
                                  Validatorless.between(
                                    3,
                                    50,
                                    'O nome deve ter entre 3 e 50 caracteres',
                                  ),
                                ]),
                                decoration: InputDecoration(
                                  hintText: 'Ex: Coca Cola 2 Litros',
                                  prefixIcon: const Icon(
                                    Icons.inventory_2_outlined,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFF8FAFC),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF2459A6),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 18),

                              // Campos de preço e quantidade.
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final largura =
                                      constraints.maxWidth;

                                  return largura < 380
                                      ? Column(
                                          children: [
                                            campoPreco(),
                                            const SizedBox(height: 18),
                                            campoQuantidade(),
                                          ],
                                        )
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: campoPreco(),
                                            ),
                                            const SizedBox(width: 14),
                                            Expanded(
                                              child: campoQuantidade(),
                                            ),
                                          ],
                                        );
                                },
                              ),

                              const SizedBox(height: 22),

                              // Informação sobre o banco de dados.
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEFF6FF),
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.cloud_done_outlined,
                                      color: Color(0xFF2459A6),
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'Os dados serão armazenados '
                                        'no banco de dados Supabase.',
                                        style: TextStyle(
                                          color: Color(0xFF1E40AF),
                                          fontSize: 11,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 22),

                              // Botão de cadastro.
                              SizedBox(
                                height: 52,
                                child: ElevatedButton.icon(
                                  onPressed:
                                      salvando ? null : salvar,
                                  icon: Icon(
                                    salvando
                                        ? Icons.hourglass_top
                                        : Icons.save_outlined,
                                  ),
                                  label: Text(
                                    salvando
                                        ? 'Salvando...'
                                        : 'Cadastrar produto',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFF2459A6),
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor:
                                        const Color(0xFF94A3B8),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 18),

                              const Text(
                                'Sistema de gerenciamento de produtos',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF94A3B8),
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'DESENVOLVIDO PARA A ATIVIDADE DE AMS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 9,
                          letterSpacing: 1.1,
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

  // Campo de preço.
  Widget campoPreco() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Preço do produto',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF334155),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: precoControlador,
          keyboardType: TextInputType.numberWithOptions(
            decimal: true,
          ),
          inputFormatters: [CurrencyMask()],
          validator: validarPreco,
          decoration: InputDecoration(
            hintText: 'R\$ 12,50',
            prefixIcon: const Icon(Icons.attach_money),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE2E8F0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE2E8F0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF2459A6),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Campo de quantidade.
  Widget campoQuantidade() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Quantidade',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF334155),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: quantidadeControlador,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: Validatorless.multiple([
            Validatorless.required(
              'O campo quantidade é obrigatório',
            ),
            Validatorless.regex(
              RegExp(r'^[1-9]\d*$'),
              'A quantidade não pode começar com zero',
            ),
            Validatorless.numbersBetweenInterval(
              1,
              1000,
              'A quantidade deve estar entre 1 e 1000',
            ),
          ]),
          decoration: InputDecoration(
            hintText: 'Ex: 10',
            prefixIcon: const Icon(Icons.numbers),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE2E8F0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE2E8F0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF2459A6),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

}
