import 'dart:io';

void main() {
  stdout.write('Digite um número inteiro maior que 0: ');
  int numero = int.parse(stdin.readLineSync() ?? '');
  if (numero == null || numero <= 0) {
    stdout.write('Por favor, insira um número válido maior que zero.\n');
    return;
  }
  for (int i = numero; i > 0; i--) {
    stdout.write('$i... ');
  }
  stdout.write('0!\n');
  return;
}
