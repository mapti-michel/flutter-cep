import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pesquisa_cep/services/via_cep_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _searchCepController = TextEditingController();
  bool _loading = false;
  bool _enableField = true;
  String? _result;

  @override
  void dispose() {
    super.dispose();
    _searchCepController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar CEP'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSearchCepTextField(),
            _buildSearchCepButton(),
            _buildResultForm()
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCepTextField() {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(labelText: 'Cep'),
      controller: _searchCepController,
      enabled: _enableField,
    );
  }

  Widget _buildSearchCepButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: FloatingActionButton(
        onPressed: _searchCep,
        child: _loading ? _circularLoading() : Text('Consultar'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void _searching(bool enable) {
    setState(() {
      _result = enable ? '' : _result;
      _loading = enable;
      _enableField = !enable;
    });
  }

  Widget _circularLoading() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(),
    );
  }

  Future _searchCep() async {
    _searching(true);

    final cep = _searchCepController.text;

    final resultCep = await ViaCepService.fetchCep(cep: cep);
//    print(resultCep.localidade); // Exibindo somente a localidade no terminal

    setState(() {
      _result = resultCep.toJson();
    });

    _searching(false);
  }

  Widget _buildResultForm() {
    String msgNot = 'não foi preenchido';
    String localidade = '';
    String cep = '';
    String logradouro = '';
    String complemento = '';
    String bairro = '';
    String uf = '';
    String unidade = '';
    String ibge = '';
    String gia = '';
    if (_result != null) {
      cep = (_result != null ? jsonDecode(_result.toString()) : '')['cep'] ?? msgNot;
      logradouro = (_result != null ? jsonDecode(_result.toString()) : '')['logradouro'] ?? msgNot;
      complemento = (_result != null ? jsonDecode(_result.toString()) : '')['complemento'] ?? msgNot;
      bairro = (_result != null ? jsonDecode(_result.toString()) : '')['bairro'] ?? msgNot;
      localidade = (_result != null ? jsonDecode(_result.toString()) : '')['localidade'] ?? msgNot;
      uf = (_result != null ? jsonDecode(_result.toString()) : '')['uf'] ?? msgNot;
      unidade = (_result != null ? jsonDecode(_result.toString()) : '')['unidade'] ?? msgNot;
      ibge = (_result != null ? jsonDecode(_result.toString()) : '')['ibge'] ?? msgNot;
      gia = (_result != null ? jsonDecode(_result.toString()) : '')['gia'] ?? msgNot;
    }

    return Container(
      padding: EdgeInsets.only(top: 20.0),
//      child: Text(_result ?? ''),
      child: Column(children: [
        Row(
          children: [
            Text(
              'Cep: ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 16),
            ),
            Text(
              cep,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Uf: ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 16),
            ),
            Text(
              uf,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Localidade: ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 16),
            ),
            Text(
              localidade,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Bairro: ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 16),
            ),
            Text(
              bairro,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Logradouro: ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 16),
            ),
            Text(
              logradouro,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Complemento: ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 16),
            ),
            Text(
              complemento,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Unidade: ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 16),
            ),
            Text(
              unidade,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'IBGE: ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 16),
            ),
            Text(
              ibge,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Gia: ',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 16),
            ),
            Text(
              gia,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ]),


    );
  }
}
