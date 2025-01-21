import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:profissional/Dashboard/Componentes/modalFiltro.dart';
import 'package:profissional/Dashboard/Servicos/gerarExcel.dart';
import 'package:profissional/Dashboard/Servicos/gerarPDF.dart';

class HomeResultado extends StatefulWidget {
  const HomeResultado({super.key});

  @override
  State<HomeResultado> createState() => _HomeResultadoState();
}

class _HomeResultadoState extends State<HomeResultado> {
  DateTime? dataInicio;
  DateTime? dataFim;
  String? dataPeriodo = "Todo período";

  void atualizarFiltro(DateTime start, DateTime end) {
    setState(() {
      dataInicio = start;
      dataFim = end;
    });

    dataPeriodo =
        "${dataInicio!.day}/${dataInicio!.month} a ${dataFim!.day}/${dataFim!.month}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 25, left: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: cinza,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.zero,
                        iconSize: 20,
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Total",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                FilledButton.icon(
                  onPressed: () {
                    showModalFiltro(context, atualizarFiltro);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: azul,
                  ),
                  icon: Icon(Icons.filter_list),
                  label: Text("Filtro"),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cinza,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Período: $dataPeriodo"),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: branco,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("2000,00"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
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
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: cinza,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Extração",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                  Text("Extrair todo o conteúdo armazenado"),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      FilledButton.icon(
                        onPressed: () {
                          gerarPDF();
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: azul,
                        ),
                        icon: Icon(Icons.download_rounded),
                        label: Text("PDF"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FilledButton.icon(
                        onPressed: () {
                          gerarArquivoExcel();
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: azul,
                        ),
                        icon: Icon(Icons.download_rounded),
                        label: Text("Excel"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
