import 'dart:io';

void main() {
  do {
    stdout.write('Deseja continuar? (s/n): ');
    String? resposta = stdin.readLineSync();
    if (resposta == 's') {
      stdout.write('Você escolheu: continuar\n');
    } else if (resposta == 'n') {
      stdout.write('Você escolheu: sair\n');
      break;
    } else {
      stdout.write(
        'Opção inválida. Por favor, digite "s" para continuar ou "n" para sair.\n',
      );
    }
  } while (true);
  stdout.write('Programa encerrado.\n');
}
