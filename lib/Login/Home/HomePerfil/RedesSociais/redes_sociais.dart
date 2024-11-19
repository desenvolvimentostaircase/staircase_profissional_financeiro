import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:profissional/Login/Home/HomePerfil/home_perfil.dart';

class RedesSociais extends StatefulWidget {
  const RedesSociais({super.key});

  @override
  State<RedesSociais> createState() => _RedesSociaisState();
}

class _RedesSociaisState extends State<RedesSociais> {
  final _firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  final TextEditingController _instagramUrlTextEditingController =
      TextEditingController();
  //
  final TextEditingController _nomeTextEditingController =
      TextEditingController();

  final TextEditingController _detalhesTextEditingController =
      TextEditingController();
  //
  final TextEditingController _facebookTextEditingController =
      TextEditingController();
  //
  final TextEditingController _linkedInTextEditingController =
      TextEditingController();
  //
  final TextEditingController _tikTokTextEditingController =
      TextEditingController();

  //
  final TextEditingController _pinterestTextEditingController =
      TextEditingController();

  //
  final TextEditingController _siteTextEditingController =
      TextEditingController();

  //
  final TextEditingController _youtubeTextEditingController =
      TextEditingController();


   Widget ListTileBuscar(PerfilDados dados) => Padding(
    padding: EdgeInsets.all(25),
    child: Container(
      height: MediaQuery.sizeOf(context).height *0.9,
      child: ListView(
          children: [
            //
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: azul,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back,color: cinzaClaro,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Social",
                    style: GoogleFonts.roboto(
                      color: azul,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "Preencha abaixo para que os clientes possam visualizar ",
              style: GoogleFonts.roboto(
                color: cinzaEscuro,
                fontSize: 15,
              ),
            ),
      
            //
            SizedBox(
              height: 10,
            ),
            //Facebook
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Facebook",
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
                    leading: Icon(
                      FontAwesomeIcons.facebook,
                      color: cinzaEscuro,
                    ),
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: dados.facebook == ""
                          ? Text(
                              "",
                              style: GoogleFonts.roboto(
                                color: azul,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Text(
                                    "${dados.facebook}",
                                    style: GoogleFonts.roboto(
                                      color: cinzaEscuro,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    trailing: IconButton(
                      color: azul,
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        popUpEditarFacebook(context);
                      },
                    ),
                  )),
            ),
            //
            SizedBox(
              height: 10,
            ),
            //Instagram
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Instagram",
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
                  leading: Icon(
                    FontAwesomeIcons.instagram,
                    color: cinzaEscuro,
                  ),
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: dados.instagram == ""
                        ? Text(
                            "",
                            style: GoogleFonts.roboto(
                              color: azul,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Text(
                                  "${dados.instagram}",
                                  style: GoogleFonts.roboto(
                                    color: cinzaEscuro,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  trailing: IconButton(
                    color: azul,
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      popUpEditarInstagram(context);
                    },
                  ),
                ),
              ),
            ),
            //
            SizedBox(
              height: 10,
            ),
            //LinkedIn
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "LinkedIn",
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
                  leading: Icon(
                    FontAwesomeIcons.linkedin,
                    color: cinzaEscuro,
                  ),
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: dados.linkedIn == ""
                        ? Text(
                            "",
                            style: GoogleFonts.roboto(
                              color: azul,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Text(
                                  "${dados.linkedIn}",
                                  style: GoogleFonts.roboto(
                                    color: cinzaEscuro,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  trailing: IconButton(
                    color: azul,
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      popUpEditarLinkedIn(context);
                    },
                  ),
                ),
              ),
            ),
            //
            SizedBox(
              height: 10,
            ),
            //TikTok
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "TikTok",
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
                  leading: Icon(
                    FontAwesomeIcons.tiktok,
                    color: cinzaEscuro,
                  ),
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: dados.tikTok == ""
                        ? Text(
                            "",
                            style: GoogleFonts.roboto(
                              color: azul,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Text(
                                  "${dados.tikTok}",
                                  style: GoogleFonts.roboto(
                                    color: cinzaEscuro,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  trailing: IconButton(
                    color: azul,
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      popUpEditarTikTok(context);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //Pinterest
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pinterest",
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
                  leading: Icon(
                    FontAwesomeIcons.pinterest,
                    color: cinzaEscuro,
                  ),
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: dados.pinterest == ""
                        ? Text(
                            "",
                            style: GoogleFonts.roboto(
                              color: azul,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Text(
                                  "${dados.pinterest}",
                                  style: GoogleFonts.roboto(
                                    color: cinzaEscuro,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                  trailing: IconButton(
                    color: azul,
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      popUpEditarPinterest(context);
                    },
                  ),
                ),
              ),
            ),
            //
            SizedBox(
              height: 10,
            ),
            //Site
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Site",
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
                    leading: Icon(
                      Icons.language,
                      color: cinzaEscuro,
                    ),
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: dados.site == ""
                          ? Text(
                              "",
                              style: GoogleFonts.roboto(
                                color: azul,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Text(
                                    "${dados.site}",
                                    style: GoogleFonts.roboto(
                                      color: cinzaEscuro,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    trailing: IconButton(
                      color: azul,
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        popUpEditarSite(context);
                      },
                    ),
                  )),
            ),
            //
            SizedBox(
              height: 10,
            ),
            //Youtube
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Youtube",
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
                    leading: Icon(
                      FontAwesomeIcons.youtube,
                      color: cinzaEscuro,
                    ),
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: dados.youtube == ""
                          ? Text(
                              "",
                              style: GoogleFonts.roboto(
                                color: azul,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Text(
                                    "${dados.youtube}",
                                    style: GoogleFonts.roboto(
                                      color: cinzaEscuro,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    trailing: IconButton(
                      color: azul,
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        popUpEditarYoutube(context);
                      },
                    ),
                  )),
            ),
            SizedBox(
              height: 20,
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

  //Editar Instagram
  Future popUpEditarInstagram(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Instagram",
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
                    "Digite ou cole a url do seu instagram",
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
                    controller: _instagramUrlTextEditingController,
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
                      hintText: "InstagramURL",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Coloque uma URL';
                      }
                      return null;
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
                  _updateInstagram();
                }
              },
            ),
            //
          ],
        ),
      );

  void _updateInstagram() async {
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
        'Instagram': _instagramUrlTextEditingController.text,
      }, SetOptions(merge: true));

      ///
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'Instagram': _instagramUrlTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Instagram atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar o nome: $e'),
      ));
    }
  }


  //Editar Nome
  Future popUpEditarNome(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Instagram",
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
                    "Digite o seu nome",
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
                      hintText: "Nome",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite o seu nome';
                      }
                      return null;
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
                _updateName();
              },
            ),
            //
          ],
        ),
      );

  void _updateName() async {
    //Pegar o numero do WhatsApp no banco de dados
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Profissional')
        .doc(UID)
        .collection('Perfil')
        .doc('Dados')
        .get();

    String email = doc['Email'];

    if (_nomeTextEditingController.text.isNotEmpty) {
      try {
        await _firestore
            .collection('Profissional')
            .doc(UID)
            .collection('Perfil')
            .doc('Dados')
            .update({
          'Nome': _nomeTextEditingController.text,
        });
        await _firestore
            .collection('Perfil Geral')
            .doc('Profissional')
            .collection(email)
            .doc('Perfil')
            .set({
          'Nome': _nomeTextEditingController.text,
        }, SetOptions(merge: true));

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Nome atualizado com sucesso!'),
        ));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro ao atualizar o nome: $e'),
        ));
      }
    }
  }

  //Editar Detalhes
  Future popUpEditarDetalhes(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Detalhes",
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
                    "Digite os detalhes do seu empreendimento",
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
                      hintText: "Detalhes",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
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
                _updateDetalhes();
              },
            ),
            //
          ],
        ),
      );

  void _updateDetalhes() async {
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
        'Detalhes': _detalhesTextEditingController.text,
      }, SetOptions(merge: true));

      ///
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'Detalhes': _detalhesTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Detalhes atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar : $e'),
      ));
    }
  }

  //Editar Facebook
  Future popUpEditarFacebook(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Facebook",
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
                    "Digite o link do seu facebook",
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
                    controller: _facebookTextEditingController,
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
                      hintText: "Facebook",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
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
                _updateFacebook();
              },
            ),
            //
          ],
        ),
      );

  void _updateFacebook() async {
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
        'Facebook': _facebookTextEditingController.text,
      }, SetOptions(merge: true));

      ///
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'Facebook': _facebookTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Facebook atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar : $e'),
      ));
    }
  }

  //Editar LinkedIn
  Future popUpEditarLinkedIn(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "LinkedIn",
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
                    "Digite o link do seu linkedIn",
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
                    controller: _linkedInTextEditingController,
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
                      hintText: "LinkedIn",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
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
                _updateLinkedIn();
              },
            ),
            //
          ],
        ),
      );

  void _updateLinkedIn() async {
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
        'LinkedIn': _linkedInTextEditingController.text,
      }, SetOptions(merge: true));

      ///
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'LinkedIn': _linkedInTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('LinkedIn atualizado com sucesso!'),
      ));

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar : $e'),
      ));
    }
  }

  //Editar Tiktok
  Future popUpEditarTikTok(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "TikTok",
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
                    "Digite o link do seu tikTok",
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
                    controller: _tikTokTextEditingController,
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
                      hintText: "TikTok",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
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
                _updateTikTok();
              },
            ),
            //
          ],
        ),
      );

  void _updateTikTok() async {
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
        'TikTok': _tikTokTextEditingController.text,
      }, SetOptions(merge: true));

      ///
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'TikTok': _tikTokTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('TikTok atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar : $e'),
      ));
    }
  }

  //Editar Piterest
  Future popUpEditarPinterest(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Pinterest",
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
                    "Digite o link do seu pinterest",
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
                    controller: _pinterestTextEditingController,
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
                      hintText: "Pinterest",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
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
                _updatePinterest();
              },
            ),
            //
          ],
        ),
      );

  void _updatePinterest() async {
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
        'Pinterest': _pinterestTextEditingController.text,
      }, SetOptions(merge: true));

      ///
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'Pinterest': _pinterestTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Pinterest atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar : $e'),
      ));
    }
  }

  //Editar Site
  Future popUpEditarSite(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Site",
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
                    "Digite o link do seu site",
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
                    controller: _siteTextEditingController,
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
                      hintText: "Site",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
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
                _updateSite();
              },
            ),
            //
          ],
        ),
      );

  void _updateSite() async {
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
        'Site': _siteTextEditingController.text,
      }, SetOptions(merge: true));

      ///
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'Site': _siteTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Site atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar : $e'),
      ));
    }
  }

  //Editar Youtube
  Future popUpEditarYoutube(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Youtube",
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
                    "Digite o link do seu youtube",
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
                    controller: _youtubeTextEditingController,
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
                      hintText: "Youtube",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
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
                _updateYoutube();
              },
            ),
            //
          ],
        ),
      );

  void _updateYoutube() async {
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
        'Youtube': _youtubeTextEditingController.text,
      }, SetOptions(merge: true));

      ///
      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'Youtube': _youtubeTextEditingController.text,
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Youtube atualizado com sucesso!'),
      ));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao atualizar : $e'),
      ));
    }
  }
}
