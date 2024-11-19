import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home_principal.dart';

class BuscaSolicitacao extends StatefulWidget {
  final dynamic profissional;
  final dynamic cidadeEstado;
  final dynamic id;

  const BuscaSolicitacao(this.profissional, this.cidadeEstado, this.id,
      {Key? key})
      : super(key: key);

  @override
  State<BuscaSolicitacao> createState() => _BuscaSolicitacaoState();
}

class _BuscaSolicitacaoState extends State<BuscaSolicitacao> {
  /// Le o conteudo
  Stream<List<DadosSolicitacaoCliente>> leiaDadosSolictacaoCliente() =>
      FirebaseFirestore.instance
          .collection('Solicitação Geral')
          .doc(widget.profissional)
          .collection(widget.cidadeEstado)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => DadosSolicitacaoCliente.fromJson(doc.data()))
              .toList());

  @override
  Widget build(BuildContext context) {
    Widget ListTileDadosSolictacaoCliente(
            DadosSolicitacaoCliente dadosSolictacaoCliente) =>
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: cinza,
            ),
            child: ListTile(
              title: Container(
                height: 35,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: cinzaEscuro,
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 4,
                          bottom: 4,
                        ),
                        child: Text(
                          dadosSolictacaoCliente.nome,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: cinzaClaro,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      dadosSolictacaoCliente.solicitacao,
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dadosSolictacaoCliente.data,
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: azul,
                            ),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.whatsapp,
                                color: cinzaClaro,
                              ),
                              onPressed: () async {
                                Uri whatsappUrl = Uri.parse(
                                    "whatsapp://send?phone=+55${dadosSolictacaoCliente.whatsAppContato}&text=Olá ${dadosSolictacaoCliente.nome}, recebi a sua solicitação: **${dadosSolictacaoCliente.solicitacao}** do dia **${dadosSolictacaoCliente.data}**.\n\nAinda precisa de um profissional?");

                                if (await canLaunchUrl(whatsappUrl)) {
                                  await launchUrl(whatsappUrl);
                                } else {
                                  throw 'Could not launch $whatsappUrl';
                                }
                              },
                            ),
                          ),
                          //
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: azul,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.bookmark_add,
                                color: cinzaClaro,
                              ),
                              onPressed: () {
                                final dadosSolictacaoGeralCliente =
                                    DadosSolicitacaoCliente(
                                  cidadeEstado: widget.cidadeEstado,
                                  profissional: widget.profissional,
                                  data: dadosSolictacaoCliente.data,
                                  solicitacao:
                                      dadosSolictacaoCliente.solicitacao,
                                  nome: dadosSolictacaoCliente.nome,
                                  whatsAppContato:
                                      dadosSolictacaoCliente.whatsAppContato,
                                );

                                createSolicitacaoCliente(
                                    dadosSolictacaoGeralCliente);
                                try {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'Solicitação salva com sucesso com sucesso!'),
                                  ));
                                  Navigator.pop(context);
                                } catch (e) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Erro : $e'),
                                  ));
                                }
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

    return Scaffold(
      backgroundColor: cinzaClaro,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: ListView(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: azul,
                      ),
                      height: 40,
                      width: 40,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: cinzaClaro,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Filtro",
                      style: GoogleFonts.roboto(
                        color: azul,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Aqui você receberá mensagens de clientes buscando por algum profissional para alguma demanda",
                style: GoogleFonts.roboto(
                  color: cinzaEscuro,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //Filtro exemplo
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: cinza,
                ),
                child: ListTile(
                  title: Text(
                    widget.profissional,
                    style: GoogleFonts.roboto(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.cidadeEstado,
                    style: GoogleFonts.roboto(fontSize: 18),
                  ),
                  trailing: widget.id == ''
                      ? IconButton(
                          icon: Icon(
                            Icons.add,
                            color: azul,
                          ),
                          color: vermelho,
                          onPressed: () {
                            final buscar = Dados(
                              cidadeEstado: widget.cidadeEstado,
                              profissional: widget.profissional,
                            );
                            createBuscar(buscar);

                            final snackBar = SnackBar(
                              backgroundColor: azul,
                              content: Text('Filtro salvo com sucesso'),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: vermelho,
                          onPressed: () {
                            String UID = FirebaseAuth.instance.currentUser!.uid
                                .toString();

                            //Deletar no banco
                            final contatoSalvos = FirebaseFirestore.instance
                                .collection("Profissional")
                                .doc(UID)
                                .collection("SolicitacoesFiltrosSalvos")
                                .doc(widget.id);

                            contatoSalvos.delete();
                            Navigator.pop(context);

                            final snackBar = SnackBar(
                              backgroundColor: azul,
                              content: Text('Filtro excluido com sucesso'),
                            );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                        ),
                ),
              ),

              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, right: 60),
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: cinza,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // Lista de solictações de clientes
              Container(
                color: cinzaClaro,
                height: MediaQuery.of(context).size.height * 0.85,
                child: StreamBuilder<List<DadosSolicitacaoCliente>>(
                  stream: leiaDadosSolictacaoCliente(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wong! ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      final leiaDadosSolictacaoCliente = snapshot.data!;
                      return ListView.builder(
                        itemCount: leiaDadosSolictacaoCliente.length,
                        itemBuilder: (context, index) {
                          final dadosSolictacaoCliente =
                              leiaDadosSolictacaoCliente[index];
                          return ListTileDadosSolictacaoCliente(
                              dadosSolictacaoCliente);
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createBuscar(Dados buscar) async {
    String UID = FirebaseAuth.instance.currentUser!.uid.toString();

    //
    //Inserir ou criar informação no banco de dados
    final docBuscar = FirebaseFirestore.instance
        .collection('Profissional')
        .doc(UID)
        .collection("SolicitacoesFiltrosSalvos")
        .doc();

    buscar.id = docBuscar.id;

    final json = buscar.toJson();
    await docBuscar.set(json);
  }

  Future createSolicitacaoCliente(
      DadosSolicitacaoCliente dadosSolictacaoCliente) async {
    String UID = FirebaseAuth.instance.currentUser!.uid.toString();

    //
    //Inserir ou criar informação no banco de dados
    final docBuscar = FirebaseFirestore.instance
        .collection('Profissional')
        .doc(UID)
        .collection("SalvosSolicitacoes")
        .doc();

    dadosSolictacaoCliente.id = docBuscar.id;

    final json = dadosSolictacaoCliente.toJson();
    await docBuscar.set(json);
  }
}

class DadosSolicitacaoCliente {
  String id;
  final String profissional;
  final String cidadeEstado;
  final String solicitacao;
  final String nome;
  final String data;
  final String whatsAppContato;

  DadosSolicitacaoCliente({
    this.id = '',
    required this.profissional,
    required this.cidadeEstado,
    required this.solicitacao,
    required this.nome,
    required this.data,
    required this.whatsAppContato,
  });

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Profissional': profissional,
        'CidadeEstado': cidadeEstado,
        'Solicitação': solicitacao,
        'Nome': nome,
        'Data': data,
        'WhatsAppContato': whatsAppContato,
      };

  static DadosSolicitacaoCliente fromJson(Map<String, dynamic> json) =>
      DadosSolicitacaoCliente(
        id: json["Id"] ?? '',
        profissional: json['Profissional'] ?? '',
        cidadeEstado: json['CidadeEstado'] ?? '',
        solicitacao: json['Solicitação'] ?? '',
        nome: json['Nome'] ?? '',
        data: json['Data'] ?? '',
        whatsAppContato: json['WhatsAppContato'] ?? '',
      );
}
