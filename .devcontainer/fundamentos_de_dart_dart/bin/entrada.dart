/*importa a biblioteca */
import 'dart:io';

void main(){
  stdout.write('Qual o seu Nome? ');
  String? n = stdin.readLineSync();

  stdout.write('Boa tarde $n!');
}