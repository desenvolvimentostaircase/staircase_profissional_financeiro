import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profissional/Dashboard/Telas/dashboard.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Cores/cores.dart';
import '../../checagem_page.dart';

import 'HomePerfil/home_perfil.dart';
import 'HomePrincipal/home_principal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

abrirWhatsAppSuporte() async {
  Uri whatsappUrl = Uri.parse(
      "whatsapp://send?phone=+5567991415217&text=Oi, venho do app Edy Cliente, estou com dificuldade poderia me ajudar?");

  if (await canLaunchUrl(whatsappUrl)) {
    await launchUrl(whatsappUrl);
  } else {
    throw 'Could not launch $whatsappUrl';
  }
}

class _HomePageState extends State<HomePage> {
  Future popupMenu() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            "Menu",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 25,
              color: cinzaEscuro,
            ),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: 1,
            child: ListView(
              children: [
                //WhatsApp suporte
                ListTile(
                  onTap: () {
                    abrirWhatsAppSuporte();
                  },
                  title: Text(
                    "WhatsApp - Suporte",
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      color: cinzaEscuro,
                    ),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: cinzaEscuro,
                  ),
                ),
                Divider(
                  color: cinzaEscuro,
                  thickness: 1,
                ),
                //Contato
                ListTile(
                  onTap: abrirContato,
                  title: Text(
                    "Contato",
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      color: cinzaEscuro,
                    ),
                  ),
                  leading: Icon(
                    Icons.email,
                    color: cinzaEscuro,
                  ),
                ),
                //Divisor
                Divider(
                  color: cinzaEscuro,
                  thickness: 1,
                ),
                //Instagram
                ListTile(
                  onTap: abrirInstagram,
                  title: Text(
                    "Instagram",
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      color: cinzaEscuro,
                    ),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.instagram,
                    color: cinzaEscuro,
                  ),
                ),
                //
                ListTile(
                  onTap: abrirYoutube,
                  title: Text(
                    "Tutoriais",
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      color: cinzaEscuro,
                    ),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.youtube,
                    color: cinzaEscuro,
                  ),
                ),
                //
                Divider(
                  color: cinzaEscuro,
                  thickness: 1,
                ),
                //
                ListTile(
                  title: Text(
                    "Sair",
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      color: vermelho,
                    ),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: vermelho,
                  ),
                  onTap: sair,
                ),
              ],
            ),
          ),
        ),
      );

  sair() async {
    await _firebaseAuth.signOut().then(
          (solicitacao) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ChecagemPage(),
            ),
          ),
        );
  }

  String UID = FirebaseAuth.instance.currentUser!.uid.toString();
  final _firebaseAuth = FirebaseAuth.instance;
  final screens = const [
    HomePrincipal(),
    HomePerfil(),
    HomeDashboard(),
  ];

  int? contador = 1;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cinzaClaro,
      body: screens[index],
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
          onDestinationSelected: (index) => setState(
            () => this.index = index,
          ),
          destinations: [
            //Home Principal
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: cinzaEscuro.withOpacity(0.4),
              ),
              selectedIcon: Icon(
                Icons.home,
                color: cinzaClaro,
              ),
              label: 'Home',
            ),

            //Perfil
            NavigationDestination(
              icon: Icon(
                Icons.assignment_ind_outlined,
                color: cinzaEscuro.withOpacity(0.4),
              ),
              selectedIcon: Icon(
                Icons.assignment_ind_rounded,
                color: cinzaClaro,
              ),
              label: 'Perfil',
            ),

            //Dashboard
            NavigationDestination(
              icon: Icon(
                Icons.dashboard_outlined,
                color: cinzaEscuro.withOpacity(0.4),
              ),
              selectedIcon: Icon(
                Icons.dashboard_outlined,
                color: cinzaClaro,
              ),
              label: 'Dashboard',
            ),
          ],
        ),
      ),
    );
  }
}

abrirYoutube() async {
  Uri nativeUrl = Uri.parse("youtube://www.youtube.com/@edywasa/featured");
  Uri webUrl = Uri.parse("https://www.youtube.com/@edywasa/featured");
  if (await canLaunchUrl(nativeUrl)) {
    await launchUrl(nativeUrl);
  } else if (await canLaunchUrl(webUrl)) {
    await launchUrl(webUrl);
  } else {
    print("can't open You");
  }
}

abrirInstagram() async {
  Uri nativeUrl = Uri.parse("instagram://user?username=edywasa.ofc");
  Uri webUrl = Uri.parse("https://www.instagram.com/edywasa.ofc/");
  if (await canLaunchUrl(nativeUrl)) {
    await launchUrl(nativeUrl);
  } else if (await canLaunchUrl(webUrl)) {
    await launchUrl(webUrl);
  } else {
    print("can't open Instagram");
  }
}

abrirContato() async {
  final Uri url = Uri(
    scheme: 'mailto',
    path: 'suporteedywasa@gmail.com',
    query: 'subject=Reportar&body=Bom dia, Edywasa.\n  ',
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    print('Could not launch $url');
  }
}
