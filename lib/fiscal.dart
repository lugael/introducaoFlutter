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
  List<ItemNF> itens = [];

  NotaFiscal({this.numero, this.cliente, this.emissao, this.enderecoEntrega});

  double calculoTotal() {
    double total = 0.0;
    for (int i = 0; i < itens.length; i++) {
      total += itens[i].calculoValorItem();
    }
    return total;
  }

  double totalDesconto() {
    double descTotal = 0.0;
    for (ItemNF item in itens) {
      descTotal += item.desconto;
    }
    return descTotal;
  }

  ItemNF? getProdutoMaisBarato() {
    ItemNF? itemMaisBarato;
    for (ItemNF item in itens) {
      if (itemMaisBarato == null) {
        itemMaisBarato = item;
      } else if (item.calculoValorItem() < itemMaisBarato.calculoValorItem()) {
        itemMaisBarato = item;
      }
    }
    return itemMaisBarato;
  }

  ItemNF? getProdutoMaisCaro() {
    ItemNF? itemMaisCaro;
    for (ItemNF item in itens) {
      if (itemMaisCaro == null) {
        itemMaisCaro = item;
      } else if (item.calculoValorItem() > itemMaisCaro.calculoValorItem()) {
        itemMaisCaro = item;
      }
    }
    return itemMaisCaro;
  }

  ItemNF addItem(
      {required String produto,
      required double valor,
      double desconto = 0.0,
      double acrescimo = 0.0}) {
    ItemNF item = ItemNF(
        numSeq: itens.length + 1,
        produto: produto,
        valor: valor,
        desconto: desconto,
        acrescimo: acrescimo);
    itens.add(item);
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
  print(
      'Valor total da NF=${nota.calculoTotal()}\n Valor total de descontos = ${nota.totalDesconto()}\n O produto mais barato = ${nota.getProdutoMaisBarato()}\n O produto mais caro= ${nota.getProdutoMaisCaro()}');
}
