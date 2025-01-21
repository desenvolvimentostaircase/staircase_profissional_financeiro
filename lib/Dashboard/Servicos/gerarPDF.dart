import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> gerarPDF() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final pdf = pw.Document();
  final firestore = FirebaseFirestore.instance;

  //Consultar os dados do firestore
  final querySnapshot = await firestore
      .collection("Profissional")
      .doc(userId)
      .collection("Ganhos")
      .get();

  //Processa os dados retornados
  final List<Map<String, dynamic>> dados = querySnapshot.docs.map((doc) {
    return doc.data();
  }).toList();

  //Adiciona uma página ao PDF
  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "Relatório de Ganhos",
            style: pw.TextStyle(
              fontSize: 24,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: {
              0: pw.FlexColumnWidth(2),
              1: pw.FlexColumnWidth(3),
              2: pw.FlexColumnWidth(2),
            },
            children: [
              pw.TableRow(
                children: [
                  pw.Text('Titulo',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Descrição',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Valor',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Nome Cliente',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Whatsapp',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ],
              ),
              ...dados.map((dado) {
                return pw.TableRow(
                  children: [
                    pw.Text(dado['titulo'] ?? ''),
                    pw.Text(dado['descricao'] ?? ''),
                    pw.Text(dado['valor']?.toStringAsFixed(2) ?? '0.00'),
                    pw.Text(dado['nomeCliente'] ?? ''),
                    pw.Text(dado['whatsapp'] ?? ''),
                  ],
                );
              }).toList(),
            ],
          ),
        ],
      ),
    ),
  );

  //Salva o PDF em um arquivo
  final output = await getTemporaryDirectory();
  final file = File("${output.path}/relatorio.pdf");
  await file.writeAsBytes(await pdf.save());

  //Abre o PDF
  await Printing.sharePdf(bytes: await pdf.save(), filename: 'relatorio.pdf');
}
