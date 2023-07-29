import 'package:atividade_lista_pags/models/atleta.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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

class Cadastro extends StatefulWidget {
  Atleta? atletaSelecionado;

  Cadastro({Key? key, this.atletaSelecionado}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  List<Atleta> listaAtletas = [];

  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final telefoneController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final esporteController = TextEditingController();
  final nivelCategoriaController = TextEditingController();
  bool validadorEstudante = true;

  GlobalKey<FormState> _nomeFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _cpfFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _telefoneFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _dataNascimentoFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _categoriaEsporteFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> _nivelCategoriaFormKey = GlobalKey<FormState>();

  String _categoriaEsporteSelecionada = categoriasEsportes[0];
  String _nivelCategoriaSelecionado = nivelCategoria[0];

  @override
  void initState() {
    if (widget.atletaSelecionado != null) {
      nomeController.text = widget.atletaSelecionado!.nome;
      cpfController.text = widget.atletaSelecionado!.cpf;
      telefoneController.text = widget.atletaSelecionado!.telefone;
      dataNascimentoController.text = widget.atletaSelecionado!.dataNascimento;
      _categoriaEsporteSelecionada = widget.atletaSelecionado!.esporte;
      _nivelCategoriaSelecionado = widget.atletaSelecionado!.nivelCategoria;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (nomeController.text != '' ||
            cpfController.text != '' ||
            telefoneController.text != '' ||
            dataNascimentoController.text != '' ||
            esporteController.text != '' ||
            nivelCategoriaController.text != '') {
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
                'Cadastro',
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
                          'https://th.bing.com/th/id/OIG.5tlPtdmu0xx5Qn5HyJvN?pid=ImgGn'),
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
                              key: _nomeFormKey,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (_nomeFormKey.currentState!.validate()) {}
                                },
                                validator: (value) {
                                  if (!RegExp(r'[A-Z]+[a-z]')
                                      .hasMatch(value ?? '')) {
                                    return 'A primeira letra deve ser maiúscula!';
                                  } else if (value == '') {
                                    return 'Nome obrigatório!';
                                  }
                                },
                                controller: nomeController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(80),
                                  ),
                                  label: Text('Nome'),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: _cpfFormKey,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (_cpfFormKey.currentState!.validate()) {}
                                },
                                validator: (value) {
                                  if (!RegExp(r'[0-9]').hasMatch(value ?? '')) {
                                    return 'Digite um CPF válido!';
                                  } else if (value == '') {
                                    return 'CPF obrigatório!';
                                  }
                                },
                                controller: cpfController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  MaskTextInputFormatter(
                                      mask: '###.###.###-##'),
                                ],
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80)),
                                  label: Text('CPF'),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: _telefoneFormKey,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (_telefoneFormKey.currentState!
                                      .validate()) {}
                                },
                                validator: (value) {
                                  if (!RegExp(
                                          r'(\(?\d{2}\)?\s)?(\d{4,5}\-\d{4})')
                                      .hasMatch(value ?? '')) {
                                    return 'Telefone obrigatório!';
                                  }
                                },
                                controller: telefoneController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  MaskTextInputFormatter(
                                      mask: '(##) '
                                          '9-####-####'),
                                ],
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80)),
                                  label: Text('Telefone'),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3,
                                        color: Colors.lightGreenAccent),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            ////////////////////////////////
                            Form(
                              key: _dataNascimentoFormKey,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (_dataNascimentoFormKey.currentState!
                                      .validate()) {}
                                },
                                validator: (value) {
                                  if (!RegExp(r'[0-9]').hasMatch(value ?? '')) {
                                    return 'Data Nascimento obrigatório!';
                                  }
                                },
                                controller: dataNascimentoController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  MaskTextInputFormatter(
                                      mask: '##/'
                                          '##/'
                                          '####'),
                                ],
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80)),
                                  label: Text('Data Nascimento'),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3,
                                        color: Colors.lightGreenAccent),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Form(
                              key: _categoriaEsporteFormKey,
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
                              key: _nivelCategoriaFormKey,
                              child: DropdownButtonFormField<String>(
                                value: _nivelCategoriaSelecionado,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _nivelCategoriaSelecionado = newValue!;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Escolha sua categoria!';
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
                                  label: Text('Categoria'),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Estudante?',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Switch(
                                  value: validadorEstudante,
                                  onChanged: (bool value) {
                                    setState(
                                      () {
                                        validadorEstudante = value;
                                      },
                                    );
                                  },
                                  activeColor: Colors.lightGreenAccent,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      Colors.lightGreenAccent.withOpacity(0.7),
                                  fixedSize: Size(300, 40)),
                              onPressed: _salvar,
                              child: Text(
                                'Adicionar',
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
    bool nomeValido = _nomeFormKey.currentState!.validate();
    bool emailValido = _cpfFormKey.currentState!.validate();
    bool telefoneValido = _telefoneFormKey.currentState!.validate();
    bool dataNascimentoValido = _dataNascimentoFormKey.currentState!.validate();
    bool esporteValido = _categoriaEsporteFormKey.currentState!.validate();
    bool timeTorcedorValido = _nivelCategoriaFormKey.currentState!.validate();

    if (nomeValido &&
        emailValido &&
        telefoneValido &&
        dataNascimentoValido &&
        esporteValido &&
        timeTorcedorValido) {
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
                      _retornarNovaPessoa();
                    },
                    style: TextButton.styleFrom(primary: Color(0xffb2ff59)),
                    child: Text('Sim')),
              ],
            ));
  }

  _retornarNovaPessoa() {
    Atleta pessoa = Atleta(
      nome: nomeController.text,
      telefone: telefoneController.text,
      cpf: cpfController.text,
      dataNascimento: dataNascimentoController.text,
      esporte: _categoriaEsporteSelecionada,
      estudante: validadorEstudante,
      nivelCategoria: _nivelCategoriaSelecionado,
    );
    Navigator.pop(context, pessoa);
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
              if (nomeController != null &&
                  telefoneController != null &&
                  cpfController != null &&
                  dataNascimentoController != null &&
                  esporteController != null &&
                  nivelCategoriaController != null) {
                Navigator.pop(context);
                Navigator.pop(
                    context,
                    Atleta(
                        nome: nomeController.text,
                        cpf: cpfController.text,
                        estudante: validadorEstudante,
                        dataNascimento: dataNascimentoController.text,
                        esporte: esporteController.text,
                        telefone: telefoneController.text,
                        nivelCategoria: nivelCategoriaController.text));
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
