import 'dart:io';

void main() {
  stdout.write('Qual seu estado? Exemplo: SP, RJ, MG... ');
  String? estado = stdin.readLineSync();

  if (estado == null || estado.isEmpty) {
    stdout.write('O campo estado é obrigatório!\n');
    return;
  }
  const regiaoNorte = ['AM', 'PA', 'RO', 'RR', 'AC', 'AP', 'TO'];
  const regiaoNordeste = ['BA', 'SE', 'AL', 'PE', 'PB', 'RN', 'CE', 'MA', 'PI'];
  const regiaoCentroOeste = ['MT', 'MS', 'GO', 'DF'];
  const regiaoSudeste = ['SP', 'RJ', 'ES', 'MG'];
  const regiaoSul = ['RS', 'SC', 'PR'];
  if (regiaoNorte.contains(estado.toUpperCase())) {
    stdout.write('Você mora na região Norte\n');
  } else if (regiaoNordeste.contains(estado.toUpperCase())) {
    stdout.write('Você mora na região Nordeste\n');
  } else if (regiaoCentroOeste.contains(estado.toUpperCase())) {
    stdout.write('Você mora na região Centro-Oeste\n');
  } else if (regiaoSudeste.contains(estado.toUpperCase())) {
    stdout.write('Você mora na região Sudeste\n');
  } else if (regiaoSul.contains(estado.toUpperCase())) {
    stdout.write('Você mora na região Sul\n');
  } else {
    stdout.write('Estado não reconhecido!\n');
  }
  return;
}
