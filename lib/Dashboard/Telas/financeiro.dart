import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profissional/Dashboard/Componentes/modalFiltro.dart';
import 'package:profissional/Cores/cores.dart';
import 'package:profissional/Dashboard/Telas/despesas.dart';
import 'package:profissional/Dashboard/Telas/ganhos.dart';
import 'package:profissional/Dashboard/Telas/resultado.dart';

class Financeiro extends StatefulWidget {
  const Financeiro({super.key});

  @override
  State<Financeiro> createState() => _FinanceiroState();
}

class _FinanceiroState extends State<Financeiro> {
  final screens = const [
    HomeGanhos(),
    HomeDespesas(),
    HomeResultado(),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.all(25),
            // child: Column(
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           children: [
            //             Container(
            //               width: 25,
            //               height: 25,
            //               decoration: BoxDecoration(
            //                 color: cinza,
            //                 shape: BoxShape.circle,
            //               ),
            //               child: IconButton(
            //                 onPressed: () {
            //                   Navigator.pop(context);
            //                 },
            //                 padding: EdgeInsets.zero,
            //                 iconSize: 20,
            //                 icon: Icon(Icons.arrow_back),
            //               ),
            //             ),
            //             SizedBox(width: 10),
            //             Text("Total",
            //                 style: GoogleFonts.roboto(
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 25,
            //                 )),
            //           ],
            //         ),
            //         FilledButton.icon(
            //           onPressed: () {
            //             showModalFiltro(context);
            //           },
            //           style: FilledButton.styleFrom(
            //             backgroundColor: azul,
            //           ),
            //           icon: Icon(Icons.filter_list),
            //           label: Text("Filtro"),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ),
          Expanded(
            child: screens[index],
          )
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: azul,
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: azul),
          ),
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: index,
          animationDuration: Duration(seconds: 3),
          onDestinationSelected: (value) => setState(
            () => index = value,
          ),
          destinations: [
            //Ganhos
            NavigationDestination(
              icon: Icon(
                Icons.add,
                color: cinzaEscuro.withOpacity(0.4),
              ),
              selectedIcon: Icon(
                Icons.add,
                color: cinzaClaro,
              ),
              label: "Ganhos",
            ),

            //Despesas
            NavigationDestination(
              icon: Icon(
                Icons.remove,
                color: cinzaEscuro.withOpacity(0.4),
              ),
              selectedIcon: Icon(
                Icons.remove,
                color: cinzaClaro,
              ),
              label: "Despesas",
            ),

            //Resultado
            NavigationDestination(
              icon: Icon(
                Icons.menu,
                color: cinzaEscuro.withOpacity(0.4),
              ),
              selectedIcon: Icon(
                Icons.menu,
                color: cinzaClaro,
              ),
              label: "Resultado",
            ),
          ],
        ),
      ),
    );
  }
}
