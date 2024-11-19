import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:url_launcher/url_launcher.dart';

class ContatoLocalizacao extends StatefulWidget {
  const ContatoLocalizacao({super.key});

  @override
  State<ContatoLocalizacao> createState() => _ContatoLocalizacaoState();
}

class _ContatoLocalizacaoState extends State<ContatoLocalizacao> {
//


  //

  //
  final TextEditingController _whatsAppContatoTextEditingController =
      TextEditingController();
  //
  final TextEditingController _whatsAppContato02TextEditingController =
      TextEditingController();
  //
  final TextEditingController _whatsAppContato03TextEditingController =
      TextEditingController();
  //

  final TextEditingController _ruaTextEditingController =
      TextEditingController();

      final TextEditingController _numeroTextEditingController =
      TextEditingController();

      final TextEditingController _bairroTextEditingController =
      TextEditingController();

final TextEditingController _complementoTextEditingController =
      TextEditingController();
    List<String> listItemsSimOuNao = <String>["Sim", "Não"];
 
  
  final formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _openGoogleMaps() async {
    //Pegar a lat e long
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Profissional')
        .doc(UID)
        .collection('Perfil')
        .doc('Dados')
        .get();

    String lat = doc['LocalizacaoDoEstabelecimentoLat'];
    String long = doc['LocalizacaoDoEstabelecimentoLong'];

    Uri googleMapsUrl =
        Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$long");

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

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
                    "Contato & Local",
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
                  "Aqui é onde ficam os seus dados de perfil no app",
                  style: GoogleFonts.roboto(
                    color: cinzaEscuro,
                    fontSize: 15,
                  ),
                ),
              ),

              SizedBox(height: 20),

              //WhatsApp - 01
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "WhatsApp - 01",
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
                        popUpEditarWhatsAppContato01(context);
                      },
                      color: azul,
                    ),
                    title: Text(
                      "${dados.whatsAppContato}",
                      style: GoogleFonts.roboto(
                        color: cinzaEscuro,
                        fontSize: 17,
                      ),
                    ),
                    leading: Icon(
                      FontAwesomeIcons.whatsapp,
                      color: cinzaEscuro,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //WhatsApp - 02
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "WhatsApp - 02",
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
                        popUpEditarWhatsAppContato02(context);
                      },
                      color: azul,
                    ),
                    title: Text(
                      "${dados.whatsAppContato02}",
                      style: GoogleFonts.roboto(
                        color: cinzaEscuro,
                        fontSize: 17,
                      ),
                    ),
                    leading: Icon(
                      FontAwesomeIcons.whatsapp,
                      color: cinzaEscuro,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //WhatsApp - 03
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "WhatsApp - 03",
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
                        popUpEditarWhatsAppContato03(context);
                      },
                      color: azul,
                    ),
                    title: Text(
                      "${dados.whatsAppContato03}",
                      style: GoogleFonts.roboto(
                        color: cinzaEscuro,
                        fontSize: 17,
                      ),
                    ),
                    leading: Icon(
                      FontAwesomeIcons.whatsapp,
                      color: cinzaEscuro,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              //Localização do estabelicimento
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Localização do estabelecimento",
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
                        popUpEditarLocalizacaoEstabelecimento(context);
                      },
                      color: azul,
                    ),
                    title: dados.localizacaoDoEstabelecimentoLat != null
                        ? Row(
                            children: [
                              FilledButton.icon(
                                onPressed: () {
                                  _openGoogleMaps();
                                },
                                label: Text("Abrir Maps"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Localizado"),
                            ],
                          )
                        : Text("data"),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //CNPJ
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Rua",
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
                        popUpEditarRua(context);
                      },
                      color: azul,
                    ),
                    title: Text(
                      "${dados.rua}",
                      style: GoogleFonts.roboto(
                        color: cinzaEscuro,
                        fontSize: 17,
                      ),
                    ),
                    leading: Icon(
                      Icons.house,
                      color: cinzaEscuro,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //Numero
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Numero",
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
                        popUpEditarNumero(context);
                      },
                      color: azul,
                    ),
                    title: Text(
                      "${dados.numero}",
                      style: GoogleFonts.roboto(
                        color: cinzaEscuro,
                        fontSize: 17,
                      ),
                    ),
                    leading: Icon(
                      Icons.house,
                      color: cinzaEscuro,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //Bairro
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bairro",
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
                        popUpEditarBairro(context);
                      },
                      color: azul,
                    ),
                    title: Text(
                      "${dados.bairro}",
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
              //Complemento
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Complemento",
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
                        popUpEditarComplemento(context);
                      },
                      color: azul,
                    ),
                    title: Text(
                      "${dados.complemento}",
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
              

             
            ],
          ),
        ),
      );

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
      backgroundColor: cinzaClaro,
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

  //Editar WhatsAppContato01
  Future popUpEditarWhatsAppContato01(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "WhatsApp",
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
                    "Digite aqui apenas numero",
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
                      hintText: "WhatsApp",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Opa tem coisa errada ai, digite please :)';
                      } else if (value.length != 11) {
                        return 'Peraê !!! Digite o zap com 11 numeros';
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
                  _updateWhatsAppContato01();
                }
              },
            ),
          ],
        ),
      );

  void _updateWhatsAppContato01() async {
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
        'WhatsAppContato': _whatsAppContatoTextEditingController.text,
      });
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'WhatsAppContato': _whatsAppContatoTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('WhatsApp atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar o nome: $e'),
      ));
    }
  }

  //Editar Rua
  Future popUpEditarRua(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Rua",
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
                    "Digite o nome da rua de seu estabelecimento",
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
                    controller: _ruaTextEditingController,
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
                  _updateRua();
                }
              },
            ),
          ],
        ),
      );

  void _updateRua() async {
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
        'Rua': _ruaTextEditingController.text,
      });
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'Rua': _ruaTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Rua atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar o nome: $e'),
      ));
    }
  }

  //Editar Numero
  Future popUpEditarNumero(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Numero",
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
                    "Digite aqui o numero do estabebecimento",
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
                    controller: _numeroTextEditingController,
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
                  _updateNumero();
                }
              },
            ),
          ],
        ),
      );

  void _updateNumero() async {
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
        'Numero': _numeroTextEditingController.text,
      });
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'Numero': _numeroTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Numero atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar o nome: $e'),
      ));
    }
  }

