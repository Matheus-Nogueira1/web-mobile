import 'dart:io';

void main() {
  int somapares = 0;
  int somaimpares = 0;
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
    if (numero % 2 == 0) {
      somapares += numero;
    } else {
      somaimpares += numero;
    }
  }
  stdout.write('Soma dos números pares: $somapares\n');
  stdout.write('Soma dos números ímpares: $somaimpares\n');
  return;
}