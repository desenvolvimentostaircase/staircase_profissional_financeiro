import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Cores/cores.dart';

class Negocios extends StatefulWidget {
  const Negocios({super.key});

  @override
  State<Negocios> createState() => _NegociosState();
}

class _NegociosState extends State<Negocios> {

   List<String> listItemsSimOuNao = <String>["Sim", "Não"];
  
 
  final formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //
  final TextEditingController _cnpjTextEditingController =
      TextEditingController();
  //
  final TextEditingController _emiteNotaFiscalTextEditingController =
      TextEditingController();

  Widget ListTileBuscar(PerfilDados dados) => Padding(
        padding: EdgeInsets.all(25),
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.9,
          child: ListView(
            children: [
              Row(
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
                    "Negócios",
                    style: GoogleFonts.roboto(
                      color: azul,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Aqui é onde ficam algums informações a mais sobre você",
                  style: GoogleFonts.roboto(
                    color: cinzaEscuro,
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: 20),

             
              
              //CNPJ
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "CNPJ",
                  style: GoogleFonts.roboto(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: cinza,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                  child: ListTile(
                    trailing: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: azul,
                      ),
                      onPressed: () {
                        popUpEditarCNPJ(context);
                      },
                      color: azul,
                    ),
                    title: Text(
                      "${dados.cnpj}",
                      style: GoogleFonts.roboto(
                        color: cinzaEscuro,
                        fontSize: 17,
                      ),
                    ),
                    leading: Icon(
                      Icons.business_rounded,
                      color: cinzaEscuro,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              //Emite nota fiscal?
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Emite nota fiscal?",
                  style: GoogleFonts.roboto(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: cinza,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                  child: ListTile(
                    trailing: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: azul,
                      ),
                      onPressed: () {
                        popUpEditarEmiteNotaFiscal(context);
                      },
                      color: azul,
                    ),
                    title: Text(
                      "${dados.emiteNotaFiscal}",
                      style: GoogleFonts.roboto(
                        color: cinzaEscuro,
                        fontSize: 17,
                      ),
                    ),
                    leading: Icon(
                      Icons.sticky_note_2,
                      color: cinzaEscuro,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //
            ],
          ),
        ),
      );

  //Editar WhatsAppContato01
  Future popUpEditarEmiteNotaFiscal(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Nota fiscal?",
            style: GoogleFonts.roboto(
              fontSize: 40,
              color: azul,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 180,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Você emite nota fiscal?",
                    style: GoogleFonts.roboto(
                      color: cinzaEscuro,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: TypeAheadFormField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _emiteNotaFiscalTextEditingController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: cinza,
                          suffixIconColor: azul,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _emiteNotaFiscalTextEditingController.clear();
                              });
                            },
                            icon: Icon(
                              Icons.close,
                            ),
                          ),
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
                          hintText: "Selecione"),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !listItemsSimOuNao.contains(value)) {
                        return 'Selecione uma opção';
                      }
                      return null;
                    },
                    suggestionsCallback: (pattern) {
                      return listItemsSimOuNao.where((option) =>
                          option.toLowerCase().contains(pattern.toLowerCase()));
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        _emiteNotaFiscalTextEditingController.text = suggestion;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            FilledButton(
              child: Text(
                "Voltar",
                style: GoogleFonts.roboto(
                  color: azul,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 10,
                ),
                backgroundColor: cinzaClaro,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color: azul,
                    width: 2,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            ///
            FilledButton(
              child: Text(
                "Confirmar",
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 10,
                ),
                backgroundColor: azul,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                final isValidForm = formKey.currentState!.validate();

                if (isValidForm) {
                  _updateEmiteNotaFiscal();
                }
              },
            ),
          ],
        ),
      );

  void _updateEmiteNotaFiscal() async {
    //Pegar o numero do WhatsApp no banco de dados
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Profissional')
        .doc(UID)
        .collection('Perfil')
        .doc('Dados')
        .get();
    String email = doc['Email'];

    try {
      await _firestore
          .collection('Profissional')
          .doc(UID)
          .collection('Perfil')
          .doc('Dados')
          .set({
        'EmiteNotaFiscal': _emiteNotaFiscalTextEditingController.text,
      }, SetOptions(merge: true));
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'EmiteNotaFiscal': _emiteNotaFiscalTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('"Emite nota fiscal" atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar o nome: $e'),
      ));
    }
  }


  //Editar CNPJ
  Future popUpEditarCNPJ(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "CNPJ",
            style: GoogleFonts.roboto(
              fontSize: 40,
              color: azul,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: 180,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Digite aqui o seu CNPJ",
                    style: GoogleFonts.roboto(
                      color: cinzaEscuro,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    style: GoogleFonts.roboto(
                      color: cinzaEscuro,
                      fontSize: 18,
                    ),
                    cursorColor: azul,
                    controller: _cnpjTextEditingController,
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
                      hintText: "Digite",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo vazio';
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
          actions: [
            FilledButton(
              child: Text(
                "Voltar",
                style: GoogleFonts.roboto(
                  color: azul,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 10,
                ),
                backgroundColor: cinzaClaro,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                    color: azul,
                    width: 2,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            ///
            FilledButton(
              child: Text(
                "Confirmar",
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 10,
                ),
                backgroundColor: azul,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                final isValidForm = formKey.currentState!.validate();

                if (isValidForm) {
                  _updateCNPJ();
                }
              },
            ),
          ],
        ),
      );

  void _updateCNPJ() async {
    //Pegar o numero do WhatsApp no banco de dados
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Profissional')
        .doc(UID)
        .collection('Perfil')
        .doc('Dados')
        .get();
    String email = doc['Email'];

    try {
      await _firestore
          .collection('Profissional')
          .doc(UID)
          .collection('Perfil')
          .doc('Dados')
          .update({
        'CNPJ': _cnpjTextEditingController.text,
      });
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'CNPJ': _cnpjTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('CNPJ atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar o nome: $e'),
      ));
    }
  }


  String UID = FirebaseAuth.instance.currentUser!.uid.toString();

  /// Le o conteudo local
  Stream<List<PerfilDados>> leiaBuscar() => FirebaseFirestore.instance
      .collection('Profissional')
      .doc(UID)
      .collection("Perfil")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => PerfilDados.fromJson(doc.data()))
          .toList());









  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: cinzaClaro,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<List<PerfilDados>>(
          stream: leiaBuscar(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wong! ${snapshot.error}");
            } else if (snapshot.hasData) {
              final leiaBuscar = snapshot.data!;
              return ListView.builder(
                itemCount: leiaBuscar.length,
                itemBuilder: (context, index) {
                  final buscar = leiaBuscar[index];
                  return ListTileBuscar(buscar);
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
    );
  }
}

//Informações do cliente
class PerfilDados {
  //Contato

  final String cnpj;
  final String emiteNotaFiscal;

  PerfilDados({
    this.cnpj = '',
    this.emiteNotaFiscal = '',
  });

  Map<String, dynamic> toJson() => {
        'CNPJ': cnpj,
        'EmiteNotaFiscal': emiteNotaFiscal,
      };

  static PerfilDados fromJson(Map<String, dynamic> json) => PerfilDados(
        cnpj: json['CNPJ'] ?? '',
        emiteNotaFiscal: json['EmiteNotaFiscal'] ?? '',
      );
}
