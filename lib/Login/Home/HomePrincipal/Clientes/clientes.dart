import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:url_launcher/url_launcher.dart';

class Clientes extends StatefulWidget {
  const Clientes({super.key});

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  List<String> listItems = <String>[
    "Externo",
    "Staicase",
  ];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();
  final TextEditingController _nomeTextEditingController =
      TextEditingController();
  final TextEditingController _detalhesTextEditingController =
      TextEditingController();
  final TextEditingController _whatsAppContatoTextEditingController =
      TextEditingController();
  final TextEditingController _tipoClienteTextEditingController =
      TextEditingController();

  String UID = FirebaseAuth.instance.currentUser!.uid.toString();

  /// Le o conteudo
  Stream<List<Dados>> leia() => FirebaseFirestore.instance
      .collection('Profissional')
      .doc(UID)
      .collection("Clientes")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Dados.fromJson(doc.data())).toList());

  Widget ListTileDados(Dados dados) => Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: cinza,
          ),
          //
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 35,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: azul,
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: Text(
                          dados.tipoCliente,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: cinzaClaro,
                          ),
                        ),
                      ),
                    ),

                    ///
                    SizedBox(
                      width: 5,
                    ),

                    ///
                    Container(
                      decoration: BoxDecoration(
                        color: cinzaEscuro,
                        borderRadius: BorderRadius.circular(
                          50,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: Text(
                          dados.nome,
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: cinzaClaro,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                    dados.detalhes,
                    style: GoogleFonts.roboto(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dados.data,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: cinzaEscuro,
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
                                  "whatsapp://send?phone=+${dados.whatsAppContato}&text=");

                              if (await canLaunchUrl(whatsappUrl)) {
                                await launchUrl(whatsappUrl);
                              } else {
                                throw 'Could not launch $whatsappUrl';
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
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
                              final solicitacaoCliente = FirebaseFirestore
                                  .instance
                                  .collection("Profissional")
                                  .doc(UID)
                                  .collection("Clientes")
                                  .doc(dados.id);

                              solicitacaoCliente.delete();

                              final snackBar = SnackBar(
                                backgroundColor: azul,
                                content: Text('Cliente excluido com sucesso'),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cinzaClaro,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          height: MediaQuery.sizeOf(context).height,
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
                      "Clientes",
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
                "Aqui você poderá organizar os seus clientes de trabalho",
                style: GoogleFonts.roboto(
                  color: cinzaEscuro,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: cinzaClaro,
                height: MediaQuery.of(context).size.height,
                child: StreamBuilder<List<Dados>>(
                  stream: leia(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wong! ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      final leiaDados = snapshot.data!;
                      return ListView.builder(
                        itemCount: leiaDados.length,
                        itemBuilder: (context, index) {
                          final dados = leiaDados[index];
                          return ListTileDados(dados);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: azul,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        label: Text(
          "Adicionar",
          style: GoogleFonts.roboto(
            fontSize: 20,
            color: cinzaClaro,
          ),
        ),
        icon: Icon(
          Icons.add,
          color: cinzaClaro,
        ),
        onPressed: () {
          popupAdicionarListaContato(context);
        },
      ),
    );
  }

  //

  //PopUp para adicionar o filtro de solicitação do Profissional
  Future popupAdicionarListaContato(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Adicionar",
            style: GoogleFonts.roboto(
              fontSize: 40,
              color: azul,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            height: MediaQuery.sizeOf(context).width * 0.8,
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Text("Adicionae o material conforme os campos abaixo"),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    style: GoogleFonts.roboto(
                      color: cinzaEscuro,
                      fontSize: 18,
                    ),
                    cursorColor: azul,
                    controller: _nomeTextEditingController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cinza,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: cinza,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: azul,
                          width: 3,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: vermelho,
                          width: 3,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: vermelho,
                          width: 3,
                        ),
                      ),
                      hintText: "Nome",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite algo no campo';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: GoogleFonts.roboto(
                      color: cinzaEscuro,
                      fontSize: 18,
                    ),
                    cursorColor: azul,
                    controller: _detalhesTextEditingController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cinza,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: cinza,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: azul,
                          width: 3,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: vermelho,
                          width: 3,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: vermelho,
                          width: 3,
                        ),
                      ),
                      hintText: "Detalhes",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite algo no campo';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: GoogleFonts.roboto(
                      color: cinzaEscuro,
                      fontSize: 18,
                    ),
                    cursorColor: azul,
                    controller: _whatsAppContatoTextEditingController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cinza,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: cinza,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: azul,
                          width: 3,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: vermelho,
                          width: 3,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: vermelho,
                          width: 3,
                        ),
                      ),
                      hintText: "WhatsApp",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite algo no campo';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TypeAheadFormField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _tipoClienteTextEditingController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: cinza,
                          suffixIcon: Icon(Icons.arrow_drop_down_sharp),
                          hintStyle: GoogleFonts.roboto(),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: vermelho,
                              width: 3,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: cinza,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: azul,
                              width: 3,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: vermelho,
                              width: 3,
                            ),
                          ),
                          hintText: "Profissional"),
                    ),
                    onSaved: (value) {
                      _tipoClienteTextEditingController.text = value.toString();
                    },
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !listItems.contains(value)) {
                        return 'Selecione um profisional ou serviço';
                      }
                      return null;
                    },
                    suggestionsCallback: (pattern) {
                      return listItems.where((option) =>
                          option.toLowerCase().contains(pattern.toLowerCase()));
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        _tipoClienteTextEditingController.text = suggestion;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ///Voltar
            ElevatedButton(
              child: Text(
                "Voltar",
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                backgroundColor: cinzaClaro,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            ///Confirmar
            FilledButton(
                child: Text(
                  "Confirmar",
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  backgroundColor: azul,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () async {
                  final isValidForm = formKey.currentState!.validate();
                  if (isValidForm) {
                    final docRef = _firestore
                        .collection('Profissional')
                        .doc(UID)
                        .collection("Clientes")
                        .doc();

                    final id = docRef.id;

                    //data atual
                    final DateTime now = DateTime.now();
                    final DateFormat formatter = DateFormat('dd/MM/yyyy');
                    final String dataFormatada = formatter.format(now);

                    await docRef.set({
                      'Id': id,
                      'Nome': _nomeTextEditingController.text,
                      'Detalhes': _detalhesTextEditingController.text,
                      'WhatsAppContato':
                          _whatsAppContatoTextEditingController.text,
                      'TipoCliente': _tipoClienteTextEditingController.text,
                      'Data': dataFormatada,
                    }, SetOptions(merge: true));

                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      );
}

//Leitura dos Dados
class Dados {
  String id;
  final String nome;
  final String detalhes;
  final String whatsAppContato;
  final String tipoCliente;
  final String data;

  Dados({
    this.id = '',
    required this.nome,
    required this.detalhes,
    required this.whatsAppContato,
    required this.tipoCliente,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Nome': nome,
        'Detalhes': detalhes,
        'WhatsAppContato': whatsAppContato,
        'TipoCliente': tipoCliente,
        'Data': data,
      };

  static Dados fromJson(Map<String, dynamic> json) => Dados(
        id: json["Id"] ?? '',
        nome: json["Nome"] ?? '',
        detalhes: json['Detalhes'] ?? '',
        whatsAppContato: json['WhatsAppContato'] ?? '',
        tipoCliente: json['TipoCliente'] ?? '',
        data: json['Data'] ?? '',
      );
}
