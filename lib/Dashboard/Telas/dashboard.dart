import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:profissional/Dashboard/Telas/financeiro.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

String UID = FirebaseAuth.instance.currentUser!.uid.toString();

class _HomeDashboardState extends State<HomeDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cinzaClaro,
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Financeiro()),
          );
        },
        child: Container(
          margin: EdgeInsets.only(top: 50),
          padding: EdgeInsets.all(25),
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/financeiro.jpg"),
                  fit: BoxFit.cover,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Financeiro",
                      style: GoogleFonts.roboto(
                        color: branco,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: branco,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "\$",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Aqui você consegue controlar o  \nregistro dos seus serviços",
                  style: GoogleFonts.roboto(
                    color: branco,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    FilledButton.icon(
                      onPressed: () {
                        print(UID);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: azul,
                      ),
                      icon: Icon(Icons.download_rounded),
                      label: Text("Extrair Excel"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FilledButton.icon(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: azul,
                      ),
                      icon: Icon(Icons.download_rounded),
                      label: Text("Extrair PDF"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
