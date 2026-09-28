class Aluno {
  final String? id;
  final String nome;
  final String telefone;
  final int aulasPorSemana;

  Aluno({
    this.id,
    required this.nome,
    required this.telefone,
    required this.aulasPorSemana,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'telefone': telefone,
      'aulas_por_semana': aulasPorSemana,
    };
  }

  factory Aluno.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return Aluno(
      id: id,
      nome: map['nome'] as String,
      telefone: map['telefone'] as String,
      aulasPorSemana: map['aulas_por_semana'] as int,
    );
  }
}