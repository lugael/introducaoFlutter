enum Sexo {MASCULINO, FEMININO}
class Pessoa{
  String? nome ;
  String? cpf;
  DateTime? nascimento;
  int? idade;
  Sexo? sexo;

  int? getIdade(){
    if(nascimento == null){
      return null;
    }
    final hoje = DateTime.now();
    final idade = hoje.difference(nascimento!);
    return idade.inDays ~/365;
  }
  @override
  String toString() {
   return "Nome = $nome, cpf= $cpf, nascimento= $nascimento, idade= ${getIdade()}"
       "sexo= $sexo";
  }

}

class Programador extends Pessoa{
  double? salario;
  String toString() {
    return "Nome = $nome, cpf= $cpf, nascimento= $nascimento, idade= ${getIdade()}, "
        "sexo= $sexo";
  }
}
void mainEntidade(){
  Programador pessoa = Programador();
  pessoa.nome = "Luis";
  pessoa.cpf = "417.784.147-78";
  pessoa.nascimento = DateTime(1999,04,16);
  pessoa.sexo = Sexo.MASCULINO;
  pessoa.salario = 4500;
  // pessoa.programador =  true;
  print(pessoa.toString());

}