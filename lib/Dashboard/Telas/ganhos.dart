import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profissional/Dashboard/Componentes/modal.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:profissional/Dashboard/Componentes/modalFiltro.dart';
import 'package:profissional/Dashboard/Componentes/modal_deletar.dart';
import 'package:profissional/Dashboard/Model/ganhos_modelo.dart';
import 'package:profissional/Dashboard/Servicos/ganhos_servico.dart';

class HomeGanhos extends StatefulWidget {
  const HomeGanhos({super.key});

  @override
  State<HomeGanhos> createState() => _HomeGanhosState();
}

class _HomeGanhosState extends State<HomeGanhos> {
  final GanhosServico _ganhosServico = GanhosServico();

  DateTime? dataInicio;
  DateTime? dataFim;

  late Stream<QuerySnapshot<Map<String, dynamic>>> streamAtual;
  @override
  void initState() {
    super.initState();
    streamAtual = _ganhosServico.conectarStreamGanhos();
  }

  void atualizarFiltro(DateTime start, DateTime end) {
    setState(() {
      dataInicio = start;
      dataFim = end;
    });

    streamAtual =
        _ganhosServico.conectarStreamGanhosFiltrados(dataInicio!, dataFim!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModal(
            context,
          );
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
                    SizedBox(width: 10),
                    Text("Total",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        )),
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
                  Text("Período: 01/10 a 31/10"),
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
                        SizedBox(width: 5),
                        Text("5000,00"),
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
                      child: Text("Falha ao carregar os ganhos"),
                    );
                  } else {
                    if (snapshot.hasData &&
                        snapshot.data != null &&
                        snapshot.data!.docs.isNotEmpty) {
                      List<GanhosModelo> listaGanhos = [];

                      for (var doc in snapshot.data!.docs) {
                        listaGanhos.add(GanhosModelo.fromMap(doc.data()));
                      }

                      return ListView(
                        children: List.generate(listaGanhos.length, (index) {
                          GanhosModelo ganhosModelo = listaGanhos[index];
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
                                        ganhosModelo.titulo,
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: azul,
                                          radius: 20,
                                          child: IconButton(
                                            onPressed: () {
                                              showModal(context,
                                                  ganho: ganhosModelo);
                                            },
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
                                            onPressed: () {
                                              showModalDeletar(context,
                                                  idGanho: ganhosModelo.id);
                                            },
                                            icon: Icon(Icons.delete),
                                            iconSize: 20,
                                            color: branco,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(ganhosModelo.descricao),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(ganhosModelo.dataFormatada),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(ganhosModelo.nomeCliente),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: verde,
                                          radius: 20,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: FaIcon(
                                                FontAwesomeIcons.whatsapp),
                                            iconSize: 20,
                                            color: branco,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: branco,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "\$",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Text(ganhosModelo.valor),
                                            ],
                                          ),
                                        ),
                                      ],
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
                        child: Text("Nehnum registro foi e encontrado"),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
