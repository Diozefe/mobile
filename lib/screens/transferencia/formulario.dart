import 'package:flutter/material.dart';
import 'package:mobclinic/components/editor.dart';
import 'package:mobclinic/models/transferencia.dart';

const _tituloAppBar = 'Criando transferência';
const _rotuloCampoConta = 'Número da conta';
const _rotuloCampoValor = 'Valor';
const _dicaConta = '00000';
const _dicaValor = '00,00';
const _textBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                controlador: _controladorCampoNumeroConta,
                rotulo: _rotuloCampoConta,
                dica: _dicaConta),
            Editor(
                controlador: _controladorCampoValor,
                rotulo: _rotuloCampoValor,
                dica: _dicaValor,
                icone: Icons.monetization_on),
            ElevatedButton(
              child: Text(_textBotaoConfirmar),
              onPressed: () => _criaTransferencia(context),
            )
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int nConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double nValor = double.tryParse(_controladorCampoValor.text);
    if (nConta != null && nValor != null) {
      final transferenciaCriada = Transferencia(nValor, nConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
