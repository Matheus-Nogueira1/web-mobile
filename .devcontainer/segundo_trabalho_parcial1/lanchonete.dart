import 'dart:io';

void main() {
  stdout.writeln('Qual o código do produto?');
  stdout.writeln('101 - Cachorro quente');
  stdout.writeln('102 - Bauru simples');
  stdout.writeln('103 - Bauru com ovo');
  stdout.writeln('104 - Hambúrguer');
  stdout.writeln('105 - Cheeseburger');
  stdout.writeln('106 - Refrigerante');
  stdout.write('Digite o código: ');

  final produto = stdin.readLineSync();
  if (produto == null || produto.isEmpty) {
    stdout.writeln('O campo código do lanche é obrigatório!');
    return;
  }

  final valor = _precoDoProduto(produto);
  if (valor == null) {
    stdout.writeln('Código do lanche inválido!');
    return;
  }

  stdout.write('Qual a quantidade do produto? ');
  final quantidade = stdin.readLineSync();
  if (quantidade == null || quantidade.isEmpty) {
    stdout.writeln('O campo quantidade é obrigatório!');
    return;
  }

  final qtd = double.tryParse(quantidade.replaceAll(',', '.'));
  if (qtd == null || qtd <= 0) {
    stdout.writeln('Por favor, insira uma quantidade válida maior que zero.');
    return;
  }

  final precoFinal = qtd * valor;
  stdout.writeln('O preço final do pedido é: R\$ ${precoFinal.toStringAsFixed(2)}');
}

double? _precoDoProduto(String codigo) {
  switch (codigo) {
    case '101':
      return 14.20;
    case '102':
      return 12.30;
    case '103':
      return 13.50;
    case '104':
      return 10.20;
    case '105':
      return 15.30;
    case '106':
      return 10.00;
    default:
      return null;
  }
}
