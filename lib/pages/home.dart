import 'dart:ui';
import 'package:atividade_lista_pags/models/atleta.dart';
import 'package:atividade_lista_pags/pages/cadastro.dart';
import 'package:atividade_lista_pags/widgets/atleta_lista.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Atleta> listaAtleta = [];

  _sortList() {
    listaAtleta.sort((p1, p2) {
      return p1.nome.compareTo(p2.nome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'https://static.vecteezy.com/system/resources/previews/001/196/370/non_2x/run-speed-png.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 10),
            Text(
              'Atleta',
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://th.bing.com/th/id/OIG.vAUl.uywQziig08Woiyp?pid=ImgGn',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 3.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  child: Image.network(
                    'https://i.ibb.co/2q9vv0H/logotest.png',
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 10.0),
                    shrinkWrap: true,
                    itemCount: listaAtleta.length,
                    itemBuilder: (context, index) {
                      return AtletaLista(
                        pessoa: listaAtleta[index],
                        editarFunc: () {
                          _editar(index);
                        },
                        onDelete: () {
                          setState(() {
                            listaAtleta.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.lightGreenAccent.withOpacity(0.7),
        onPressed: () async {
          final pessoa = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cadastro(),
              ));
          if (pessoa != null) {
            listaAtleta.add(pessoa);

            setState(() {
              _sortList();
            });
          }
        },
        label: Text('Adicionar Atleta'),
      ),
    );
  }

  _editar(int index) async {
    Atleta pessoaSelecionada = listaAtleta[index];

    Atleta? pessoa = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Cadastro(
                  atletaSelecionado: pessoaSelecionada,
                )));
    if (pessoa != null) {
      listaAtleta.removeAt(index);
      listaAtleta.add(pessoa);
      _sortList();
      setState(() {});
    }
  }
}
