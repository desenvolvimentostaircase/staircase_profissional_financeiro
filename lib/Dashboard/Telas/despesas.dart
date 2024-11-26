import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:profissional/Dashboard/Componentes/modalDespesas.dart';
import 'package:profissional/Dashboard/Componentes/modalFiltro.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:profissional/Dashboard/Model/despesasModelo.dart';
import 'package:profissional/Dashboard/Servicos/despesasServico.dart';

class HomeDespesas extends StatefulWidget {
  const HomeDespesas({super.key});

  @override
  State<HomeDespesas> createState() => _HomeDespesasState();
}

class _HomeDespesasState extends State<HomeDespesas> {
  final DespesasServico _despesasServico = DespesasServico();

  DateTime? dataInicio;
  DateTime? dataFim;
  String? dataPeriodo;
  double? totalDespesasGlobal;

  late Stream<QuerySnapshot<Map<String, dynamic>>> streamAtual;
  @override
  void initState() {
    super.initState();
    streamAtual = _despesasServico.conectarStreamDespesas();
    dataPeriodo = "Todo período";
  }

  void atualizarFiltro(DateTime start, DateTime end) {
    setState(() {
      dataInicio = start;
      dataFim = end;
    });

    streamAtual =
        _despesasServico.conectarStreamDespesasFiltradas(dataInicio!, dataFim!);
    dataPeriodo =
        "${dataInicio!.day}/${dataInicio!.month} a ${dataFim!.day}/${dataFim!.month}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalDespesas(context);
        },
        label: Text("Adicionar"),
        icon: Icon(Icons.add),
        backgroundColor: azul,
        foregroundColor: branco,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
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
                )
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
                        Text("1000,00")
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
            Expanded(
              child: StreamBuilder(
                  stream: streamAtual,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Falha ao carregas as despesas"),
                      );
                    } else {
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data!.docs.isNotEmpty) {
                        List<DespesasModelo> listaDespesas = [];

                        for (var doc in snapshot.data!.docs) {
                          listaDespesas.add(DespesasModelo.fromMap(doc.data()));
                        }

                        double totalDespesas =
                            listaDespesas.fold(0, (soma, despesa) {
                          return soma! + (despesa.valor ?? 0);
                        });

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            totalDespesasGlobal = totalDespesas;
                          });
                        });

                        return ListView(
                          children:
                              List.generate(listaDespesas.length, (index) {
                            DespesasModelo despesasModelo =
                                listaDespesas[index];

                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: cinza,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          despesasModelo.titulo,
                                          style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: azul,
                                            radius: 20,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.edit),
                                              iconSize: 20,
                                              color: branco,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: vermelho,
                                            radius: 20,
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.delete),
                                              iconSize: 20,
                                              color: branco,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(despesasModelo.descricao),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(despesasModelo.dataFormatada),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: branco,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "\$",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              NumberFormat("#,##0.00", "pt_BR")
                                                  .format(despesasModelo.valor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                        );
                      } else {
                        return Center(
                          child: Text("Nenhum registro foi encontrado"),
                        );
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
