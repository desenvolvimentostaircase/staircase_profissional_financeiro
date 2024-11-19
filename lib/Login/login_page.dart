import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Cores/cores.dart';
import '../firebase_analytics_registro_login.dart';

import 'Cadastro/cadastro_page.dart';
import 'Home/home_page.dart';
import 'esqueci_senha/esqueci_senha.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;
  bool _obscureText = true;
  //

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
            "Login",
            style: GoogleFonts.roboto(
              color: azul,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
          Text(
            "Entre no app para conhecer os profissionais",
            style: GoogleFonts.roboto(
              color: cinzaEscuro,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 50,
          ),

          //E-mail

          TextFormField(
            style: GoogleFonts.roboto(
              color: cinzaEscuro,
              fontSize: 18,
            ),
            cursorColor: azul,
            controller: _emailController,
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
              hintText: "E-mail",
              hintStyle: GoogleFonts.roboto(
                color: cinzaEscuro.withOpacity(0.5),
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
              color: cinza,
              borderRadius: BorderRadius.circular(
                50,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: TextField(
                style: GoogleFonts.roboto(
                  color: cinzaEscuro,
                  fontSize: 18,
                ),
                cursorColor: azul,
                controller: _passwordController,
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
                      size: 32,
                      color: azul,
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                ),
                obscureText: _obscureText,
              ),
            ),
          ),
          //Botão de "Esqueceu a senha"
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: Text(
                "Esqueci a senha",
                style: GoogleFonts.roboto(
                  color: azul,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const EsqueceuSenha(),
                  ),
                );
              },
            ),
          ),
          //

          //
          SizedBox(
            height: 60,
          ),
          //
          //Botão "Entrar"
          ElevatedButton(
            onPressed: login,
            child: Text(
              "Entrar",
              style: GoogleFonts.roboto(
                color: cinzaClaro,
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(10),
              backgroundColor: azul,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          //Botão "Criar conta"
          
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CadastroPage(),
                ),
              );
            },
            child: Text(
              "Criar conta",
              style: GoogleFonts.roboto(
                color: azul,
                fontSize: 20,
              ),
            ),
          ),        
        ],
      ),
    );
  }

  login() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (userCredential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
        //Resgistro de evento de login
        logLoginEvent();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(
              "Úsuario não encontrado",
              style: GoogleFonts.roboto(
                color: cinzaClaro,
              ),
            ),
            backgroundColor: vermelho,
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(
              "Sua senha está errada",
              style: GoogleFonts.roboto(
                color: cinzaClaro,
              ),
            ),
            backgroundColor: vermelho,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(
              "Preencha corretamente o e-mail ou a Senha",
              style: GoogleFonts.roboto(
                color: cinzaClaro,
              ),
            ),
            backgroundColor: vermelho,
          ),
        );
      }
    }
  }
}