import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profissional/Cores/cores.dart';

class EsqueceuSenha extends StatefulWidget {
  const EsqueceuSenha({Key? key}) : super(key: key);

  @override
  State<EsqueceuSenha> createState() => _EsqueceuSenhaState();
}

class _EsqueceuSenhaState extends State<EsqueceuSenha> {
  //
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cinzaClaro,

      //
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Esqueci senha",
              style: GoogleFonts.roboto(
                color: azul,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            Text(
              "Digite o seu e-mail e a solicitção para redefinir a senha será enviada em seu e-mail",
              style: GoogleFonts.roboto(
                color: cinzaEscuro,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: cinza,
              ),
              height: 55,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: emailController,
                  cursorColor: azul,
                  style: GoogleFonts.roboto(
                    color: cinzaEscuro,
                    fontSize: 17,
                  ),
                  textInputAction: TextInputAction.done,
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
                    helperStyle: GoogleFonts.roboto(
                      color: cinzaEscuro.withOpacity(0.5),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
            ),
            //
            const SizedBox(
              height: 60,
            ),
            //Botão "Esqueceu a senha"
            ElevatedButton(
              onPressed: esqueceuSenha,
              child: Text(
                "Enviar",
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
      ),
    );
  }

  Future esqueceuSenha() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Text(
            "Redefinição de senha enviada",
          ),
          backgroundColor: vermelho,
        ),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(
              "Email não cadastro",
            ),
            backgroundColor: vermelho,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(
              "Digite corretamente o e-mail",
            ),
            backgroundColor: vermelho,
          ),
        );
      }
    }
  }
}
