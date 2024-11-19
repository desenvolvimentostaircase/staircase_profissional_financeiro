import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:profissional/Cores/cores.dart';

class Materiais extends StatefulWidget {
  const Materiais({super.key});

  @override
  State<Materiais> createState() => _MateriaisState();
}

class _MateriaisState extends State<Materiais> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();
  final TextEditingController _tituloTextEditingController =
      TextEditingController();
  final TextEditingController _detalhesTextEditingController =
      TextEditingController();
  final TextEditingController _medidaTextEditingController =
      TextEditingController();

  String UID = FirebaseAuth.instance.currentUser!.uid.toString();

  /// Le o conteudo
  Stream<List<Dados>> leia() => FirebaseFirestore.instance
      .collection('Profissional')
      .doc(UID)
      .collection("Materiais")
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
                          dados.titulo,
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
                          dados.medida,
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
                                  .collection("Materiais")
                                  .doc(dados.id);

                              solicitacaoCliente.delete();

                              final snackBar = SnackBar(
                                backgroundColor: azul,
                                content:
                                    Text('Solicitação excluido com sucesso'),
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
                      "Materiais",
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
                "Aqui você opderá organiazr os seus materiais de trabalho",
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

                  //Titulo
                  TextFormField(
                    style: GoogleFonts.roboto(
                      color: cinzaEscuro,
                      fontSize: 18,
                    ),
                    cursorColor: azul,
                    controller: _tituloTextEditingController,
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
                      hintText: "Titulo",
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
                  //Detalhes
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
                  //Medida
                  TextFormField(
                    style: GoogleFonts.roboto(
                      color: cinzaEscuro,
                      fontSize: 18,
                    ),
                    cursorColor: azul,
                    controller: _medidaTextEditingController,
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
                      hintText: "Medida (Unidade ou kg)",
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

                //data atual
                final DateTime now = DateTime.now();
                final DateFormat formatter = DateFormat('dd/MM/yyyy');
                final String dataFormatada = formatter.format(now);

                if (isValidForm) {
                  final docRef = _firestore
                      .collection('Profissional')
                      .doc(UID)
                      .collection("Materiais")
                      .doc();

                  final id = docRef.id;

                  await docRef.set({
                    'Titulo': _tituloTextEditingController.text,
                    'Detalhes': _detalhesTextEditingController.text,
                    'Medida': _medidaTextEditingController.text,
                    'Id': id,
                    'Data': dataFormatada,
                  }, SetOptions(merge: true));

                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      );
}

//Leitura dos Dados
class Dados {
  String id;
  final String titulo;
  final String medida;
  final String detalhes;
  final String data;

  Dados({
    this.id = '',
    required this.titulo,
    required this.medida,
    required this.detalhes,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Titulo': titulo,
        'Medida': medida,
        'Detalhes': detalhes,
        'Data': data,
      };

  static Dados fromJson(Map<String, dynamic> json) => Dados(
        id: json["Id"] ?? '',
        titulo: json["Titulo"] ?? '',
        medida: json['Medida'] ?? '',
        detalhes: json['Detalhes'] ?? '',
        data: json['Data'] ?? '',
      );
}
