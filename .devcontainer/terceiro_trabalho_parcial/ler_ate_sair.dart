import 'dart:io';

void main() {
  while (true) {
    stdout.write('Digite uma palavra (ou "sair" para encerrar): ');
    String palavra = stdin.readLineSync()!;
    if (palavra == 'sair') {
      break;
    }
    stdout.write('Você digitou: $palavra\n');
  }
  stdout.write('Programa encerrado.\n');
  return;
}