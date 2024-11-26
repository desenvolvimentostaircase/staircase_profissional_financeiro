import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Model/despesasModelo.dart';

class DespesasServico {
  String userId;
  DespesasServico() : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarDespesas(DespesasModelo despesasModelo) async {
    await _firestore
        .collection("Profissional")
        .doc(userId)
        .collection("Despesas")
        .doc(despesasModelo.id)
        .set(despesasModelo.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> conectarStreamDespesas() {
    return _firestore
        .collection("Profissional")
        .doc(userId)
        .collection("Despesas")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> conectarStreamDespesasFiltradas(
      DateTime inicio, DateTime fim) {
    return FirebaseFirestore.instance
        .collection("Profissional")
        .doc(userId)
        .collection("Despesas")
        .where('data', isGreaterThanOrEqualTo: inicio)
        .where('data', isLessThanOrEqualTo: fim)
        .snapshots();
  }

  Future<void> removerDespesas({required String? idDespesa}) {
    return _firestore
        .collection("Profissional")
        .doc(userId)
        .collection("Despesas")
        .doc(idDespesa)
        .delete();
  }
}
