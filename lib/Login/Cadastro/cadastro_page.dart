import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Cores/cores.dart';
import 'NomeNumero/nomeNumero.dart';


class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  bool _obscureText = true;
  //

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cinzaClaro,
      body: ListView(
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
            "Crie sua conta para acessar o app",
            style: GoogleFonts.roboto(
              color: cinzaEscuro,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          //E-mail
          Container(
            decoration: BoxDecoration(
              color: cinza,
              borderRadius: BorderRadius.circular(50),
            ),
            height: 55,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                cursorColor: azul,
                controller: _emailController,
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
                    hintText: "E-mail",
                    hintStyle: GoogleFonts.roboto(
                      color: cinzaEscuro.withOpacity(0.5),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //Senha
          Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: cinza,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: TextFormField(
                controller: _passwordController,
                cursorColor: azul,
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
                  hintText: "Senha",
                  hintStyle: GoogleFonts.roboto(
                    color: cinzaEscuro.withOpacity(0.5),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      size: 35,
                      color: azul,
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                obscureText: _obscureText,
              ),
            ),
          ),
          //
          SizedBox(
            height: 80,
          ),
          //
          ElevatedButton(
            onPressed: () {
              cadastrar();
            },
            child: Text(
              "Continuar",
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
          SizedBox(
            height: 10,
          ),
          TextButton(
            child: Text(
              "Voltar",
              style: GoogleFonts.roboto(
                color: azul,
                fontSize: 20,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  //Cadastrar
  cadastrar() async {
    try {
 
      
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      if (userCredential != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Nome(),
            ),
            (route) => false);
      print('obj 01');      //
            String UID = FirebaseAuth.instance.currentUser!.uid.toString();
      //Colocar o e-mail no banco de dados 
      print('obj 02');
      await _firestore
            .collection('Profissional')
            .doc(UID)
            .collection('Perfil')
            .doc('Dados')
            .set({
          'Email': _emailController.text,
        }, SetOptions(merge: true));
      }
      print('obj 03');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(
              "Crie uma senha mais forte",
            ),
            backgroundColor: vermelho,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(
              "Este e-mail já foi cadastrado",
            ),
            backgroundColor: vermelho,
          ),
        );
      }
    }

   
  }
}
