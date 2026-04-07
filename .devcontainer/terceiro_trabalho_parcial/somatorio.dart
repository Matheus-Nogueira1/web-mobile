import 'dart:io';

void main() {
  stdout.write('Digite um número inteiro: ');
  int numero = int.parse(stdin.readLineSync() ?? '');
  if (numero == null || numero <= 0) {
    stdout.write('Por favor, insira um número válido maior que zero.\n');
    return;
  }
  int somatoria = 0;
  for (int i = 0; i < numero; i++) {
    stdout.write('$i... ');
    somatoria = somatoria + i;
  }
  stdout.write('$numero\n');
  stdout.write('Somatória: $somatoria\n');
  return;
}
