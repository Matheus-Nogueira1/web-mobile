import 'dart:io';

void main() {
  do {
    stdout.write(' 1-Somar \n 2-Subtrair \n 0-Sair \n Digite a operação desejada: ');
    int operacao = int.parse(stdin.readLineSync()!);
    if (operacao == 1) {
      stdout.write('Você escolheu: Somar\n');
    } else if (operacao == 2) {
      stdout.write('Você escolheu: Subtrair\n');
    }
    else if (operacao == 0) {
      break;
    } else {
      stdout.write('Opção inválida. Por favor, escolha uma operação válida.\n');
    }
  } while (true);
  stdout.write('Programa encerrado.\n');
  return;
}