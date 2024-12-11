import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:profissional/Dashboard/Model/despesasModelo.dart';
import 'package:profissional/Dashboard/Servicos/despesasServico.dart';
import 'package:uuid/uuid.dart';

showModalDespesas(BuildContext context, {DespesasModelo? despesa}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowModal(
          despesasModelo: despesa,
        );
      });
}

class ShowModal extends StatefulWidget {
  final DespesasModelo? despesasModelo;
  const ShowModal({super.key, this.despesasModelo});

  @override
  State<ShowModal> createState() => _ShowModalState();
}

class _ShowModalState extends State<ShowModal> {
  final _formKey = GlobalKey<FormState>();
  final DespesasServico _despesasServico = DespesasServico();
  DateTime? dataSelecionadaGlobal;

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  Future<void> _selecionarData(BuildContext context) async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (dataSelecionada != null) {
      setState(() {
        dataSelecionadaGlobal = dataSelecionada;
        _dataController.text =
            "${dataSelecionada.day}/${dataSelecionada.month}/${dataSelecionada.year}";
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.despesasModelo != null) {
      dataSelecionadaGlobal = widget.despesasModelo?.data;
      _tituloController.text = widget.despesasModelo!.titulo;
      _descricaoController.text = widget.despesasModelo!.descricao;
      _dataController.text =
          "${widget.despesasModelo!.data.day}/${widget.despesasModelo!.data.month}/${widget.despesasModelo!.data.year}";
      _valorController.text = widget.despesasModelo!.valor.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Adicionar",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Preenchar os campos do serviço",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              "(*)Campos obrigatórios",
              style: TextStyle(
                fontSize: 15,
                color: vermelho,
              ),
            ),
          ],
        ),
        actions: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Título*",
                    filled: true,
                    fillColor: cinza,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira um título";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _descricaoController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Descrição",
                    filled: true,
                    fillColor: cinza,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _dataController,
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Seleciona uma data*",
                    prefixIcon: Icon(Icons.calendar_today),
                    filled: true,
                    fillColor: cinza,
                  ),
                  onTap: () => _selecionarData(context),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira uma data";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _valorController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Valor*",
                    filled: true,
                    fillColor: cinza,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira um valor";
                    }

                    //Verfifica se o valor é um double
                    final doubleValue = double.tryParse(value);
                    if (doubleValue == null) {
                      return "Digite um número válido";
                    }

                    // Verifica se o valor possui mais de duas casas decimais
                    if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)) {
                      return "Digite um número com no máximo 2 casas decimais separado por '.' ";
                    }

                    return null; //campo válido
                  },
                  inputFormatters: [
                    //Permite apenas números e ponto decimal
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    enviarDados();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    backgroundColor: azul,
                  ),
                  child: Text(
                    "Confirmar",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: branco,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    side: BorderSide(
                      color: azul,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    "Voltar",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: azul,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  enviarDados() async {
    String titulo = _tituloController.text;
    String descricao = _descricaoController.text;
    DateTime? data = dataSelecionadaGlobal;
    String valor = _valorController.text;

    if (_formKey.currentState!.validate()) {
      DespesasModelo despesasModelo = DespesasModelo(
        id: Uuid().v1(),
        titulo: titulo,
        descricao: descricao,
        data: data!,
        valor: double.parse(valor),
      );

      if (widget.despesasModelo != null) {
        despesasModelo.id = widget.despesasModelo!.id;
      }

      await _despesasServico.adicionarDespesas(despesasModelo);
      Navigator.of(context).pop();
    }
  }
}
