import 'package:flutter/material.dart';
import 'package:segundo_semestre/revisao/produto_page.dart';

void main() {
  runApp(AMSApp());
}

class AMSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMS App',
      home: ProdutoPage(),
    );
  }
}