//Editar Numero
  Future popUpEditarBairro(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Bairro",
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
                    "Digite o bairro do seu estabelecimento",
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
                    controller: _bairroTextEditingController,
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
                  _updateBairro();
                }
              },
            ),
          ],
        ),
      );

  void _updateBairro() async {
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
        'Bairro': _bairroTextEditingController.text,
      });
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'Bairro': _bairroTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Bairro atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar o nome: $e'),
      ));
    }
  }


//Editar Numero
  Future popUpEditarComplemento(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Complemento",
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
                    "Digite o complemento do seu endereço",
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
                    controller: _complementoTextEditingController,
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
                  _updateComplemento();
                }
              },
            ),
          ],
        ),
      );

  void _updateComplemento() async {
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
        'Complemento': _complementoTextEditingController.text,
      });
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'Complemento': _complementoTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Complemento atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar o nome: $e'),
      ));
    }
  }



  String _locationMessage = "Pressione o botão para obter a localização";

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se o serviço de localização está ativado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Serviço de localização desativado";
      });
      return;
    }

    // Verifica se as permissões de localização foram concedidas
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Permissão de localização negada";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = "Permissão de localização permanentemente negada";
      });
      return;
    }

    // Obtém a posição atual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    //Armazenar no banco de dados
    await _firestore
        .collection('Profissional')
        .doc(UID)
        .collection('Perfil')
        .doc('Dados')
        .set({
      'LocalizacaoDoEstabelecimentoLat': position.latitude.toString(),
      'LocalizacaoDoEstabelecimentoLong': position.longitude.toString(),
    }, SetOptions(merge: true));

    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Profissional')
        .doc(UID)
        .collection('Perfil')
        .doc('Dados')
        .get();

    String email = doc['Email'];

    await _firestore
        .collection('Perfil Geral')
        .doc('Profissional')
        .collection(email)
        .doc('Perfil')
        .set({
      'LocalizacaoDoEstabelecimentoLat': position.latitude.toString(),
      'LocalizacaoDoEstabelecimentoLong': position.longitude.toString(),
    }, SetOptions(merge: true));
    //
  }

  //Editar WhatsAppContato01
  Future popUpEditarLocalizacaoEstabelecimento(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Localização",
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
                    "Aperte no botão para realizar a localização atual",
                    style: GoogleFonts.roboto(
                      color: cinzaEscuro,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FilledButton.icon(
                  onPressed: () {
                    _getCurrentLocation();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 5),
                        content: Text(
                          "Localização Atualizada",
                          style: GoogleFonts.roboto(
                            color: cinzaClaro,
                          ),
                        ),
                        backgroundColor: cinzaEscuro,
                      ),
                    );
                  },
                  label: Text("Localização atual"),
                  icon: Icon(Icons.location_on),
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
          ],
        ),
      );

  void _updateLocalizacaoEContato() async {
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
        'WhatsAppContato': _whatsAppContatoTextEditingController.text,
      });
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'WhatsAppContato': _whatsAppContatoTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('WhatsApp atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar o nome: $e'),
      ));
    }
  }

  //Editar WhatsAppContato
  Future popUpEditarWhatsAppContato02(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "WhatsApp",
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
                    "Digite aqui apenas numero",
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
                    controller: _whatsAppContato02TextEditingController,
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
                      hintText: "WhatsApp",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Opa tem coisa errada ai, digite please :)';
                      } else if (value.length != 11) {
                        return 'Peraê !!! Digite o zap com 11 numeros';
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
                  _updateWhatsAppContato02();
                }
              },
            ),
          ],
        ),
      );

  void _updateWhatsAppContato02() async {
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
        'WhatsAppContato02': _whatsAppContato02TextEditingController.text,
      });
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'WhatsAppContato02': _whatsAppContato02TextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('WhatsApp atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar o nome: $e'),
      ));
    }
  }

  //Editar WhatsAppContato03
  Future popUpEditarWhatsAppContato03(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "WhatsApp",
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
                    "Digite aqui apenas numero",
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
                    controller: _whatsAppContato03TextEditingController,
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
                      hintText: "WhatsApp",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Opa tem coisa errada ai, digite please :)';
                      } else if (value.length != 11) {
                        return 'Peraê !!! Digite o zap com 11 numeros';
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
                  _updateWhatsAppContato03();
                }
              },
            ),
          ],
        ),
      );

  void _updateWhatsAppContato03() async {
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
        'WhatsAppContato03': _whatsAppContato03TextEditingController.text,
      });
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'WhatsAppContato03': _whatsAppContato03TextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('WhatsApp atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar o nome: $e'),
      ));
    }
  }
}

