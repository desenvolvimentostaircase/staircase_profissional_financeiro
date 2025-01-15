import 'package:flutter/material.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:profissional/Dashboard/Servicos/despesasServico.dart';
import 'package:profissional/Dashboard/Servicos/ganhosServico.dart';

showModalDeletar(
  BuildContext context, {
  required String tipo,
  String? idDespesa,
  String? idGanho,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowModalDeletar(
          idGanho: idGanho,
          idDespesa: idDespesa,
          tipo: tipo,
        );
      });
}

class ShowModalDeletar extends StatefulWidget {
  final String? idGanho;
  final String? idDespesa;
  final String? tipo;
  const ShowModalDeletar({super.key, this.idGanho, this.tipo, this.idDespesa});

  @override
  State<ShowModalDeletar> createState() => _ShowModalDeletarState();
}

class _ShowModalDeletarState extends State<ShowModalDeletar> {
  final GanhosServico _ganhosServico = GanhosServico();
  final DespesasServico _despesasServico = DespesasServico();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deletar",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Realmente deseja deletar?",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      actions: [
        SizedBox(
          height: 50,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.tipo == 'ganho') {
                    _ganhosServico.removerGanhos(idGanho: widget.idGanho);
                    Navigator.of(context).pop();
                  } else if (widget.tipo == 'despesa') {
                    _despesasServico.removerDespesas(
                        idDespesa: widget.idDespesa);
                    Navigator.of(context).pop();
                  }
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
    );
  }
}
