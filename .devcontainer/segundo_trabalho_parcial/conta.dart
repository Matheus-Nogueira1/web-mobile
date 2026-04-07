import 'dart:io';

void main() {
  stdout.write('Qual seu consumo mensal em kWh? ');
  String? consumo = stdin.readLineSync();
  if (consumo == null || consumo.isEmpty) {
    stdout.write('O campo consumo é obrigatório!\n');
    return;
  }
  double? consumoNumerico = double.tryParse(consumo);
  if (consumoNumerico == null || consumoNumerico <= 0) {
    stdout.write('Por favor, insira um consumo válido maior que zero.\n');
    return;
  }
  double tarifa;
  if (consumoNumerico <= 100) {
    tarifa = 0.80;
  } else if (consumoNumerico > 100 && consumoNumerico <= 300) {
    tarifa = 1.10;
  } else if (consumoNumerico > 300 && consumoNumerico <= 500) {
    tarifa = 1.40;
  } else {
    tarifa = 1.80;
  }

  double custoMensal = consumoNumerico * tarifa;

  stdout.write('Consumo: ${consumoNumerico.toStringAsFixed(2)} kWh\n');
  stdout.write('O custo a ser pago é: R\$ ${custoMensal.toStringAsFixed(2)}\n');
  stdout.write(
    'Consumo líquido após custo: R\$ ${(consumoNumerico - custoMensal).toStringAsFixed(2)}\n',
  );
  return;
}
