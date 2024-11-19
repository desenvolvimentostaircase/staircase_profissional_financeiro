import 'package:flutter/material.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:profissional/Dashboard/Servicos/ganhos_servico.dart';

showModalDeletar(BuildContext context, {required String idGanho}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowModalDeletar(
          idGanho: idGanho,
        );
      });
}

class ShowModalDeletar extends StatefulWidget {
  final String? idGanho;
  const ShowModalDeletar({super.key, this.idGanho});

  @override
  State<ShowModalDeletar> createState() => _ShowModalDeletarState();
}

class _ShowModalDeletarState extends State<ShowModalDeletar> {
  final GanhosServico _ganhosServico = GanhosServico();

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
                  _ganhosServico.removerGanhos(idGanho: widget.idGanho);
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
