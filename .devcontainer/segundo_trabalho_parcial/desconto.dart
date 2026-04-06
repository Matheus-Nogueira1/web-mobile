import 'dart:io';

const nomeRegioes = {
  '1': 'Norte',
  '2': 'Sul',
  '3': 'Sudeste',
  '4': 'Nordeste',
  '5': 'Centro-Oeste',
};

const descontoRegioes = {
  '1': 5.0,
  '2': 15.0,
  '3': 7.0,
  '4': 12.0,
  '5': 20.0,
};

void main() {
  final preco = _readPositiveDouble('Qual o preço do produto? ');
  if (preco == null) return;

  final regiao = _readRegion();
  if (regiao == null) return;

  final descontoPercentual = descontoRegioes[regiao] ?? 0.0;
  final descontoValor = preco * (descontoPercentual / 100);
  final precoFinal = preco - descontoValor;

  stdout.writeln('Região: ${nomeRegioes[regiao] ?? 'Importado'}');
  stdout.writeln('Preço original: R\$ ${preco.toStringAsFixed(2)}');
  stdout.writeln('Desconto: R\$ ${descontoValor.toStringAsFixed(2)} (${descontoPercentual.toStringAsFixed(1)}%)');
  stdout.writeln('Preço final: R\$ ${precoFinal.toStringAsFixed(2)}');
}

double? _readPositiveDouble(String prompt) {
  stdout.write(prompt);
  final input = stdin.readLineSync();
  if (input == null || input.isEmpty) {
    stdout.writeln('O campo preço é obrigatório!');
    return null;
  }

  final preco = double.tryParse(input.replaceAll(',', '.'));
  if (preco == null || preco <= 0) {
    stdout.writeln('Por favor, insira um preço válido maior que zero.');
    return null;
  }

  return preco;
}

String? _readRegion() {
  stdout.writeln('Qual sua região?');
  stdout.writeln('1 - Norte');
  stdout.writeln('2 - Sul');
  stdout.writeln('3 - Sudeste');
  stdout.writeln('4 - Nordeste');
  stdout.writeln('5 - Centro-Oeste');
  stdout.write('Digite o número da região: ');

  final input = stdin.readLineSync();
  if (input == null || input.isEmpty) {
    stdout.writeln('O campo região é obrigatório!');
    return null;
  }

  if (!descontoRegioes.containsKey(input)) {
    stdout.writeln('Região inválida. Nenhum desconto será aplicado.');
    return null;
  }

  return input;
}
