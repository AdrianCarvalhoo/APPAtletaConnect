import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/torneio.dart';

class ConsultaTorneio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Torneio> torneios = TorneioSingleton().torneios;

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Consulta Torneio',
        style: TextStyle(
          color: Colors.black45,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
          fontSize: 30,
        ),
      )),
      body: ListView.builder(
        itemCount: torneios.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(torneios[index].nome),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Local: ${torneios[index].local}'),
                Text('Nível: ${torneios[index].nivel}'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetalhesTorneio(torneio: torneios[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetalhesTorneio extends StatefulWidget {
  final Torneio torneio;

  DetalhesTorneio({required this.torneio});

  @override
  _DetalhesTorneioState createState() => _DetalhesTorneioState();
}

class _DetalhesTorneioState extends State<DetalhesTorneio> {
  Usuario? parceiroDupla;
  bool isTorneioInscrito = false;
  String? inscricaoId;

  void _realizarInscricao(BuildContext context) {
    if (parceiroDupla == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selecione um parceiro de dupla!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      bool inscricaoRealizada = realizarInscricaoNoTorneio(parceiroDupla!);

      if (inscricaoRealizada) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Inscrição realizada com sucesso!'),
            duration: Duration(seconds: 2),
          ),
        );

        setState(() {
          isTorneioInscrito = true;
          inscricaoId = generateInscricaoId();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao realizar a inscrição.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  bool realizarInscricaoNoTorneio(Usuario parceiroDupla) {
    bool inscricaoRealizada = true;

    return inscricaoRealizada;
  }

  String generateInscricaoId() {
    String timestamp = DateTime.now().toIso8601String();
    String torneioId = widget.torneio.id;
    return '$timestamp-$torneioId';
  }

  void _selecionarParceiroDupla() async {
    final parceiroSelecionado = await Navigator.push<Usuario?>(
      context,
      MaterialPageRoute(
        builder: (context) => TelaSelecaoParceiro(),
      ),
    );
    if (parceiroSelecionado != null) {
      setState(() {
        parceiroDupla = parceiroSelecionado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes do Torneio',
          style: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Nome:'),
            subtitle: Text(widget.torneio.nome),
          ),
          ListTile(
            title: Text('Local:'),
            subtitle: Text(widget.torneio.local),
          ),
          ListTile(
            title: Text('Categoria:'),
            subtitle: Text(widget.torneio.categoria),
          ),
          ListTile(
            title: Text('Nível:'),
            subtitle: Text(widget.torneio.nivel),
          ),
          ListTile(
            title: Text('ID:'),
            subtitle: Text(widget.torneio.id),
          ),
          ListTile(
            title: Text('Parceiro de Dupla:'),
            subtitle: Text(parceiroDupla?.nome ?? 'Selecione um parceiro'),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: _selecionarParceiroDupla,
            child: Text(
              'Selecionar Parceiro',
              style: TextStyle(color: Colors.grey[800]),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.lightGreenAccent.withOpacity(0.7),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () => _realizarInscricao(context),
            child: Text(
              'Realizar Inscrição',
              style: TextStyle(color: Colors.grey[800]),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.lightGreenAccent.withOpacity(0.7),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Visibility(
            visible: isTorneioInscrito,
            child: Column(
              children: [
                Text(
                  'Você já está inscrito neste torneio.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'ID de inscrição: $inscricaoId',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TelaSelecaoParceiro extends StatefulWidget {
  @override
  _TelaSelecaoParceiroState createState() => _TelaSelecaoParceiroState();
}

class _TelaSelecaoParceiroState extends State<TelaSelecaoParceiro> {
  List<Usuario> usuarios = [
    Usuario(nome: 'Matheusilva'),
    Usuario(nome: 'Lucasoliveira'),
    Usuario(nome: 'Gabrielpereira'),
    Usuario(nome: 'Pedrofernandes'),
    Usuario(nome: 'Felipesantos'),
    Usuario(nome: 'Rafaelcosta'),
    Usuario(nome: 'Amandasouza'),
    Usuario(nome: 'Carolinamartins'),
    Usuario(nome: 'Julianaferreira'),
    Usuario(nome: 'Thiagoalmeida'),
    Usuario(nome: 'Renatobarbosa'),
    Usuario(nome: 'Isabellaribeiro'),
    Usuario(nome: 'Gustavolima'),
    Usuario(nome: 'Mariafernanda'),
    Usuario(nome: 'Andresilva'),
    Usuario(nome: 'Camilaoliveira'),
    Usuario(nome: 'Arthursantos'),
    Usuario(nome: 'Marianacosta'),
    Usuario(nome: 'Lucianorodrigues'),
    Usuario(nome: 'Larissaalves')
  ];

  Usuario? parceiroSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleção de Parceiro de Dupla'),
      ),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final usuario = usuarios[index];
          return ListTile(
            title: Text(usuario.nome),
            onTap: () {
              setState(() {
                parceiroSelecionado = usuario;
              });
              Navigator.pop(context, parceiroSelecionado);
            },
          );
        },
      ),
    );
  }
}

class Usuario {
  final String nome;

  Usuario({required this.nome});
}
