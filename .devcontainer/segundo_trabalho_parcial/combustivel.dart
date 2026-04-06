import 'dart:io';

const tipoGasolina = {
  '1': 'Comum',
  '2': 'Premium',
  '3': 'Diesel',
  '4': 'Álcool',
};

const precoLitro = {
  '1': 6.50,
  '2': 7.80,
  '3': 5.90,
  '4': 4.20,
};

void main() {
  stdout.writeln('Qual o tipo de combustível?');
  stdout.writeln('1 - Comum');
  stdout.writeln('2 - Premium');
  stdout.writeln('3 - Diesel');
  stdout.writeln('4 - Álcool');
  stdout.write('Digite o número do combustível: ');

  final tipo = stdin.readLineSync();
  if (tipo == null || tipo.isEmpty) {
    stdout.writeln('O campo tipo de combustível é obrigatório!');
    return;
  }

  final preco = precoLitro[tipo];
  if (preco == null) {
    stdout.writeln('Tipo de combustível inválido!');
    return;
  }

  stdout.write('Quantos litros deseja abastecer? ');
  final litrosInput = stdin.readLineSync();
  if (litrosInput == null || litrosInput.isEmpty) {
    stdout.writeln('O campo quantidade de litros é obrigatório!');
    return;
  }

  final litros = double.tryParse(litrosInput.replaceAll(',', '.'));
  if (litros == null || litros <= 0) {
    stdout.writeln('Por favor, insira uma quantidade válida de litros maior que zero.');
    return;
  }

  final valorTotal = preco * litros;
  stdout.writeln('Tipo de combustível: ${tipoGasolina[tipo] ?? 'Desconecido'}');
  stdout.writeln('Quantidade de litros: ${litros.toStringAsFixed(2)}');
  stdout.writeln('Preço por litro: R\$ ${preco.toStringAsFixed(2)}');
  stdout.writeln('O valor total a ser pago é: R\$ ${valorTotal.toStringAsFixed(2)}');
}