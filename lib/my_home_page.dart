import 'package:flutter/material.dart';
import 'package:introducao/fiscal.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _incrementando = true;
  int _contador = 0;
  List<int> _historico = [];
  int _total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('APP'),
      ),
      drawer: _buildDrawer(),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementar,
        tooltip: _incrementando ? 'Incrementar' : 'Decrementar',
        child: Icon(_incrementando ? Icons.add : Icons.remove),
      ),
    );
  }

  Center _buildBody(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          const Text('Contador',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic)),
          Text('$_contador', style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 20.0),
          Text('Memoria',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.2),
              child: Text(
                  _historico.isEmpty ? '(Vazio)' : _historico.join(' , '),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4)),
          const SizedBox(height: 20.0),
          Text('Total:',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.2),
              child: Text('$_total',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4))
        ]));
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header',
                  style: TextStyle(color: Colors.white, fontSize: 24))),
          ListTile(
              leading: Icon(Icons.clear),
              title: Text('Zerar Contador'),
              onTap: _zerar),
          ListTile(
              leading: Icon(Icons.swap_calls),
              title: Text('Inverter Contador'),
              onTap: _inverter),
          ListTile(
              leading: Icon(Icons.memory),
              title: Text('Memorizar Contador'),
              onTap: _memorizar)
        ],
      ),
    );
  }

  void _incrementar() {
    setState(() {
      if (_incrementando) {
        _contador++;
      } else {
        _contador--;
      }
    });
  }

  void _zerar() {
    Navigator.of(context).pop();
    setState(() {
      _contador = 0;
      _historico.clear();
      _total = 0;
    });
  }

  void _inverter() {
    Navigator.of(context).pop();
    setState(() {
      _incrementando = !_incrementando;
    });
  }

  void _memorizar() {
    Navigator.of(context).pop();
    setState(() {
      _historico.add(_contador);
      _total = _historico.isEmpty ? 0 : _historico.reduce((a, b) => a + b);
    });
  }
}
