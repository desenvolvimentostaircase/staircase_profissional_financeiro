import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DespesasModelo {
  String id;
  String titulo;
  String descricao;
  DateTime data;
  double valor;

  DespesasModelo({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.data,
    required this.valor,
  });

  String get dataFormatada {
    return DateFormat('dd/MM/yyyy', 'pt_BR').format(data);
  }

//Método para converter um map para o objeto Mensagem(vindo do banco de dados)
  DespesasModelo.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        titulo = map["titulo"],
        descricao = map["descricao"],
        data = (map['data'] as Timestamp).toDate(),
        valor = map["valor"];

  //Método para converter um objeto Mensagem em map (enviar para o banco de dados)
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "titulo": titulo,
      "descricao": descricao,
      "data": Timestamp.fromDate(data),
      "valor": valor,
    };
  }
}
