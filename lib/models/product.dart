import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Product {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  int multiple;

  Product({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.price,
    this.multiple,
  });

  bool verifyMultiple(int quantity) {
    /*
     * Validar se existe algum multiplo.
     * Caso nada seja informado, não existe restrição.
     */
    if(multiple != null && multiple != 1 && multiple != 0) {
      /*
       * Se a quantidade de produtos, dividido pelo multiplo for um número inteiro,
       * quer dizer que passou no teste.
       */
      num value = quantity / this.multiple;
      return value is int || value == value.roundToDouble();
    } else {
      return true;
    }
  }

  String formattedPrice() {
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'pt_BR');
    return formatCurrency.format(this.price).toString();
  }
}

// TODO: Arrumar o preço do DL-44