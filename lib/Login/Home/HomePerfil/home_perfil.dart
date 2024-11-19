import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Cores/cores.dart';
import '../../../checagem_page.dart';
import 'ContatoeLocalizacao/contato_localizacao.dart';
import 'Negocios/negocios.dart';
import 'RedesSociais/redes_sociais.dart';

class HomePerfil extends StatefulWidget {
  const HomePerfil({super.key});

  @override
  State<HomePerfil> createState() => _HomePerfilState();
}

class _HomePerfilState extends State<HomePerfil> {
  final _firebaseAuth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  final TextEditingController _nomeTextEditingController =
      TextEditingController();
  //
  final TextEditingController _detalhesTextEditingController =
      TextEditingController();

  Widget ListTileBuscar(PerfilDados dados) => Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Perfil",
                  style: GoogleFonts.roboto(
                    color: azul,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                FilledButton.icon(
                  label: Text(
                    "Sair",
                    style: GoogleFonts.roboto(
                      color: cinzaClaro,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Icon(Icons.logout),
                  onPressed: () async {
                    await _firebaseAuth.signOut().then(
                          (solicitacao) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChecagemPage(),
                            ),
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.only(
                        left: 20, top: 10, right: 20, bottom: 10),
                    backgroundColor: vermelho,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Aqui é onde ficam os seus dados de perfil no app",
                style: GoogleFonts.roboto(
                  color: cinzaEscuro,
                  fontSize: 15,
                ),
              ),
            ),
            

            SizedBox(height: 20),
            _buildUploadStatus(),
            SizedBox(height: 20),
            FilledButton.icon(
              label: Text("Alterar Imagem"),
              onPressed: _pickImage,
              icon: Icon(Icons.add_photo_alternate),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                backgroundColor: azul,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  //Salvos
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 75,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: azul),
                            height: 75,
                            width: 75,
                            child: Icon(
                              Icons.language,
                              color: cinzaClaro,
                              size: 40,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Redes Sociais",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: azul,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RedesSociais(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),

                  //Clientes
                  GestureDetector(
                    child: SizedBox(
                      height: 120,
                      width: 75,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: cinzaEscuro,
                            ),
                            height: 75,
                            width: 75,
                            child: Icon(
                              Icons.document_scanner,
                              color: cinzaClaro,
                              size: 40,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Certificados & Formações",
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: cinzaEscuro,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      //Navigator.of(context).push(
                      //  MaterialPageRoute(
                      //    builder: (context) => const CertificadosEFormacoes(),
                      //  ),
                      //);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //Contato & Localização
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 75,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: azul),
                            height: 75,
                            width: 75,
                            child: Icon(
                              Icons.location_on,
                              color: cinzaClaro,
                              size: 40,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Contato & Localização",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              
                              color: azul,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContatoLocalizacao(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  //Contato & Localização
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 75,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: azul),
                            height: 75,
                            width: 75,
                            child: Icon(
                              Icons.business_center,
                              color: cinzaClaro,
                              size: 40,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Negócios",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              
                              color: azul,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Negocios(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),

            //Nome
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Nome",
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
                    Icons.person_4,
                    color: cinzaEscuro,
                  ),
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "${dados.nome}",
                      style: GoogleFonts.roboto(
                        color: cinzaEscuro,
                        fontSize: 17,
                        
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: azul,
                    onPressed: () {
                      popUpEditarNome(context);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //Email
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "E-mail",
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
                    Icons.email_rounded,
                    color: cinzaEscuro,
                  ),
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "${dados.email}",
                      style: GoogleFonts.roboto(
                        color: cinzaEscuro,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //Detalhes
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Detalhes",
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
                    Icons.business,
                    color: cinzaEscuro,
                  ),
                  title: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: dados.detalhes == ""
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
                                  "${dados.detalhes}",
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
                      popUpEditarDetalhes(context);
                    },
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            
          ],
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

  // Imagem
  File? _image;
  String? _downloadUrl;
  double _uploadProgress = 0;

  @override
  void initState() {
    super.initState();
    _loadImageUrl();
  }

  Future<void> _loadImageUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _downloadUrl = prefs.getString('image_url');
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);

      if (file.lengthSync() <= 1 * 1024 * 1024) {
        print("object : ${file.length()}");
        // 3MB em bytes
        setState(() {
          _image = file;
        });

        _uploadImage();
      } else {
        _showSizeError();
      }
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    FirebaseStorage storage = FirebaseStorage.instance;
    if (_downloadUrl != null) {
      // Deletar a imagem anterior
      try {
        await storage.refFromURL(_downloadUrl!).delete();
      } catch (e) {
        print("Erro ao deletar a imagem anterior: $e");
      }
    }

    String fileName = 'imagem_principal.png';
    Reference ref =
        storage.ref().child("profissional/$UID/perfil/dados/$fileName");
    UploadTask uploadTask = ref.putFile(_image!);

    // Monitorar o progresso do upload
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      setState(() {
        _uploadProgress = snapshot.bytesTransferred.toDouble() /
            snapshot.totalBytes.toDouble();
      });
    });

    uploadTask.whenComplete(() async {
      String newDownloadUrl = await ref.getDownloadURL();
      print("Image URL: $newDownloadUrl");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('image_url', newDownloadUrl);

      setState(() {
        _downloadUrl = newDownloadUrl;
        _image = null; // Clear the local file to use the URL instead
        _uploadProgress = 0; // Reset the progress bar
      });

      //armazenar url image no banco de dados
      await _firestore
          .collection('Profissional')
          .doc(UID)
          .collection('Perfil')
          .doc('Dados')
          .set({
        'ImagemPrincipalUrl': newDownloadUrl,
      }, SetOptions(merge: true));

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Profissional')
          .doc(UID)
          .collection('Perfil')
          .doc('Dados')
          .get();

      String email = doc['Email'];

      await _firestore
          .collection('Perfil Geral')
          .doc('Profissional')
          .collection(email)
          .doc('Perfil')
          .set({
        'ImagemPrincipalUrl': newDownloadUrl,
      }, SetOptions(merge: true));
      //
      
    });
  }

  void _showSizeError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Erro"),
          content:
              Text("A imagem selecionada é muito grande. O limite é de 1 MB."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildUploadStatus() {
    return _image == null && _downloadUrl != null
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                _downloadUrl!,
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.sizeOf(context).width * 0.4,
            width: MediaQuery.sizeOf(context).width * 0.4,
          )
        : _image != null
            ? Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: MediaQuery.sizeOf(context).width * 0.4,
                    width: MediaQuery.sizeOf(context).width * 0.4,
                  ),
                  SizedBox(height: 10),
                  _uploadProgress > 0
                      ? LinearProgressIndicator(value: _uploadProgress)
                      : Container(),
                ],
              )
            : Text(
                'Perfil sem imagem',
              );
  }
}

