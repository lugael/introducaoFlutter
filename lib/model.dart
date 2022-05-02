enum Sexo {MASCULINO, FEMININO}

Sexo? strToSexo(String? str){
  if(str == null){
    return null;
  }
  switch(str.toUpperCase()){
    case'M':
    case'Masculino':
      return Sexo.MASCULINO;
    case 'F':
    case'Feminino':
      return Sexo.FEMININO;
    default:
      return null;
  }
}

class Pessoa{
  String? nome ;
  String? cpf;
  DateTime? nascimento;
  int? idade;
  Sexo? sexo;
  Pessoa(this.nome, this.cpf, this.nascimento, this.sexo);

  Pessoa.fromMap(Map<String, String> map){
    nome = map['nome'];
    cpf = map['cpf'];
    nascimento = DateTime.tryParse(map['nascimento']?? '2000-01-01');
    idade = int.parse(map['idade'] ?? "0");
    sexo = strToSexo(map['sexo']);
  }
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

  Programador(String? nome, String? cpf, DateTime? nascimento, Sexo? sexo, this.salario) :super(nome, cpf, nascimento, sexo);

  Programador.fromMap(Map<String, String> map) : super.fromMap(map){
    salario = double.tryParse(map['salario'] ?? "0.0");
  }

  @override
  String toString() {
    return "Nome = $nome, cpf= $cpf, nascimento= $nascimento, idade= ${getIdade()}, "
        "sexo= $sexo";
  }
}
void mainEntidade(){
final map = {
  'nome':'Luis',
  'nascimento' : '1999-04-16',
  'cpf' : '111.444.777-89',
  'sexo':'m',
  'salario':'11000.00'
};
Pessoa pessoa = Programador.fromMap(map);
print(pessoa.toString());
}