import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profissional/Dashboard/Servicos/ganhosServico.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

Future<void> gerarArquivoExcel() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  //Cria um novo arquivo Excel
  var excel = Excel.createExcel();

  //Acessa a primeira aba da planilha
  Sheet sheet = excel['Sheet1'];

  //Define o cabeçalho
  sheet.cell(CellIndex.indexByString("A1")).value = TextCellValue("Titulo");
  sheet.cell(CellIndex.indexByString("B1")).value = TextCellValue("Descricao");
  sheet.cell(CellIndex.indexByString("C1")).value = TextCellValue("Data");
  sheet.cell(CellIndex.indexByString("D1")).value = TextCellValue("Valor");
  sheet.cell(CellIndex.indexByString("E1")).value =
      TextCellValue("Nome Cliente");
  sheet.cell(CellIndex.indexByString("F1")).value = TextCellValue("Whatsapp");

  //Buscar os dados no Firestore
  QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection("Profissional")
      .doc(userId)
      .collection("Ganhos")
      .get();

//Preenche os dados na planilha
  for (var doc in snapshot.docs) {
    var dados = doc.data();
    sheet.appendRow([
      dados['titulo'] ?? '',
      dados['descricao'] ?? '',
      dados['data'] ?? '',
      dados['valor'] ?? '',
      dados['nomeCliente'] ?? '',
      dados['whatsapp'] ?? '' ,      
    ]);
  }

  //Define o caminho para a pasta temporária do aplicativo
  Directory tempDir = await getTemporaryDirectory();
  String outputPath = '${tempDir.path}/relatório.xlsx';

  //Salva o arquivo
  var fileBytes = excel.save();
  File(outputPath)
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);

  //Cria um file para compartilhar
  final XFile file = XFile(outputPath);

  //Usa o shareXfiles para compartilhar o arquivo
  await Share.shareXFiles([file], text: "Relatório");
}
