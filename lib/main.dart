import 'package:flutter/material.dart';

void main() => runApp(MobClinic());

class MobClinic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando transferência'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _controladorCampoNumeroConta,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                labelText: 'Numéro da conta',
                hintText: '0000',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _controladorCampoValor,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                labelText: 'Valor',
                hintText: '000.0',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            child: Text('Confirmar'),
            onPressed: () {
              final int nConta =
                  int.tryParse(_controladorCampoNumeroConta.text);
              final double nValor =
                  double.tryParse(_controladorCampoValor.text);
              if (nConta != null && nValor != null) {
                final transferenciaCriada = Transferencia(nValor, nConta);
                debugPrint('$transferenciaCriada');
              }
            },
          )
        ],
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(200.00, 1000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;
  const ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.nomeroConta.toString()),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
    ));
  }
}

class Transferencia {
  final double valor;
  final int nomeroConta;

  Transferencia(this.valor, this.nomeroConta);

  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $nomeroConta';
  }
}
