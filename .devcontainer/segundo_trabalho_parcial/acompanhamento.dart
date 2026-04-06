import 'dart:io';

void main() {
  stdout.write('Qual seu lanche? ');
  String? lanche = stdin.readLineSync();
  if (lanche == null || lanche.isEmpty) {
    stdout.write('O campo lanche é obrigatório!\n');
    return;
  }
  stdout.write('Qual sua bebida? ');
  String? bebida = stdin.readLineSync();
  if (bebida == null || bebida.isEmpty) {
    stdout.write('O campo bebida é obrigatório!\n');
    return;
  }
  
  if (lanche == 'Bauru' && bebida == 'Guaraná') {
    stdout.write('Combinação indisponível!\n');
  } else if (lanche == 'X-frango' && bebida == 'Água') {
    stdout.write('Combinação indisponível!\n');
  } else if (lanche == 'Pizza' && bebida != 'Vinho' && bebida != 'Água') {
    stdout.write('Combinação indisponível!\n');
  } else {
    stdout.write('Combinação disponível!\n');
  }
  return;
}
