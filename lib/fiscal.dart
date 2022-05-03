enum Sexo { Masculino, Feminino }

Sexo? strToSexo(String? str) {
  if (str == null) {
    return null;
  }
  switch (str.toUpperCase()) {
    case 'M':
    case 'MASCULINO':
      return Sexo.Masculino;
    case 'F':
    case 'FEMININO':
      return Sexo.Feminino;
    default:
      return null;
  }
}

class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  Sexo? sexo;

  Pessoa({this.nome, this.cpf, this.nascimento, this.sexo});
}

class NotaFiscal {
  int? numero;
  Pessoa? cliente;
  DateTime? emissao;
  String? enderecoEntrega;
  List<ItemNF> listItens = [];

  NotaFiscal({this.numero, this.cliente, this.emissao, this.enderecoEntrega});

  double calculoTotal() {
    return listItens.map((e) => e.calculoValorItem()).reduce((a, b) => a + b);
  }

  double totalDesconto() {
    return listItens.map((e)=> e.desconto).reduce((a, b) => a + b);
  }

  ItemNF getProdutoMaisBarato() {
    return listItens.map((e) => e).reduce((a, b) => a.calculoValorItem() < b.calculoValorItem() ? a : b);
  }

  ItemNF? getProdutoMaisCaro() {
    return listItens.map((e) => e).reduce((a, b) => a.calculoValorItem() > b.calculoValorItem() ? a : b);
  }
  bool possuiDesconto(){
    return listItens.map((e) => e).any((c) => c.desconto > 0 );
  }
  Iterable<ItemNF> itensComDesconto(){
    return listItens.map((e) => e).where((c) => c.desconto > 0);
  }
  String getStrItens(){
    return listItens.map((e) => "${e.numSeq} : ${e.produto}").join(",");
  }
  ItemNF addItem(
      {required String produto,
      required double valor,
      double desconto = 0.0,
      double acrescimo = 0.0}) {
    ItemNF item = ItemNF(
        numSeq: listItens.length + 1,
        produto: produto,
        valor: valor,
        desconto: desconto,
        acrescimo: acrescimo);
    listItens.add(item);
    return item;
  }
}

class ItemNF {
  int numSeq;
  String produto;
  double valor = 0;
  double desconto = 0;
  double acrescimo = 0;

  ItemNF(
      {required this.numSeq,
      required this.produto,
      required this.valor,
      this.desconto = 0.0,
      this.acrescimo = 0.0});

  double calculoValorItem() => valor + acrescimo - desconto;

  @override
  String toString() {
    return '{nome=$produto, valor=$valor, desconto= $desconto, acrescimo=$acrescimo numSeq=$numSeq}';
  }
}

void mainNotaFiscal() {
  final pessoa = Pessoa(
      nome: 'Luis', cpf: '111.111.111-01', nascimento: DateTime(1999, 04, 01));
  final nota = NotaFiscal(
      cliente: pessoa,
      emissao: DateTime(2022, 5, 3),
      enderecoEntrega: 'Rua 7 de setembro, centro',
      numero: 010101);

  nota.addItem(produto: 'Maçã', valor: 10, desconto: 2);
  nota.addItem(produto: 'Banana', valor: 3, acrescimo: 0.5);
  nota.addItem(produto: 'Vodka', valor: 100, desconto: 10);
  print(nota.getProdutoMaisCaro());
  print(nota.getProdutoMaisBarato());
  print(nota.totalDesconto());
  print(nota.itensComDesconto());
  print(nota.possuiDesconto());
  // print('Valor total da NF=${nota.calculoTotal()}\n Valor total de descontos = ${nota.totalDesconto()}\n O produto mais barato = ${nota.getProdutoMaisBarato()}\n O produto mais caro= ${nota.getProdutoMaisCaro()}');
}
