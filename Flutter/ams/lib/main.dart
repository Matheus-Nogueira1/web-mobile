import 'package:ams/revisao/produto_page.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(AMSApp());
}

class AMSApp extends StatelessWidget {
  const AMSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projeto AMS',
      home: ProdutoPage(),
    );
  }
}

