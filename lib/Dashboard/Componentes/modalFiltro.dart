import 'package:flutter/material.dart';
import 'package:profissional/Cores/cores.dart';

showModalFiltro(BuildContext context,
    void Function(DateTime dataInicio, DateTime dataFim) onFiltroConfirmado) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return ShowModalFiltro(
          onFiltroConfirmado: onFiltroConfirmado,
        );
      });
}

class ShowModalFiltro extends StatefulWidget {
  const ShowModalFiltro({super.key, required this.onFiltroConfirmado});
  final void Function(DateTime dataInicio, DateTime dataFim) onFiltroConfirmado;

  @override
  State<ShowModalFiltro> createState() => _ShowModalFiltroState();
}

class _ShowModalFiltroState extends State<ShowModalFiltro> {
  final TextEditingController _dataInicialController = TextEditingController();
  final TextEditingController _dataFinalController = TextEditingController();

  DateTime? dataInicio;
  DateTime? dataFim;

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
            "Filtro",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Filtre um período para análise",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      actions: [
        Form(
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                controller: _dataInicialController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Selecione a data inicial",
                  prefixIcon: Icon(Icons.calendar_today),
                  filled: true,
                  fillColor: cinza,
                ),
                onTap: () async {
                  dataInicio = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (dataInicio != null) {
                    setState(() {
                      _dataInicialController.text =
                          "${dataInicio!.day}/${dataInicio!.month}/${dataInicio!.year}";
                    });
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                readOnly: true,
                controller: _dataFinalController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Selecione a data final",
                  prefixIcon: Icon(Icons.calendar_today),
                  filled: true,
                  fillColor: cinza,
                ),
                onTap: () async {
                  dataFim = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (dataFim != null) {
                    setState(() {
                      _dataFinalController.text =
                          "${dataFim!.day}/${dataFim!.month}/${dataFim!.year}";
                    });
                  }
                },
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
                  if (dataInicio != null && dataFim != null) {
                    widget.onFiltroConfirmado(dataInicio!, dataFim!);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text("Por favor, selecione ambas as datas.")),
                    );
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
