import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:profissional/Login/Home/home_page.dart';
import '../../../Cores/cores.dart';
import '../../../firebase_analytics_registro_login.dart';

class Nome extends StatefulWidget {
  const Nome({super.key});

  @override
  State<Nome> createState() => _NomeState();
}

class _NomeState extends State<Nome> {
  bool _isLoading = false;

  String UID = FirebaseAuth.instance.currentUser!.uid.toString();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _whatsAppContatoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cinzaClaro,
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(25),
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Cadastro",
              style: GoogleFonts.roboto(
                color: azul,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            Text(
              "Digite o seu nome completo e numero do seu WhatsApp",
              style: GoogleFonts.roboto(
                color: cinzaEscuro,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            //Nome
            Container(
              decoration: BoxDecoration(
                color: cinza,
                borderRadius: BorderRadius.circular(50),
              ),
              height: 55,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.length < 1) {
                      return "Preenche o seu nome meu chapa";
                    } else if (value.length > 30) {
                      return "Reduz seu nome ai pfv ta muito grande";
                    }
                  },
                  cursorColor: azul,
                  controller: _nomeController,
                  style: GoogleFonts.roboto(
                    color: cinzaEscuro,
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: cinza,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: cinza,
                          width: 2,
                        ),
                      ),
                      hintText: "Nome",
                      hintStyle: GoogleFonts.roboto(
                        color: cinzaEscuro.withOpacity(0.5),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //WhatsAppContato
            Container(
              decoration: BoxDecoration(
                color: cinza,
                borderRadius: BorderRadius.circular(50),
              ),
              height: 55,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.length != 11) {
                      return 'Este campo aceita somente 11 numeros. ';
                    } else if (value!.length == 10) {
                      return 'Coloque o numero zero antes do DDD';
                    }
                    {
                      null;
                    }
                  },
                  cursorColor: azul,
                  controller: _whatsAppContatoController,
                  style: GoogleFonts.roboto(
                    color: cinzaEscuro,
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: cinza,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: cinza,
                        width: 2,
                      ),
                    ),
                    hintText: "WhatsApp",
                    hintStyle: GoogleFonts.roboto(
                      color: cinzaEscuro.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            _isLoading
                ? const SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: _handleFinalizar,
                    child: Text(
                      "Finalizar",
                      style: GoogleFonts.roboto(
                        color: cinzaClaro,
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      backgroundColor: azul,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _handleFinalizar() async {
    //Pegar o numero do WhatsApp no banco de dados
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Profissional')
        .doc(UID)
        .collection('Perfil')
        .doc('Dados')
        .get();
    String email = doc['Email'];

    final isValidForm = formKey.currentState!.validate();
    if (isValidForm) {
      setState(() {
        _isLoading = true;
      });

      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'Nome': _nomeController.text,
        'WhatsAppContato': _whatsAppContatoController.text,
      }, SetOptions(merge: true));

      ///Dados de perfil profissional
      await _firestore
          .collection('Profissional')
          .doc(UID)
          .collection('Perfil')
          .doc('Dados')
          .set({
        'ImagemPrincipalUrl': '',
        'Email': email,
        'Nome': _nomeController.text,
        'Id': 'Dados',
        'Detalhes': '',
        //Redes Sociais
        'WhatsAppContato': _whatsAppContatoController.text,
        'Facebook': '',
        'Instagram': '',
        'LinkedIn': '',
        'TikTok': '',
        'Pinterest': '',
        'Site': '',
        'Youtube': '',
      }, SetOptions(merge: true));

      //Adicionar no app Administrador

       //data atual
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String dataFormatada = formatter.format(now);



      final docRef = _firestore
          .collection('Administrador')
          .doc('Usuarios')
          .collection('Geral')
          .doc();

      final id = docRef.id;

      await docRef.set({
        'Email': email,
        'Nome': _nomeController.text,
        'WhatsAppContato': _whatsAppContatoController.text,
        'Id': id,
        'Data': dataFormatada,
      }, SetOptions(merge: true));

      //Adicionar no app Cliente
     

      final docReference = _firestore
          .collection('Cliente')
          .doc(UID)
          .collection('Perfil')
          .doc('Dados');

      await docReference.set({
        'ImagemPrincipalUrl': '',
        'Email': email,
        'Nome': _nomeController.text,
        'Id': 'Dados',
        'Detalhes': '',
        //Redes Sociais
        'WhatsAppContato': _whatsAppContatoController.text,
        'Facebook': '',
        'Instagram': '',
        'LinkedIn': '',
        'TikTok': '',
        'Pinterest': '',
        'Site': '',
        'Youtube': '',
      }, SetOptions(merge: true));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );

      logLoginEvent();
    }
  }
}
