import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profissional/Cores/cores.dart';

class HomeResultado extends StatefulWidget {
  const HomeResultado({super.key});

  @override
  State<HomeResultado> createState() => _HomeResultadoState();
}

class _HomeResultadoState extends State<HomeResultado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 25, left: 25),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: cinza,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Período: 01/10 a 31/10"),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: branco,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("2000,00"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: cinza,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: 200,
                height: 10,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: cinza,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Extração",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ],
                  ),
                  Text("Extrair todo o conteúdo armazenado"),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      FilledButton.icon(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: azul,
                        ),
                        icon: Icon(Icons.download_rounded),
                        label: Text("PDF"),
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
                        label: Text("Excel"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
