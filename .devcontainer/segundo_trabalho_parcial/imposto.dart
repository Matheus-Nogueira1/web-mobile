import 'dart:io';

void main() {
  stdout.write('Qual seu salário mensal? ');
  String? salario = stdin.readLineSync();
  if (salario == null || salario.isEmpty) {
    stdout.write('O campo salário é obrigatório!\n');
    return;
  }
  double? salarioNumerico = double.tryParse(salario);
  if (salarioNumerico == null || salarioNumerico <= 0) {
    stdout.write('Por favor, insira um salário válido maior que zero.\n');
    return;
  }
  double imposto;
  if (salarioNumerico <= 2000.00) {
    imposto = 0;
  } else if (salarioNumerico > 2000.00 && salarioNumerico <= 5000.00) {
    imposto = salarioNumerico * 0.10;
  } else if (salarioNumerico > 5000.00 && salarioNumerico <= 10000.00) {
    imposto = salarioNumerico * 0.15;
  } else {
    imposto = salarioNumerico * 0.20;
  }
  stdout.write('Salário: R\$ ${salarioNumerico.toStringAsFixed(2)}\n');
  stdout.write('O imposto a ser pago é: R\$ ${imposto.toStringAsFixed(2)}\n');
  stdout.write('Salário líquido após imposto: R\$ ${(salarioNumerico - imposto).toStringAsFixed(2)}\n');
  return;
}
