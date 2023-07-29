import 'package:flutter/cupertino.dart';

class Torneio {
  String id;
  String local;
  String nome;
  String categoria;
  String nivel;

  Torneio({
    required this.id,
    required this.local,
    required this.nome,
    required this.categoria,
    required this.nivel,
  });
}

String gerarID() {
  var timestamp = DateTime.now().millisecondsSinceEpoch;
  return timestamp.toString();
}

class TorneioSingleton {
  static final TorneioSingleton _singleton = TorneioSingleton._internal();

  List<Torneio> _torneios = [];

  factory TorneioSingleton() {
    return _singleton;
  }

  TorneioSingleton._internal();

  List<Torneio> get torneios {
    return _torneios;
  }

  void adicionarTorneio(Torneio torneio) {
    _torneios.add(torneio);
  }
}
