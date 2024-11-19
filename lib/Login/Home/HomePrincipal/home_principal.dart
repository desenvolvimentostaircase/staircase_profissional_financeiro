import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profissional/Login/Home/HomePrincipal/Busca/busca_solicitacao.dart';
import 'package:profissional/Login/Home/HomePrincipal/Clientes/clientes.dart';
import 'package:profissional/Login/Home/HomePrincipal/Contato/contato.dart';
import 'package:profissional/Login/Home/HomePrincipal/Materiais/materiais.dart';
import 'package:profissional/Login/Home/HomePrincipal/Salvos/salvos.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Cores/cores.dart';

class HomePrincipal extends StatefulWidget {
  const HomePrincipal({super.key});

  @override
  State<HomePrincipal> createState() => _HomePrincipalState();
}

class _HomePrincipalState extends State<HomePrincipal> {
  void abrirPagina(Dados dados) {
    var profissional = dados.profissional;
    var cidadeEstado = dados.cidadeEstado;
    var id = dados.id;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BuscaSolicitacao(profissional, cidadeEstado, id),
      ),
    );
  }

  Widget ListTileDados(Dados dados) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: cinza,
          ),
          child: ListTile(
            title: Text(
              dados.profissional,
              style: GoogleFonts.roboto(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              dados.cidadeEstado,
              style: GoogleFonts.roboto(fontSize: 18),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right_rounded,
            ),
            onTap: () {
              var profissional = dados.profissional;
              var cidadeEstado = dados.cidadeEstado;
              var id = dados.id;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BuscaSolicitacao(profissional, cidadeEstado, id),
                ),
              );
            },
          ),
        ),
      );

  String UID = FirebaseAuth.instance.currentUser!.uid.toString();

  /// Le o conteudo
  Stream<List<Dados>> leia() => FirebaseFirestore.instance
      .collection('Profissional')
      .doc(UID)
      .collection("SolicitacoesFiltrosSalvos")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Dados.fromJson(doc.data())).toList());

  List<String> listItemsCidadeEstado = <String>[
    "Três Lagoas - MS",
  ];

  List<String> listItemsProfissional = <String>[
    "Advogado",
    "Airfryer (Manutenção)",
    "Aquecedores de piscina (Manutenção e instalação)",
    "Ar condicionado (Manutenção e Instalação)",
    "Arcondicionado portatil (Manutenção)",
    "Aspirador de pó (Manutenção)",
    "Banho e Tosa",
    "Bebedouro (Manutenção)",
    "Cabeleireira",
    "Cabelereira (Domicilio)",
    "Caçamba",
    "Cafeteira eletrica (Manutenção)",
    "Calheiro",
    "Camera de segurança (Manutenção e Instalação)",
    "Carpinteiro",
    "Cerca eletrica (Manutenção e Instalação)",
    "Chapinha (Manutenção)",
    "Chaveiro",
    "Churrasqueira eletrica (Manutenção)",
    "Climatizador (Manutenção)",
    "Confeitera",
    "Contador",
    "Costureira",
    "Cuidadora",
    "Dedetizador",
    "Dentista",
    "Depilador",
    "Designer de sobrancelha  (domicilio)",
    "Designer de sobrancelha",
    "Eletricista",
    "Encanador",
    "Extensão de cilios",
    "Faxineira",
    "Ferro de passar (Manutenção)",
    "Fogão (Manutenção)",
    "Forno eletrico (Manutenção)",
    "Forro PVC (Manutenção e Instalação)",
    "Freezer (Manutenção)",
    "Fretista (Caminhão)",
    "Fretista (Carretinha)",
    "Geladeira (Manutenção)",
    "Geladeira Comecial (Manutenção)",
    "Gesseiro",
    "Grafica",
    "Guincho",
    "Jardineiro",
    "Lavador a seco (Estofados)",
    "Limpeza terreno",
    "Manicure",
    "Manicure (Domicilio)",
    "Maquiadora",
    "Maquina de lavar roupa (Manutenção)",
    "Marceneiro",
    "Marido de aluguel",
    "Mecanico",
    "Microondas (Manutenção)",
    "Montador de móveis",
    "Motorista (Carro)",
    "Motorista (Moto)",
    "Painel solar (Manutenção e Instalação)",
    "Panela eletrica (Manutenção)",
    "Pedicure",
    "Pedicure (Domicilio)",
    "Pedreiro",
    "Pintor",
    "Podador de arvores",
    "Processador de alimentos (Manutenção)",
    "Professora de reforço escolar (1 ao 5 ano)",
    "Salgadeira",
    "Sanduicheira (Manutenção)",
    "Sapateiro",
    "Secador de cabelo (Manutenção)",
    "Serralheiro",
    "Soldador",
    "Tapeceiro",
    "Tecnico de informatica",
    "Televisão (Manutenção)",
    "Motorista de van escolar",
    "Ventilador (Manutenção)",
    "Ventilador de teto (Manutenção)",
    "Vidraceiro",
  ];

  String _cidadeEstadoSelecionado = "";
  String _profissionalSelecionado = "";
  String detalhesProfissional = "";
  final formKey = GlobalKey<FormState>();
  final TextEditingController _profissionalTextEditingController =
      TextEditingController();
  final TextEditingController _cidadeEstadoTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_profissionalSelecionado == "Advogado") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Resolver precessos ";
    } else if (_profissionalSelecionado == "Airfryer (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n-  manutençaõ do aparelho";
    } else if (_profissionalSelecionado ==
        "Aquecedores de piscina (Manutenção e instalação)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção e instalação do aparelho";
    } else if (_profissionalSelecionado ==
        "Ar condicionado (Manutenção e Instalação)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Limpeza\n- MAnutenção\n- Instalação";
    } else if (_profissionalSelecionado ==
        "Arcondicionado portatil (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Aspirador de pó (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Banho e Tosa") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Bebedouro (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Cabelereira") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Corte de Cabelo\n- Coloração\n- Penteado\n- Tratamentos Capilares\n- Escovação";
    } else if (_profissionalSelecionado == "Cabelereira (Domicilio)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Corte de Cabelo\n- Coloração\n- Penteado\n- Tratamentos Capilares\n- Escovação";
    } else if (_profissionalSelecionado == "Caçamba") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Fornece caçamba para entulho";
    } else if (_profissionalSelecionado == "Cafeteira eletrica (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Calheiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção\n Instalação";
    } else if (_profissionalSelecionado ==
        "Camera de segurança (Manutenção e Instalação)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção\n- Instalação";
    } else if (_profissionalSelecionado == "Carpinteiro") {
      detalhesProfissional = "Função(Averiguar com o profissional)";
    } else if (_profissionalSelecionado ==
        "Cerca eletrica (Manutenção e Instalação)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção\n- Instalação";
    } else if (_profissionalSelecionado == "Chapinha (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Chaveiro Residencial") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Cópia de chaves\n- Reparação de fechaduras:\n -Instalação de fechaduras\n -Serviços de emergência\n - Chaves codificadas\n -Reparação de controles remotos";
    } else if (_profissionalSelecionado ==
        "Churrasqueira eletrica (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Climatizador (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção";
    } else if (_profissionalSelecionado == "Confeitera") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Bolos decorados\n - Cupcakes\n - Tortas\n -Biscoitos decorados\n -Doces finos\n -Sobremesas personalizadas";
    } else if (_profissionalSelecionado == "Contador") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Preparação e Análise de Demonstrações Financeiras\n -Auditoria\n - Gestão de Impostos\n -Análise de Custos\n -Planejamento Financeiro";
    } else if (_profissionalSelecionado == "Costureira") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Costura de roupas\n -Ajustes e reparos\n -Confecção de peças sob medida\n -Design de moda\n -Bordado e apliques:\n -Reparação de roupas danificadas";
    } else if (_profissionalSelecionado == "Cuidadora") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Assistência pessoa\n -Monitoramento da saúde\n -Apoio emocional";
    } else if (_profissionalSelecionado == "Dedetizador") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Identificação das Pragas\n -Inspeção\n -Desenvolvimento de um Plano de Controle\n -Aplicação de Produtos Químicos";
    } else if (_profissionalSelecionado == "Dentista") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Exames e diagnósticos\n -Tratamento de traumas dentários\n -Restaurações estéticas\n -Procedimentos ortodônticos";
    } else if (_profissionalSelecionado == "Depilador") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Seleção da técnica de depilação\n -Preparação da pele\n -";
    } else if (_profissionalSelecionado ==
        "Designer de sobrancelha (domicilio)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Designer de sobrancelha";
    } else if (_profissionalSelecionado == "Designer de sobrancelha") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Designer de sobrancelha";
    } else if (_profissionalSelecionado == "Eletricista") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação elétrica\n- Manutenção e prevenção eletrica\n- Instalação e Manutenção de paineis solares\n- Trocar resistencia de chuveiro\n- Trocar tomada\n- Leitura de plantas elétricas\n- Instalação de sistemas de iluminação\n- Aterramento e proteção contra sobrecargas";
    } else if (_profissionalSelecionado == "Encanador") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação de sistemas de drenagem\n- Reparos em sistemas de aquecimento\n- Manutenção preventiva\n- Inspeções de encanamento\n- Substituição de equipamentos\n- Limpeza de ralos e canos\n- Reparos de vazamentos\n- Instalação de tubulações";
    } else if (_profissionalSelecionado == "Extensão de cilios") {
      detalhesProfissional = "Função(Averiguar com o profissional)";
    } else if (_profissionalSelecionado == "Faxineira") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Realiza limpezas em escritórios e residenciais.";
    } else if (_profissionalSelecionado == "Ferro de passar (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Fogão (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Forno eletrico (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado ==
        "Forro PVC (Manutenção e Instalação)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção e instalação do equipamento";
    } else if (_profissionalSelecionado == "Freezer (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Fretista (Caminhão)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Transporte de carga em grande quantidade\n- Transporte de móveis, eletrodomesticos, etc.";
    } else if (_profissionalSelecionado == "Fretista (Carretinha)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Transporte de carga em pequena quantidade\n- Transporte de móveis, eletrodomesticos, etc.";
    } else if (_profissionalSelecionado == "Geladeira (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Geladeira Comecial (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Gesseiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação de Drywall\n- Revestimento de Paredes e Tetos\n- Moldagem e Modelagem";
    } else if (_profissionalSelecionado == "Grafica") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Cartões de Visita\n- Panfletos e Folhetos\n- Cartazes e Pôsteres:\n- Folders e Brochuras";
    } else if (_profissionalSelecionado == "Jardineiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Consultoria e Orientação\n- Conservação e Limpeza\n- Instalação e Manutenção de Sistemas de Irrigação\n- Manejo de Paisagismo\n- Fertilização\n- Controle de Pragas e Doenças\n- Manutenção, Irrigação, Plantio e Preparação do Solo";
    } else if (_profissionalSelecionado == "Lavador a seco (Estofados)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Limpeza de estofados e móveis\n- Desodorização\n- Tratamento de cortinas e persianas\n- Higienização de colchões\n- Limpeza de tapetes e carpetes: ";
    } else if (_profissionalSelecionado == "Manicure") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Cuidados com as unhas\n- Remoção de cutículas\n- Aplicação de esmalte";
    } else if (_profissionalSelecionado == "Manicure (Domicilio)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Cuidados com as unhas\n- Remoção de cutículas\n- Aplicação de esmalte";
    } else if (_profissionalSelecionado == "Maquiadora") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Maquiagem";
    } else if (_profissionalSelecionado ==
        "Maquina de lavar roupa (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Marceneiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Elaboração de moveis e objetos com madeira maciçam, MDF, compensado, entre outros";
    } else if (_profissionalSelecionado == "Marido de aluguel") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação de Cortinas e Persianas\n- Reparos em Banheiros\n- Isolamento Térmico e Acústico\n- Reparos em Máquinas e Equipamentos\n- Limpeza de Calhas\n- Instalação de Prateleiras e Quadros\n- Manutenção de Jardins\n- Reparos em Pisos e Azulejos\n- Reparos em Portas e Janelas\n- Instalação de Eletrodomésticos\n- Pequenos reparos em carpintaria\n- Reparos em eletrodomésticos\n- Manutenção hidráulica\n- Manutenção elétrica\n- Montagem de móveis\n- Pintura";
    } else if (_profissionalSelecionado == "Mecanico de carro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Mecânicos especializados em reparar e manter carros de passeio";
    } else if (_profissionalSelecionado == "Microondas (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado == "Montador de móveis") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Montar moveis";
    } else if (_profissionalSelecionado == "Motorista (Carro)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Motorista particular";
    } else if (_profissionalSelecionado == "Motorista (Moto)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Motorista particular";
    } else if (_profissionalSelecionado ==
        "Painel solar (Manutenção e Instalação)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação e manutenção do equipamento";
    } else if (_profissionalSelecionado == "Panela eletrica (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação e manutenção do equipamento";
    } else if (_profissionalSelecionado == "Pedicure (Domicilio)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Corte e modelagem das unhas\n- Esfoliação\n- Remoção de calos e calosidades";
    } else if (_profissionalSelecionado == "Pedreiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Assentamento de pisos e azulejos\n- Instalação de portas e janelas\n- Construção de lajes e vigas\n- Reboco e acabamento";
    } else if (_profissionalSelecionado == "Pintor") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Pintura de interiores\n- Pintura decorativa\n- Revestimentos industriais\n- Restauração de pinturas\n -Pintura de exteriores";
    } else if (_profissionalSelecionado == "Podador de árvores") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Podar árvores";
    } else if (_profissionalSelecionado ==
        "Processador de alimentos (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutenção do equipamento";
    } else if (_profissionalSelecionado ==
        "Professora de reforço escolar (1 ao 5 ano)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Identificação de necessidades individuais\n- Planejamento de atividades de reforço\n- Ensino individualizado\n-Língua Portuguesa, Matemática, Ciências, Artes, Ingles ";
    } else if (_profissionalSelecionado == "Salgadeira") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Preparação de salgados de variados tipos, Coxinhas, Pastéis, Bolinhas de queijo, Esfihas, entre outros";
    } else if (_profissionalSelecionado == "Sanduicheira (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutençao do equipamento";
    } else if (_profissionalSelecionado == "Sapateiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Reparação de Calçados\n- Ajustes e Alterações\n- Lustração e Polimento";
    } else if (_profissionalSelecionado == "Secador de cabelo (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutençao do equipamento";
    } else if (_profissionalSelecionado == "Serralheiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Fabricação de estruturas metálicas\n- Soldagem\n- Corte de metal\n- Dobra e moldagem";
    } else if (_profissionalSelecionado == "Soldador ") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Fabricação de estruturas metálicas\n- Soldagem\n- Corte de metal\n- Dobra e moldagem";
    } else if (_profissionalSelecionado == "Tapeceiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Estofamento de móveis\n- Estofamento de veículos\n- Confecção de almofadas, travesseiros e assentos:\n- Reparos em estofamentos danificados";
    } else if (_profissionalSelecionado == "Tecnico de informatica") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação e Manutenção de Hardware,\n- Backup e Recuperação de Dados:\n- Formatação\n";
    } else if (_profissionalSelecionado == "Televisão (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutençao do equipamento";
    } else if (_profissionalSelecionado == "Motorista de van escolar") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Transporte de ida e volta para a escola";
    } else if (_profissionalSelecionado == "Ventilador (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutençao do equipamento";
    } else if (_profissionalSelecionado == "Ventilador de teto (Manutenção)") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Manutençao do equipamento";
    } else if (_profissionalSelecionado == "Vidraceiro") {
      detalhesProfissional =
          "Função(Averiguar com o profissional)\n- Instalação de janelas\n- Instalação de portas de vidro\n- Instalação de espelhos\n- Fabricação e instalação de box de banheiro";
    }

    return Scaffold(
      backgroundColor: cinzaClaro,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: ListView(
            children: [
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Home",
                      style: GoogleFonts.roboto(
                        color: azul,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),

                    ///
                    FilledButton.icon(
                      label: Text(
                        "Suporte",
                        style: GoogleFonts.roboto(
                          color: cinzaClaro,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: Icon(FontAwesomeIcons.whatsapp),
                      onPressed: () async {
                        Uri whatsappUrl = Uri.parse(
                            "whatsapp://send?phone=+5567991415217&text=Oi, venho do Staircase Cliente, poderia me ajudar?");

                        if (await canLaunchUrl(whatsappUrl)) {
                          await launchUrl(whatsappUrl);
                        } else {
                          throw 'Could not launch $whatsappUrl';
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, right: 20, bottom: 10),
                        backgroundColor: verde,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Aqui você poderá organizar os seus clientes",
                style: GoogleFonts.roboto(
                  color: cinzaEscuro,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 10,
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
                                Icons.bookmark,
                                color: cinzaClaro,
                                size: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Salvos",
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
                            builder: (context) => const Salvos(),
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
                                  color: azul),
                              height: 75,
                              width: 75,
                              child: Icon(
                                Icons.groups,
                                color: cinzaClaro,
                                size: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Clientes",
                              style: GoogleFonts.roboto(
                                color: azul,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Clientes(),
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
                                  color: azul),
                              height: 75,
                              width: 75,
                              child: Icon(
                                Icons.contact_phone_rounded,
                                color: cinzaClaro,
                                size: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                "Profissões",
                                style: GoogleFonts.roboto(
                                  color: azul,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContatoProfissicoes(),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),

                    //Materiais
                    GestureDetector(
                      child: SizedBox(
                        height: 120,
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
                                Icons.newspaper,
                                color: cinzaClaro,
                                size: 40,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Materiais",
                              style: GoogleFonts.roboto(
                                color: azul,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Materiais(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Solicitações",
                            style: GoogleFonts.roboto(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //IconButton(
                          //  icon: Icon(
                          //    Icons.info,
                          //    size: 30,
                          //  ),
                          //  onPressed: () {},
                          //),
                        ],
                      ),
                    ),

                    //Botão
                    FilledButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        backgroundColor: azul,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        popupAdicionarFiltroSolcitacoesProfissional(context);
                      },
                      label: Text(
                        "Buscar",
                      ),
                      icon: Icon(Icons.search),
                    ),
                  ],
                ),
              ),

              //Leitura dos filtros salvos
              Container(
                color: cinzaClaro,
                height: MediaQuery.of(context).size.height * 0.22,
                child: StreamBuilder<List<Dados>>(
                  stream: leia(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wong! ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      final leiaDados = snapshot.data!;
                      return ListView.builder(
                        itemCount: leiaDados.length,
                        itemBuilder: (context, index) {
                          final dados = leiaDados[index];
                          return ListTileDados(dados);
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
              SizedBox(
                height: 10,
              ),

              Container(
                child: Row(
                  children: [
                    Text(
                      "Solicitações diretas",
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //IconButton(
                          //  icon: Icon(
                          //    Icons.info,
                          //    size: 30,
                          //  ),
                          //  onPressed: () {},
                          //),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //PopUp para adicionar o filtro de solicitação do Profissional
  Future popupAdicionarFiltroSolcitacoesProfissional(context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: cinzaClaro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: Text(
            "Buscar",
            style: GoogleFonts.roboto(
              fontSize: 40,
              color: azul,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            height: MediaQuery.sizeOf(context).width * 0.8,
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Text("Preencha os campos conforme as suas habilidades"),
                  SizedBox(
                    height: 30,
                  ),

                  ///Profissional
                  TypeAheadFormField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _profissionalTextEditingController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: cinza,
                          suffixIconColor: azul,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _profissionalTextEditingController.clear();
                              });
                            },
                            icon: Icon(
                              Icons.close,
                            ),
                          ),
                          hintStyle: GoogleFonts.roboto(),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: vermelho,
                              width: 3,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: cinza,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: azul,
                              width: 3,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: vermelho,
                              width: 3,
                            ),
                          ),
                          hintText: "Profissional"),
                    ),
                    onSaved: (value) {
                      _profissionalSelecionado = value.toString();
                    },
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !listItemsProfissional.contains(value)) {
                        return 'Selecione um profisional ou serviço';
                      }
                      return null;
                    },
                    suggestionsCallback: (pattern) {
                      return listItemsProfissional.where((option) =>
                          option.toLowerCase().contains(pattern.toLowerCase()));
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        _profissionalSelecionado = suggestion;
                        _profissionalTextEditingController.text = suggestion;
                      });
                    },
                  ),

                  ///detalhes do profissional
                  detalhesProfissional == ""
                      ? SizedBox(
                          height: 10,
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                          ),
                          child: SizedBox(
                            height: 93,
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                              children: [
                                Text(
                                  detalhesProfissional,
                                  style: GoogleFonts.roboto(
                                    color: cinzaEscuro,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                  ///Cidade
                  TypeAheadFormField<String>(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _cidadeEstadoTextEditingController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: cinza,
                          suffixIconColor: azul,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _cidadeEstadoTextEditingController.clear();
                              });
                            },
                            icon: Icon(
                              Icons.close,
                            ),
                          ),
                          hintStyle: GoogleFonts.roboto(),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: vermelho,
                              width: 3,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: cinza,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: azul,
                              width: 3,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: vermelho,
                              width: 3,
                            ),
                          ),
                          hintText: "Cidade"),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !listItemsCidadeEstado.contains(value)) {
                        return 'Selecione uma cidade';
                      }
                      return null;
                    },
                    suggestionsCallback: (pattern) {
                      return listItemsCidadeEstado.where((option) =>
                          option.toLowerCase().contains(pattern.toLowerCase()));
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSaved: (value) {
                      _cidadeEstadoSelecionado = value.toString();
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {
                        _cidadeEstadoSelecionado = suggestion;
                        _cidadeEstadoTextEditingController.text = suggestion;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ///Voltar
            ElevatedButton(
              child: Text(
                "Voltar",
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                backgroundColor: cinzaClaro,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            ///Confirmar
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
                final isValidForm = formKey.currentState!.validate();

                if (isValidForm) {
                  final dados = Dados(
                    cidadeEstado: _cidadeEstadoSelecionado,
                    profissional: _profissionalSelecionado,
                  );
                  _profissionalTextEditingController.clear();
                  _cidadeEstadoTextEditingController.clear();
                  Navigator.pop(context);
                  abrirPagina(dados);
                }
              },
            ),
          ],
        ),
      );
}

//Dados
class Dados {
  String id;
  final String profissional;
  final String cidadeEstado;

  Dados({
    this.id = '',
    required this.profissional,
    required this.cidadeEstado,
  });

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Profissional': profissional,
        'CidadeEstado': cidadeEstado,
      };

  static Dados fromJson(Map<String, dynamic> json) => Dados(
        id: json["Id"] ?? '',
        profissional: json['Profissional'] ?? '',
        cidadeEstado: json['CidadeEstado'] ?? '',
      );
}
