import 'package:atividade_lista_pags/models/torneio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:flutter/src/widgets/framework.dart';

List<String> categoriasEsportes = [
  'Futebol',
  'Vôlei',
  'Basquete',
  'Futebol de salão (Futsal)',
  'Futebol society'
];

List<String> nivelCategoria = [
  'Categoria:juvenil[1]',
  'Categoria:amador[2]',
  'Categoria:intermediário[3]',
  'Categoria:profissional[4]'
];

class CadastroTorneio extends StatefulWidget {
  Torneio? torneioSelecionado;
  CadastroTorneio({Key? key, this.torneioSelecionado}) : super(key: key);

  @override
  State<CadastroTorneio> createState() => _CadastroTorneioState();
}

class _CadastroTorneioState extends State<CadastroTorneio> {
  final localController = TextEditingController();
  final idController = TextEditingController();
  final nomeTorneioController = TextEditingController();
  final categoriaController = TextEditingController();
  final nivelController = TextEditingController();

  GlobalKey<FormState> _localFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _idFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _nomeTorneioFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _categoriaFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _nivelFormKey = GlobalKey<FormState>();

  String _categoriaEsporteSelecionada = categoriasEsportes[0];
  String _nivelCategoriaSelecionado = nivelCategoria[0];

  @override
  void initState() {
    if (widget.torneioSelecionado != null) {
      localController.text = widget.torneioSelecionado!.local;
      nomeTorneioController.text = widget.torneioSelecionado!.nome;
      _categoriaEsporteSelecionada = widget.torneioSelecionado!.categoria;
      _nivelCategoriaSelecionado = widget.torneioSelecionado!.nivel;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (localController.text != '' ||
            nomeTorneioController.text != '' ||
            categoriaController.text != '' ||
            nivelController.text != '') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Descartar?'),
              content: Text('Tem certeza?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(primary: Color(0xffb2ff59)),
                    child: Text('Sim')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(primary: Color(0xffb2ff59)),
                    child: Text('Não')),
              ],
            ),
          );
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                'Cadastro Torneio',
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(13.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://th.bing.com/th/id/OIG.1ACSVILtrfJ8vHN59Pjq?pid=ImgGn'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Card(
                    color: Colors.grey.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.only(top: 0.0),
                    child: SizedBox(
                      width: 400,
                      height: 580,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 20, left: 20),
                        child: Column(
                          children: [
                            Form(
                              key: _nomeTorneioFormKey,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (_nomeTorneioFormKey.currentState!
                                      .validate()) {}
                                },
                                validator: (value) {
                                  if (!RegExp(r'[A-Z]+[a-z]')
                                      .hasMatch(value ?? '')) {
                                    return 'A primeira letra deve ser maiúscula!';
                                  } else if (value == '') {
                                    return 'Nome obrigatório!';
                                  }
                                },
                                controller: nomeTorneioController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(80),
                                  ),
                                  label: Text('Nome do Torneio'),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: _localFormKey,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (_localFormKey.currentState!.validate()) {}
                                },
                                validator: (value) {
                                  if (!RegExp(r'[A-Z]+[a-z]')
                                      .hasMatch(value ?? '')) {
                                    return 'A primeira letra deve ser maiúscula!';
                                  } else if (value == '') {
                                    return 'Nome obrigatório!';
                                  }
                                },
                                controller: localController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(80),
                                  ),
                                  label: Text('Local'),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: _categoriaFormKey,
                              child: DropdownButtonFormField<String>(
                                value: _categoriaEsporteSelecionada,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _categoriaEsporteSelecionada = newValue!;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Escolha uma categoria de esporte!';
                                  }
                                  return null;
                                },
                                items: categoriasEsportes.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(80),
                                  ),
                                  label: Text('Esporte'),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: _nivelFormKey,
                              child: DropdownButtonFormField<String>(
                                value: _nivelCategoriaSelecionado,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _nivelCategoriaSelecionado = newValue!;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Escolha o nível do torneio!';
                                  }
                                  return null;
                                },
                                items: nivelCategoria.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(80),
                                  ),
                                  label: Text('Nível'),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      Colors.lightGreenAccent.withOpacity(0.7),
                                  fixedSize: Size(300, 40)),
                              onPressed: _salvar,
                              child: Text(
                                'Cadastrar',
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _salvar() {
    bool localValido = _localFormKey.currentState!.validate();
    bool horarioValido = _nomeTorneioFormKey.currentState!.validate();
    bool categoriaValido = _categoriaFormKey.currentState!.validate();
    bool nivelValido = _nivelFormKey.currentState!.validate();

    if (localValido && horarioValido && categoriaValido && nivelValido) {
      _confirmaSalvar();
    }
  }

  _confirmaSalvar() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Salvar?'),
              content: Text('Tem certeza que deseja salvar?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(primary: Color(0xffb2ff59)),
                    child: Text('Não')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _retornarNovaTorneio();
                    },
                    style: TextButton.styleFrom(primary: Color(0xffb2ff59)),
                    child: Text('Sim')),
              ],
            ));
  }

  _retornarNovaTorneio() {
    Torneio campeonato = Torneio(
      local: localController.text,
      nome: nomeTorneioController.text,
      categoria: _categoriaEsporteSelecionada,
      nivel: _nivelCategoriaSelecionado,
      id: gerarID(),
    );

    TorneioSingleton().adicionarTorneio(campeonato);

    Navigator.pop(context, campeonato);
  }

  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Continuar?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              if (localController != null &&
                  nomeTorneioController != null &&
                  categoriaController != null &&
                  nivelController != null) {
                Navigator.pop(context);
                Navigator.pop(
                    context,
                    Torneio(
                        local: localController.text,
                        nome: nomeTorneioController.text,
                        categoria: categoriaController.text,
                        nivel: nivelController.text,
                        id: gerarID()));
              }
            });
          },
          child: Text(
            'OK',
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Voltar',
          ),
        ),
      ],
    );
  }
}
