import 'dart:io';

void main() {
  stdout.write('Qual o preço do produto? ');
  String? valor = stdin.readLineSync();
  if (valor == null || valor.isEmpty) {
    stdout.write('O campo preço é obrigatório!\n');
    return;
  }
  double? preco = double.tryParse(valor);
  if (preco == null || preco <= 0) {
    stdout.write('Por favor, insira um preço válido maior que zero.\n');
    return;
  }

  stdout.write('Qual a porcentagem de desconto? ');
  String? descontoInput = stdin.readLineSync();
  if (descontoInput == null || descontoInput.isEmpty) {
    stdout.write('O campo desconto é obrigatório!\n');
    return;
  }
  double? descontoPercentual = double.tryParse(descontoInput);
  if (descontoPercentual == null || descontoPercentual < 0 || descontoPercentual > 100) {
    stdout.write('Por favor, insira uma porcentagem de desconto válida (0-100).\n');
    return;
  }

  double descontoValor = preco * (descontoPercentual / 100);
  double precoFinal = preco - descontoValor;

  stdout.write('Preço original: R\$ ${preco.toStringAsFixed(2)}\n');
  stdout.write('Desconto: R\$ ${descontoValor.toStringAsFixed(2)} (${descontoPercentual}%)\n');
  stdout.write('Preço final: R\$ ${precoFinal.toStringAsFixed(2)}\n');
}