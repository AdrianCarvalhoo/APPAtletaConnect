class Atleta {
  String nome;
  String cpf;
  String telefone;
  String dataNascimento;
  String esporte;
  String nivelCategoria;
  bool estudante;
  Atleta? parceiroDupla;

  Atleta({
    required this.nome,
    required this.cpf,
    required this.telefone,
    required this.dataNascimento,
    required this.esporte,
    required this.nivelCategoria,
    required this.estudante,
    this.parceiroDupla,
  });
}
