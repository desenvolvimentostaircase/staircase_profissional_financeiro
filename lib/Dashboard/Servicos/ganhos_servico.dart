import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:profissional/Dashboard/Model/ganhos_modelo.dart';

class GanhosServico {
  String userId;
  GanhosServico() : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarGanhos(GanhosModelo ganhosModelo) async {
    await _firestore
        .collection("Profissional")
        .doc(userId)
        .collection("Ganhos")
        .doc(ganhosModelo.id)
        .set(ganhosModelo.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> conectarStreamGanhos() {
    return _firestore
        .collection("Profissional")
        .doc(userId)
        .collection("Ganhos")
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> conectarStreamGanhosFiltrados(
      DateTime inicio, DateTime fim) {
    return FirebaseFirestore.instance
        .collection("Profissional")
        .doc(userId)
        .collection("Ganhos")
        .where('data', isGreaterThanOrEqualTo: inicio)
        .where('data', isLessThanOrEqualTo: fim)
        .snapshots();
  }

  Future<void> removerGanhos({required String? idGanho, String? IdGanho}) {
    return _firestore
        .collection("Profissional")
        .doc(userId)
        .collection("Ganhos")
        .doc(idGanho)
        .delete();
  }
}
