import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gastos Mensais',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(
          color: Colors.purple,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w800,
          ),
          centerTitle: true,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 53, 15, 60),
        useMaterial3: true,
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
  TextEditingController despesasController = TextEditingController();
  TextEditingController divididoController = TextEditingController();
  List historico = [];
  int dividido = 1;

  ButtonStyle buttonStyle() => ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (state) {
            if (state.contains(MaterialState.pressed)) {
              return Colors.purple[400];
            }
            return Colors.purple;
          },
        ),
        surfaceTintColor: MaterialStateProperty.resolveWith<Color?>(
          (state) {
            if (state.contains(MaterialState.pressed)) {
              return Colors.purple[400];
            }
            return Colors.purple;
          },
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (state) {
            if (state.contains(MaterialState.pressed)) {
              return Colors.purple[400];
            }
            return Colors.purple;
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                                maxLength: 2,
                                decoration: InputDecoration(
                                  suffixText: '%',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Porcentagem da divisão',
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                              ElevatedButton.icon(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (divididoController.text.isNotEmpty) {
                                    dividido = (100 /
                                            int.parse(divididoController.text))
                                        .round();
                                    setState(() {
                                      dividido;
                                    });
                                  }
                                  Navigator.pop(context);
                                },
                                label: const Text(
                                  'Adicionar divisão',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                style: buttonStyle(),
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
                        const Icon(
                          Icons.monetization_on,
                          size: 32,
                          color: Colors.white,
                        ),
                        Text(
                          'R\$ ${valor / dividido} / $dividido',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
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
                    title: Text(
                      'R\$ ${historico[index]}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await _showDialog(context),
          tooltip: 'Adicionar gastos',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    await showDialog(
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
                    'Adicionar despesa',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                TextField(
                  controller: despesasController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: 'R\$ ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Valor da despesa',
                  ),
                ),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (despesasController.text.isNotEmpty) {
                      valor = valor + double.parse(despesasController.text);
                      historico.add(despesasController.text);
                      despesasController.clear();
                      setState(() {
                        historico;
                      });
                    }
                    Navigator.pop(context);
                  },
                  label: const Text(
                    'Adicionar despesas',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: buttonStyle(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
