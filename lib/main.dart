import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
        appBar: AppBar(
          title: Text('Transferências'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    ));

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemTransferencia(Transferencia(200.00, 1000)),
        ItemTransferencia(Transferencia(300.00, 2000)),
        ItemTransferencia(Transferencia(250.00, 2500)),
      ],
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
}
