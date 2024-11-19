import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:url_launcher/url_launcher.dart';

class Salvos extends StatefulWidget {
  const Salvos({super.key});

  @override
  State<Salvos> createState() => _SalvosState();
}

class _SalvosState extends State<Salvos> {
  Widget ListTileDadosSolictacaoCliente(
          DadosSolictacaoCliente dadosSolictacaoCliente) =>
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

                  ///
                  SizedBox(
                    width: 10,
                  ),

                  ///
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
                        dadosSolictacaoCliente.profissional,
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: cinzaClaro,
                        ),
                      ),
                    ),
                  ),

                  ///
                  SizedBox(
                    width: 10,
                  ),

                  ///
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
                        dadosSolictacaoCliente.cidadeEstado,
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
                            onPressed: () {
                              abrirWhatsApp(
                                dadosSolictacaoCliente.whatsAppContato,
                                dadosSolictacaoCliente.nome,
                                dadosSolictacaoCliente.data,
                                dadosSolictacaoCliente.solicitacao,
                              );
                            },
                          ),
                        ),
                        //
                        SizedBox(
                          width: 20,
                        ),

                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: vermelho,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: cinzaClaro,
                            ),
                            onPressed: () {
                              String UID = FirebaseAuth
                                  .instance.currentUser!.uid
                                  .toString();

                              //Deletar no banco
                              final contatoSalvos = FirebaseFirestore.instance
                                  .collection("Profissional")
                                  .doc(UID)
                                  .collection("SalvosSolicitacoes")
                                  .doc(dadosSolictacaoCliente.id);

                              contatoSalvos.delete();
                              

                              final snackBar = SnackBar(
                                backgroundColor: azul,
                                content: Text('Solicitação excluida com sucesso',style: GoogleFonts.roboto(),),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
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

  String UID = FirebaseAuth.instance.currentUser!.uid.toString();

  /// Le o conteudo
  Stream<List<DadosSolictacaoCliente>> leia() => FirebaseFirestore.instance
      .collection('Profissional')
      .doc(UID)
      .collection("SalvosSolicitacoes")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => DadosSolictacaoCliente.fromJson(doc.data()))
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cinzaClaro,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          child: ListView(
            children: [
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: azul,
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: cinzaClaro,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Salvos",
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
                "Aqui ficarão as solicitações salvas",
                style: GoogleFonts.roboto(
                  color: cinzaEscuro,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //Leitura dos filtros salvos
              Container(
                color: cinzaClaro,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<List<DadosSolictacaoCliente>>(
                  stream: leia(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wong! ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      final leiaDados = snapshot.data!;
                      return ListView.builder(
                        itemCount: leiaDados.length,
                        itemBuilder: (context, index) {
                          final dadosSolictacaoCliente = leiaDados[index];
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

  abrirWhatsApp(whatsApp, nome, data, solicitacao) async {
    Uri whatsappUrl = Uri.parse(
        "whatsapp://send?phone=+55$whatsApp&text=Olá $nome, recebi a sua solicitação: '$solicitacao' do dia $data.\nAinda precisa de um profissional?");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      throw 'Could not launch $whatsappUrl';
    }
  }
}

//Dados
class DadosSolictacaoCliente {
  String id;
  final String profissional;
  final String cidadeEstado;
  final String solicitacao;
  final String nome;
  final String data;
  final String whatsAppContato;

  DadosSolictacaoCliente({
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

  static DadosSolictacaoCliente fromJson(Map<String, dynamic> json) =>
      DadosSolictacaoCliente(
        id: json["Id"] ?? '',
        profissional: json['Profissional'] ?? '',
        cidadeEstado: json['CidadeEstado'] ?? '',
        solicitacao: json['Solicitação'] ?? '',
        nome: json['Nome'] ?? '',
        data: json['Data'] ?? '',
        whatsAppContato: json['WhatsAppContato'] ?? '',
      );
}
