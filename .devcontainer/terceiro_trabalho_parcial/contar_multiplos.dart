import 'dart:io';

void main() {
  stdout.write('Digite um número inteiro N: ');
  int N = int.parse(stdin.readLineSync()!);
  if (N == null || N <= 0) {
    stdout.write('Por favor, insira um número válido maior que zero.\n');
    return;
  }
  stdout.write('Digite um número inteiro K: ');
  int K = int.parse(stdin.readLineSync()!);
  if (K == null || K <= 0) {
    stdout.write('Por favor, insira um número válido maior que zero.\n');
    return;
  }
  int quantidade = 0;
  for (int i = 1; i <= N; i++) {
    if (i % K == 0) {
      quantidade++;
    }
  }
  print('Quantidade de múltiplos de $K no intervalo 1..$N: $quantidade');
  return;
}
