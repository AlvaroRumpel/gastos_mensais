import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gastos Mensais',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Color.fromARGB(255, 53, 15, 60),
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var valor = 0.0;
  TextEditingController despesas = TextEditingController();
  TextEditingController divididoController = TextEditingController();
  List historico = [];
  int dividido = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Dividir',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            TextField(
                              controller: divididoController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  suffixText: '%',
                                  border: OutlineInputBorder(),
                                  hintText: 'Porcentagem da divisão'),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                dividido =
                                    (100 / int.parse(divididoController.text))
                                        .round();
                                setState(() {
                                  dividido;
                                });
                                Navigator.pop(context);
                              },
                              label: const Text('Adicionar divisão'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              child: Card(
                elevation: 4,
                color: Colors.deepPurple[400],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.monetization_on,
                          size: 32, color: Colors.white),
                      Text(
                        'R\$ ${valor / dividido} / $dividido',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: historico.length,
              itemBuilder: (BuildContext context, index) => Card(
                color: Colors.deepPurple[200],
                child: ListTile(
                  onLongPress: () {
                    valor -= double.parse(historico[index]);
                    historico.remove(historico[index]);
                    setState(() {
                      historico;
                    });
                  },
                  title: Text('R\$ ${historico[index]}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(context),
        tooltip: 'Adicionar gastos',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Adicionar despesa',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  TextField(
                    controller: despesas,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixText: 'R\$ ',
                        border: OutlineInputBorder(),
                        hintText: 'valor da despesa'),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      valor = valor + double.parse(despesas.text);
                      historico.add(despesas.text);
                      despesas.clear();
                      setState(() {
                        historico;
                      });
                      Navigator.pop(context);
                    },
                    label: Text('Adicionar despesas'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
