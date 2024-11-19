import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Cores/cores.dart';

class ContatoProfissicoes extends StatefulWidget {
  const ContatoProfissicoes({super.key});

  @override
  State<ContatoProfissicoes> createState() => _ContatoProfissicoesState();
}

class _ContatoProfissicoesState extends State<ContatoProfissicoes> {
  String _cidadeEstadoSelecionado = "";
  String _profissionalSelecionado = "";
  String detalhesProfissional = "";
  final formKey = GlobalKey<FormState>();
  final TextEditingController _profissionalTextEditingController =
      TextEditingController();
  final TextEditingController _cidadeEstadoTextEditingController =
      TextEditingController();

  String UID = FirebaseAuth.instance.currentUser!.uid.toString();

  /// Le o conteudo
  Stream<List<Dados>> leia() => FirebaseFirestore.instance
      .collection('Profissional')
      .doc(UID)
      .collection("ListaContato")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Dados.fromJson(doc.data())).toList());

  List<String> listItemsCidadeEstado = <String>[
    "Três Lagoas - MS",
  ];

  List<String> listItemsProfissional = <String>[
    "Advogado",
    "Airfryer (Manutenção)",
    "Aquecedores de piscina (Manutenção e instalação)",
    "Ar condicionado (Manutenção e Instalação)",
    "Arcondicionado portatil (Manutenção)",
    "Aspirador de pó (Manutenção)",
    "Banho e Tosa",
    "Bebedouro (Manutenção)",
    "Cabeleireira",
    "Cabelereira (Domicilio)",
    "Caçamba",
    "Cafeteira eletrica (Manutenção)",
    "Calheiro",
    "Camera de segurança (Manutenção e Instalação)",
    "Carpinteiro",
    "Cerca eletrica (Manutenção e Instalação)",
    "Chapinha (Manutenção)",
    "Chaveiro",
    "Churrasqueira eletrica (Manutenção)",
    "Climatizador (Manutenção)",
    "Confeitera",
    "Contador",
    "Costureira",
    "Cuidadora",
    "Dedetizador",
    "Dentista",
    "Depilador",
    "Designer de sobrancelha  (domicilio)",
    "Designer de sobrancelha",
    "Eletricista",
    "Encanador",
    "Extensão de cilios",
    "Faxineira",
    "Ferro de passar (Manutenção)",
    "Fogão (Manutenção)",
    "Forno eletrico (Manutenção)",
    "Forro PVC (Manutenção e Instalação)",
    "Freezer (Manutenção)",
    "Fretista (Caminhão)",
    "Fretista (Carretinha)",
    "Geladeira (Manutenção)",
    "Geladeira Comecial (Manutenção)",
    "Gesseiro",
    "Grafica",
    "Guincho",
    "Jardineiro",
    "Lavador a seco (Estofados)",
    "Limpeza terreno",
    "Manicure",
    "Manicure (Domicilio)",
    "Maquiadora",
    "Maquina de lavar roupa (Manutenção)",
    "Marceneiro",
    "Marido de aluguel",
    "Mecanico",
    "Microondas (Manutenção)",
    "Montador de móveis",
    "Motorista (Carro)",
    "Motorista (Moto)",
    "Painel solar (Manutenção e Instalação)",
    "Panela eletrica (Manutenção)",
    "Pedicure",
    "Pedicure (Domicilio)",
    "Pedreiro",
    "Pintor",
    "Podador de arvores",
    "Processador de alimentos (Manutenção)",
    "Professora de reforço escolar (1 ao 5 ano)",
    "Salgadeira",
    "Sanduicheira (Manutenção)",
    "Sapateiro",
    "Secador de cabelo (Manutenção)",
    "Serralheiro",
    "Soldador",
    "Tapeceiro",
    "Tecnico de informatica",
    "Televisão (Manutenção)",
    "Motorista de van escolar",
    "Ventilador (Manutenção)",
    "Ventilador de teto (Manutenção)",
    "Vidraceiro",
  ];

  Future createListaContato(Dados dados) async {
    String UID = FirebaseAuth.instance.currentUser!.uid.toString();

    //
    //Inserir ou criar informação no banco de dados
    final docDados = FirebaseFirestore.instance
        .collection('Profissional')
        .doc(UID)
        .collection("ListaContato")
        .doc();

    dados.id = docDados.id;

    final json = dados.toJson();
    await docDados.set(json);
  }

  Future createListaContatoGeral(Dados dados) async {
    //Inserir ou criar informação no banco de dados
    final docDadosGeral = FirebaseFirestore.instance
        .collection('Busca Geral')
        .doc(_profissionalSelecionado)
        .collection(_cidadeEstadoSelecionado)
        .doc();

    dados.id = docDadosGeral.id;

    final json = dados.toJson();
    await docDadosGeral.set(json);
  }

  Widget ListTileDados(Dados dados) => Padding(
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
                        dados.profissional,
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: cinzaClaro,
                        ),
                      ),
                    ),
                  ),
                  //
                  SizedBox(
                    width: 10,
                  ),
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
                        dados.cidadeEstado,
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
                    dados.nome,
                    style: GoogleFonts.roboto(fontSize: 18),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dados.whatsAppContato,
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
                                  .collection("ListaContato")
                                  .doc(dados.id);

                              solicitacaoCliente.delete();

                              //Deletar no banco Geral
                              final solicitacaoClienteGeral = FirebaseFirestore
                                  .instance
                                  .collection("Busca Geral")
                                  .doc(dados.profissional)
                                  .collection(dados.cidadeEstado)
                                  .doc(dados.idGeral);

                              solicitacaoClienteGeral.delete();

                              final snackBar = SnackBar(
                                backgroundColor: azul,
                                content: Text('Contato excluido com sucesso'),
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
                      "Profissões",
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
                "Aqui você irá cadastrar o seu contato para os clientes vejam quais são os atendiementos fornecidos por você",
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
          "Cadastrar",
          style: GoogleFonts.roboto(
            fontSize: 20,
            color: cinzaClaro,
          ),
        ),
        icon: Icon(
          Icons.edit_document,
          color: cinzaClaro,
        ),
        onPressed: () async {
          //buscado no banco a imagem
          DocumentSnapshot doc = await FirebaseFirestore.instance
              .collection('Profissional')
              .doc(UID)
              .collection('Perfil')
              .doc('Dados')
              .get();
          String imagemPrincipalUrl = doc['ImagemPrincipalUrl'];

          if (imagemPrincipalUrl == '') {
            popUpAvisoImagemURL(context);
          } else {
            popupAdicionarListaContato(context);
          }
        },
      ),
    );
  }

  //PopUp para adicionar o filtro de solicitação do Profissional
  Future popupAdicionarListaContato(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Buscar",
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
                  Text("Preencha os campos conforme as suas habilidades"),
                  SizedBox(
                    height: 30,
                  ),

                  ///Profissional
                  TypeAheadFormField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _profissionalTextEditingController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: cinza,
                          suffixIconColor: azul,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _profissionalTextEditingController.clear();
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
                          hintText: "Profissional"),
                    ),
                    onSaved: (value) {
                      _profissionalSelecionado = value.toString();
                    },
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !listItemsProfissional.contains(value)) {
                        return 'Selecione um profisional ou serviço';
                      }
                      return null;
                    },
                    suggestionsCallback: (pattern) {
                      return listItemsProfissional.where((option) =>
                          option.toLowerCase().contains(pattern.toLowerCase()));
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        _profissionalSelecionado = suggestion;
                        _profissionalTextEditingController.text = suggestion;
                      });
                    },
                  ),

                  ///detalhes do profissional
                  detalhesProfissional == ""
                      ? SizedBox(
                          height: 10,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                          ),
                          child: SizedBox(
                            height: 93,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              children: [
                                Text(
                                  detalhesProfissional,
                                  style: GoogleFonts.roboto(
                                    color: cinzaEscuro,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                  ///Cidade
                  TypeAheadFormField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _cidadeEstadoTextEditingController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: cinza,
                          suffixIconColor: azul,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _cidadeEstadoTextEditingController.clear();
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
                          hintText: "Cidade"),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !listItemsCidadeEstado.contains(value)) {
                        return 'Selecione uma cidade';
                      }
                      return null;
                    },
                    suggestionsCallback: (pattern) {
                      return listItemsCidadeEstado.where((option) =>
                          option.toLowerCase().contains(pattern.toLowerCase()));
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSaved: (value) {
                      _cidadeEstadoSelecionado = value.toString();
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        _cidadeEstadoSelecionado = suggestion;
                        _cidadeEstadoTextEditingController.text = suggestion;
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
                //Buscar no banco o WhatsAppContato e Nome
               
                DocumentSnapshot doc01 = await FirebaseFirestore.instance
                    .collection('Profissional')
                    .doc(UID)
                    .collection('Perfil')
                    .doc('Dados')
                    .get();

                String _nome = doc01['Nome'];
                String _whatsAppContato = doc01['WhatsAppContato'];
                String _email = doc01['Email'];
                String _imagemPrincipalUrl = doc01['ImagemPrincipalUrl'];
                String _cnpj = doc01['CNPJ'];
                String _emiteNotaFiscal = doc01['EmiteNotaFiscal'];

                final isValidForm = formKey.currentState!.validate();

                if (isValidForm) {
                  final dadosGeral = Dados(
                    cidadeEstado: _cidadeEstadoSelecionado,
                    profissional: _profissionalSelecionado,
                    nome: _nome,
                    whatsAppContato: _whatsAppContato,
                    email: _email,
                    imagemPrincipalUrl: _imagemPrincipalUrl,
                    cnpj: _cnpj,
                    emiteNotaFiscal: _emiteNotaFiscal,
                  
                  );
                  createListaContatoGeral(dadosGeral);

                  ///
                  DocumentSnapshot doc = await FirebaseFirestore.instance
                      .collection('Busca Geral')
                      .doc(dadosGeral.profissional)
                      .collection(dadosGeral.cidadeEstado)
                      .doc(dadosGeral.id)
                      .get();

                  String _idGeral = doc['Id'];

                  final dados = Dados(
                    cidadeEstado: _cidadeEstadoSelecionado,
                    profissional: _profissionalSelecionado,
                    nome: _nome,
                    whatsAppContato: _whatsAppContato,
                    idGeral: _idGeral,
                  );
                
                  createListaContato(dados);

                
                  _profissionalTextEditingController.clear();
                  _cidadeEstadoTextEditingController.clear();

                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      );

  //PopUp para adicionar imagem no perfil
  Future popUpAvisoImagemURL(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Aviso",
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
                  Text(
                      "Volte e vá ao ser perfil colocar uma imagem seja uma logo ou foto de perfil"),
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
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
}

//Dados
class Dados {
  String id;
  String idGeral;
  final String profissional;
  final String cidadeEstado;
  final String whatsAppContato;
  final String nome;
  final String email;
  final String imagemPrincipalUrl;
  final String cnpj;
  final String emiteNotaFiscal;

  Dados({
    this.id = '',
    this.idGeral = '',
    required this.profissional,
    required this.cidadeEstado,
    required this.whatsAppContato,
    required this.nome,
    this.email = '',
    this.imagemPrincipalUrl = '',
    this.cnpj = '',
    this.emiteNotaFiscal = '',
  });

  Map<String, dynamic> toJson() => {
        'Id': id,
        'IdGeral': idGeral,
        'Profissional': profissional,
        'CidadeEstado': cidadeEstado,
        'WhatsAppContato': whatsAppContato,
        'Nome': nome,
        'Email': email,
        'ImagemPrincipalUrl': imagemPrincipalUrl,
        'CNPJ': cnpj,
        'EmiteNotaFiscal': emiteNotaFiscal,
      };

  static Dados fromJson(Map<String, dynamic> json) => Dados(
        id: json["Id"] ?? '',
        idGeral: json["IdGeral"] ?? '',
        profissional: json['Profissional'] ?? '',
        cidadeEstado: json['CidadeEstado'] ?? '',
        whatsAppContato: json['WhatsAppContato'] ?? '',
        nome: json['Nome'] ?? '',
        email: json['Email'] ?? '',
        imagemPrincipalUrl: json['ImagemPrincipalUrl'] ?? '',
        cnpj: json['CNPJ'] ?? '',
        emiteNotaFiscal: json['EmiteNotaFiscal'] ?? '',
      );
}
