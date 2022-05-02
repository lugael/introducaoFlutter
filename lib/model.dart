enum Sexo {MASCULINO, FEMININO}
class Pessoa{
  String? nome ;
  String? cpf;
  DateTime? nascimento;
  int? idade;
  Sexo? sexo;
  double? salario;
  bool? programador;
  @override
  String toString() {
   return "Nome = $nome, cpf= $cpf, nascimento= $nascimento, idade= $idade"
       "sexo= $sexo, salario= $salario, programador= $programador";
  }

}
void mainEntidade(){
  Pessoa pessoa = Pessoa();
  pessoa.nome = "Luis";
  pessoa.cpf = "417.784.147-78";
  pessoa.nascimento = DateTime(1999,04,16);
  pessoa.idade = 23;
  pessoa.sexo = Sexo.MASCULINO;
  pessoa.salario = 4500;
  pessoa.programador =  true;
  print(pessoa.toString());

}