//Informações do cliente
class PerfilDados {
  String id;
  String idGeral;
  final String email;
  final String nome;
  final String detalhes;
  final String whatsAppContato;
  final String whatsAppContato02;
  final String whatsAppContato03;
  //Redes Sociais

  final String facebook;
  final String instagram;
  final String linkedIn;
  final String tikTok;
  final String pinterest;
  final String site;
  final String youtube;

  PerfilDados({
    this.id = '',
    this.idGeral = '',
    this.email = '',
    this.nome = '',
    this.detalhes = "",
    this.whatsAppContato = '',
    this.whatsAppContato02 = '',
    this.whatsAppContato03 = '',

    //Redes Socias

    this.facebook = "",
    this.instagram = "",
    this.linkedIn = "",
    this.tikTok = "",
    this.pinterest = "",
    this.site = "",
    this.youtube = "",
  });

  Map<String, dynamic> toJson() => {
        'Id': id,
        'IdGeral': idGeral,
        'Nome': nome,
        'Email': email,
        'Detalhes': detalhes,
        'WhatsAppContato': whatsAppContato,
        'WhatsAppContato02': whatsAppContato02,
        'WhatsAppContato03': whatsAppContato03,
        //Redes Sociais

        'Facebook': facebook,
        'Instagram': instagram,
        'LinkedIn': linkedIn,
        'TikTok': tikTok,
        'Pinterest': pinterest,
        'Site': site,
        'Youtube': youtube,
      };

  static PerfilDados fromJson(Map<String, dynamic> json) => PerfilDados(
        id: json["Id"] ?? '',
        idGeral: json["IdGeral"] ?? '',
        email: json['Email'] ?? '',
        nome: json['Nome'] ?? '',
        detalhes: json['Detalhes'] ?? '',
        whatsAppContato: json['WhatsAppContato'] ?? '',
        whatsAppContato02: json['WhatsAppContato02'] ?? '',
        whatsAppContato03: json['WhatsAppContato03'] ?? '',
        //Redes Sociais

        facebook: json['Facebook'] ?? '',
        instagram: json['Instagram'] ?? '',
        linkedIn: json['LinkedIn'] ?? '',
        tikTok: json['TikTok'] ?? '',
        pinterest: json['Pinterest'] ?? '',
        site: json['Site'] ?? '',
        youtube: json['Youtube'] ?? '',
      );
}
