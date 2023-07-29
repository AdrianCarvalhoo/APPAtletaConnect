import 'dart:ui';
import 'package:atividade_lista_pags/models/torneio.dart';
import 'package:atividade_lista_pags/pages/cadastroTorneio.dart';
import 'package:atividade_lista_pags/widgets/torneio_lista.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTorneio extends StatefulWidget {
  const HomeTorneio({Key? key}) : super(key: key);

  @override
  State<HomeTorneio> createState() => _HomeTorneioState();
}

class _HomeTorneioState extends State<HomeTorneio> {
  List<Torneio> listaTorneio = [];

  _sortList() {
    listaTorneio.sort((p1, p2) {
      return p1.local.compareTo(p2.local);
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
              'https://th.bing.com/th/id/OIG.6FRDxGtb19eeFmyPi5yw?pid=ImgGn',
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
                    itemCount: listaTorneio.length,
                    itemBuilder: (context, index) {
                      return TorneioLista(
                        campeonato: listaTorneio[index],
                        editarFunc: () {
                          _editar(index);
                        },
                        onDelete: () {
                          setState(() {
                            listaTorneio.removeAt(index);
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
          final campeonato = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CadastroTorneio(),
              ));
          if (campeonato != null) {
            listaTorneio.add(campeonato);

            setState(() {
              _sortList();
            });
          }
        },
        label: Text('Adicionar Torneio'),
      ),
    );
  }

  _editar(int index) async {
    Torneio torneioSelecionada = listaTorneio[index];

    Torneio? campeonato = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CadastroTorneio(
                  torneioSelecionado: torneioSelecionada,
                )));
    if (campeonato != null) {
      listaTorneio.removeAt(index);
      listaTorneio.add(campeonato);
      _sortList();
      setState(() {});
    }
  }
}
