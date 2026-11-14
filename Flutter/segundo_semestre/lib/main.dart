import 'package:material_ui/material_ui.dart';
import 'package:segundo_semestre/revisao/produto_page.dart';

void main() {
  runApp(AMSApp());
}

class AMSApp extends StatelessWidget {
  const AMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AMS App',
      home: ProdutoPage(),
    );
  }
}