import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:profissional/Dashboard/Servicos/ganhosServico.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

Future<void> gerarArquivoExcel() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  //Cria um novo arquivo Excel
  var excel = Excel.createExcel();

  //Renomeia a aba padrao "Sheet1"
  excel.rename("Sheet1", "Ganhos");

  //Acessa a primeira aba da planilha
  Sheet sheetGanhos = excel['Ganhos'];
  Sheet sheetDespesas = excel['Despesas'];

  //Define o cabeçalho da aba Ganhos
  sheetGanhos.cell(CellIndex.indexByString("A1")).value =
      TextCellValue("Titulo");
  sheetGanhos.cell(CellIndex.indexByString("B1")).value =
      TextCellValue("Descricao");
  sheetGanhos.cell(CellIndex.indexByString("C1")).value = TextCellValue("Data");
  sheetGanhos.cell(CellIndex.indexByString("D1")).value =
      TextCellValue("Valor");
  sheetGanhos.cell(CellIndex.indexByString("E1")).value =
      TextCellValue("Nome Cliente");
  sheetGanhos.cell(CellIndex.indexByString("F1")).value =
      TextCellValue("Whatsapp");

  //Buscar os dados no Firestore
  QuerySnapshot<Map<String, dynamic>> snapshotGanhos = await FirebaseFirestore
      .instance
      .collection("Profissional")
      .doc(userId)
      .collection("Ganhos")
      .get();

  //Verifica se há dados
  if (snapshotGanhos.docs.isEmpty) {
    print("Nenhum dado encontrado");
    return;
  }

  //Converter os dados para uma lista local
  List<Map<String, dynamic>> dadosBuscaGanhos =
      snapshotGanhos.docs.map((doc) => doc.data()).toList();

  //Preenche os dados na planilha
  for (int i = 0; i < dadosBuscaGanhos.length; i++) {
    var dados = dadosBuscaGanhos[i];

    String titulo = dados['titulo'];
    String descricao = dados['descricao'];
    String dataFormatada = DateFormat('dd/MM/yyyy', 'pt_BR')
        .format((dados['data'] as Timestamp).toDate());
    String valor = dados['valor'].toStringAsFixed(2);
    String nomeCliente = dados['nomeCliente'];
    String whatsapp = dados['whatsapp'];

    sheetGanhos
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
        .value = TextCellValue(titulo);

    sheetGanhos
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
        .value = TextCellValue(descricao);

    sheetGanhos
        .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
        .value = TextCellValue(dataFormatada);

    sheetGanhos
        .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
        .value = TextCellValue(valor);

    sheetGanhos
        .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
        .value = TextCellValue(nomeCliente);

    sheetGanhos
        .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
        .value = TextCellValue(whatsapp);
  }

  //Define o cabeçalho da aba Despesas
  sheetDespesas.cell(CellIndex.indexByString("A1")).value =
      TextCellValue("Titulo");
  sheetDespesas.cell(CellIndex.indexByString("B1")).value =
      TextCellValue("Descricao");
  sheetDespesas.cell(CellIndex.indexByString("C1")).value =
      TextCellValue("Data");
  sheetDespesas.cell(CellIndex.indexByString("D1")).value =
      TextCellValue("Valor");

  //Buscar os dados no Firestore
  QuerySnapshot<Map<String, dynamic>> snapshotDespesas = await FirebaseFirestore
      .instance
      .collection("Profissional")
      .doc(userId)
      .collection("Despesas")
      .get();

  //Verifica se há dados
  if (snapshotDespesas.docs.isEmpty) {
    print("Nenhum dado encontrado");
    return;
  }

  //Converter os dados para uma lista local
  List<Map<String, dynamic>> dadosBuscaDespesas =
      snapshotDespesas.docs.map((doc) => doc.data()).toList();

  //Preenche os dados na planilha
  for (int i = 0; i < dadosBuscaDespesas.length; i++) {
    var dados = dadosBuscaDespesas[i];

    String titulo = dados['titulo'];
    String descricao = dados['descricao'];
    String dataFormatada = DateFormat('dd/MM/yyyy', 'pt_BR')
        .format((dados['data'] as Timestamp).toDate());
    String valor = dados['valor'].toStringAsFixed(2);

    sheetDespesas
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
        .value = TextCellValue(titulo);

    sheetDespesas
        .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
        .value = TextCellValue(descricao);

    sheetDespesas
        .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
        .value = TextCellValue(dataFormatada);

    sheetDespesas
        .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
        .value = TextCellValue(valor);
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
