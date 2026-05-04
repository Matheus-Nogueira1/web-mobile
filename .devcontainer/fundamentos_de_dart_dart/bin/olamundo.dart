Class OlaMundoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Olá Mundo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Olá Mundo'),
        ),
        body: Center(
          child: Text('Olá, Mundo!'),
        ),
      ),
    );
  }
}
Class OlaMundoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return OlaMundoState();
  } 
}
        appBar: AppBar(
          title: Text('Olá Mundo'),
        ),
        body: Center(
          child: Text('Olá, Mundo!'),
        ),
Class OlaMundoState extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _OlaMundoStateState();
  }
}
      body: Center(
        child: Text('Olá, Mundo!'),
      ),