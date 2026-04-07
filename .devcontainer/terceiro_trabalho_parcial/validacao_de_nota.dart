import 'dart:io';

void main() {
  do {
    stdout.write(' Digite uma nota entre 0 a 10: ');
    int nota = int.parse(stdin.readLineSync()!);
    if (nota >= 0 && nota <= 10) {
      stdout.write('Nota válida.\n');
      break;
    } else {
      stdout.write('Nota inválida. Por favor, digite uma nota entre 0 a 10.\n');
    }
  } while (true);
  stdout.write('Programa encerrado.\n');
  return;
}