import 'dart:io';

void main() {
  int soma = 0;
  while (true) {
    stdout.write('Digite um número inteiro (0 para sair): ');
    int numero = int.parse(stdin.readLineSync()!);
    if (numero == 0) {
      break;
    }
    if (numero < 0) {
      stdout.write('Por favor, insira um número válido.\n');
      continue;
    }
    soma += numero;
  }
  stdout.write('Soma dos números digitados: $soma\n');
  return;
}
