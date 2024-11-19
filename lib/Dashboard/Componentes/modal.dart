import 'package:flutter/material.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:profissional/Dashboard/Model/ganhos_modelo.dart';
import 'package:profissional/Dashboard/Servicos/ganhos_servico.dart';
import 'package:uuid/uuid.dart';

showModal(BuildContext context, {GanhosModelo? ganho}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowModal(
          ganhosModelo: ganho,
        );
      });
}

class ShowModal extends StatefulWidget {
  final GanhosModelo? ganhosModelo;
  const ShowModal({super.key, this.ganhosModelo});

  @override
  State<ShowModal> createState() => _ShowModalState();
}

class _ShowModalState extends State<ShowModal> {
  GanhosServico _ganhosServico = GanhosServico();
  DateTime? dataSelecionadaGlobal;

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _nomeClienteController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();

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

    if (widget.ganhosModelo != null) {
      _tituloController.text = widget.ganhosModelo!.titulo;
      _descricaoController.text = widget.ganhosModelo!.descricao;
      _dataController.text =
          "${widget.ganhosModelo!.data.day}/${widget.ganhosModelo!.data.month}/${widget.ganhosModelo!.data.year}";
      _valorController.text = widget.ganhosModelo!.valor;
      _nomeClienteController.text = widget.ganhosModelo!.nomeCliente;
      _whatsappController.text = widget.ganhosModelo!.whatsapp;
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
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _valorController,
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
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: cinza,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    width: 200,
                    height: 10,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _nomeClienteController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Nome do cliente*",
                    filled: true,
                    fillColor: cinza,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _whatsappController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Whatsapp*",
                    filled: true,
                    fillColor: cinza,
                  ),
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
    String nomeCliente = _nomeClienteController.text;
    String whatsapp = _whatsappController.text;

    GanhosModelo ganhosModelo = GanhosModelo(
      id: Uuid().v1(),
      titulo: titulo,
      descricao: descricao,
      data: data!,
      valor: valor,
      nomeCliente: nomeCliente,
      whatsapp: whatsapp,
    );

    if (widget.ganhosModelo != null) {
      ganhosModelo.id = widget.ganhosModelo!.id;
    }

    await _ganhosServico.adicionarGanhos(ganhosModelo);

    Navigator.of(context).pop();
  }
}
