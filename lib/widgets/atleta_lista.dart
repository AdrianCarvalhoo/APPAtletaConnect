import 'package:atividade_lista_pags/models/atleta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AtletaLista extends StatelessWidget {
  Atleta pessoa;
  Function onDelete;
  Function editarFunc;

  AtletaLista(
      {required this.pessoa, required this.onDelete, required this.editarFunc});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 180,
        color: Colors.grey.withOpacity(0.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      pessoa.nome,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    editarFunc();
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Excluir?'),
                              content: Text('Tem certeza que deseja excluir?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      onDelete();
                                      Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                        primary: Color(0xffb2ff59)),
                                    child: Text('Sim')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: TextButton.styleFrom(
                                        primary: Color(0xffb2ff59)),
                                    child: Text('Não')),
                              ],
                            ));
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Text(pessoa.cpf),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Text(pessoa.telefone),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Text(pessoa.dataNascimento),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Text(pessoa.esporte),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Text(pessoa.nivelCategoria),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Text('${validadorEstudante(pessoa)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

validadorEstudante(Atleta pessoa) {
  if (pessoa.estudante == true) {
    return 'Estudante';
  } else {
    return '';
  }
}