//Informações do cliente
class PerfilDados {
  //Contato
  final String whatsAppContato;
  final String whatsAppContato02;
  final String whatsAppContato03;
  final String cnpj;
  final String emiteNotaFiscal;
  //Endereço
  final String localizacaoDoEstabelecimentoLat;
  final String localizacaoDoEstabelecimentoLong;
  final String rua;
  final String numero;
  final String bairro;
  final String complemento;

  PerfilDados({
    //Contato
    this.whatsAppContato = '',
    this.whatsAppContato02 = '',
    this.whatsAppContato03 = '',
    this.cnpj = '',
    this.emiteNotaFiscal = '',
    //Endereço
    this.localizacaoDoEstabelecimentoLat = '',
    this.localizacaoDoEstabelecimentoLong = '',
    this.rua = '',
    this.numero = '',
    this.bairro = '',
    this.complemento = '',
  });

  Map<String, dynamic> toJson() => {
    //Contato
        'WhatsAppContato': whatsAppContato,
        'WhatsAppContato02': whatsAppContato02,
        'WhatsAppContato03': whatsAppContato03,
        'CNPJ': cnpj,
        'EmiteNotaFiscal': emiteNotaFiscal,
        //Endereço
        'LocalizacaoDoEstabelecimentoLat': localizacaoDoEstabelecimentoLat,
        'LocalizacaoDoEstabelecimentoLong': localizacaoDoEstabelecimentoLong,
        'Rua': rua,
        'Numero': numero,
        'Bairro': bairro,
        'Complemento': complemento,
      };

  static PerfilDados fromJson(Map<String, dynamic> json) => PerfilDados(
    //Contato
        whatsAppContato: json['WhatsAppContato'] ?? '',
        whatsAppContato02: json['WhatsAppContato02'] ?? '',
        whatsAppContato03: json['WhatsAppContato03'] ?? '',
        cnpj: json['CNPJ'] ?? '',
        emiteNotaFiscal: json['EmiteNotaFiscal'] ?? '',
        //Endereço
        localizacaoDoEstabelecimentoLat:
            json['LocalizacaoDoEstabelecimentoLat'] ?? '',
        localizacaoDoEstabelecimentoLong:
            json['LocalizacaoDoEstabelecimentoLong'] ?? '',
            rua: json['Rua'] ?? '',
            numero: json['Numero'] ?? '',
            bairro: json['Bairro'] ?? '',
            complemento: json['Complemento'] ?? '',

      );
}
