import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profissional/Dashboard/Componentes/modal.dart';
import 'package:profissional/Cores/cores.dart';

class HomeDespesas extends StatefulWidget {
  const HomeDespesas({super.key});

  @override
  State<HomeDespesas> createState() => _HomeDespesasState();
}

class _HomeDespesasState extends State<HomeDespesas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModal(context);
        },
        label: Text("Adicionar"),
        icon: Icon(Icons.add),
        backgroundColor: azul,
        foregroundColor: branco,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
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
                        Text("1000,00")
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Energia",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: azul,
                        radius: 20,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                          iconSize: 20,
                          color: branco,
                        ),
                      ),
                    ],
                  ),
                  Text("Pagamento mensal"),
                  SizedBox(
                    height: 10,
                  ),
                  Text("06/11"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: branco,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Text(
                              "\$",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("200,00"),
                          ],
                        ),
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
