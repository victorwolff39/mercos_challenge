import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mercos_challenge/models/debouncer.dart';
import 'package:mercos_challenge/models/product.dart';
import 'package:mercos_challenge/models/order.dart';

class ProductFormModal extends StatefulWidget {
  final Product product;

  ProductFormModal(this.product);

  @override
  _ProductFormModalState createState() => _ProductFormModalState();
}

class _ProductFormModalState extends State<ProductFormModal> {
  final _form = GlobalKey<FormState>();
  MoneyMaskedTextController _moneyMaskedTextController;
  TextEditingController _textEditingController;

  /*
   * Validar o formulário
   */
  bool validate() {
    return _form.currentState.validate();
  }

  @override
  void initState() {
    super.initState();
    /*
     * Configurações dos TextControllers de valor e quantidade
     */
    _moneyMaskedTextController = MoneyMaskedTextController(
        decimalSeparator: ",",
        thousandSeparator: ".",
        initialValue: widget.product.price,
        leftSymbol: "R\$   ");
    _textEditingController = TextEditingController()
      ..text = widget.product.multiple != null
          ? widget.product.multiple.toString()
          : "1";
  }

  /*
   * Calcular a rentabilidade usando a porcentagem de diferença entre o
   * valor do produto e o valor inserido.
   * Variáveis suffixText e suffixColor variam de acordo com a rentabilidade.
   */
  String suffixText = "Rentabilidade boa. 0.0%";
  Color suffixColor = Colors.green;
  double calculateRentability(double itemPrice) {
    OrderItem oderItem = OrderItem(
        product: widget.product,
        price: _moneyMaskedTextController.numberValue,
        quantity: int.parse(_textEditingController.text.trim()));
    /*
     * Arredondar o double para 2 casas decimais retorna uma String, então deve
     * fazer um parse novamente.
     */
    double pctDifference = oderItem.pctDifference();
    pctDifference = double.parse(pctDifference.toStringAsFixed(2));

    setState(() {
      if (pctDifference > 0) {
        suffixText = "Rentabilidade ótima. ${pctDifference.toString()}%";
        suffixColor = Colors.green;
      } else if (pctDifference <= 0 && pctDifference > -10) {
        suffixText = "Rentabilidade boa. ${pctDifference.toString()}%";
        suffixColor = Colors.green;
      } else {
        suffixText = "Rentabilidade ruim. ${pctDifference.toString()}%";
        suffixColor = Colors.red;
      }
    });
    return pctDifference;
  }

  @override
  Widget build(BuildContext context) {
    /*
     * Utilizando o _debouncer para executar uma ação depois de 500ms do usuário
     * ter parado de digitar (calcular a rentabilidade)
     */
    final _debouncer = Debouncer(milliseconds: 500);

    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book,
                      size: 32, color: Theme.of(context).accentColor),
                  SizedBox(width: 10),
                  Text(
                    widget.product.name,
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 20),
                  )
                ],
              ),
              SizedBox(height: 32),
              Form(
                key: _form,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: _moneyMaskedTextController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        cursorColor: Theme.of(context).accentColor,
                        decoration: InputDecoration(
                          labelText: "Valor",
                          helperText:
                              "Valor original: ${widget.product.formattedPrice()}",
                          border: const OutlineInputBorder(),
                          suffixText: suffixText,
                          suffixStyle: TextStyle(color: suffixColor),
                        ),
                        onChanged: (value) {
                          _debouncer.run(() {
                            calculateRentability(_moneyMaskedTextController.numberValue);
                          });
                        },
                        validator: (value) {
                          double rentability = calculateRentability(_moneyMaskedTextController.numberValue);
                          if (rentability < -10) {
                            return "Rentabilidade muito baixa";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: _textEditingController,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        cursorColor: Theme.of(context).accentColor,
                        decoration: InputDecoration(
                          helperText: widget.product.multiple != null
                              ? "Unidade mínima de embarque: ${widget.product.multiple.toString()}"
                              : null,
                          labelText: "Quantidade",
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          validate();
                        },
                        validator: (value) {
                          if (value.trim().isEmpty ||
                              (double.parse(value.trim()) <= 0)) {
                            return "Quantidade deve ser maior que zero";
                          }
                          if (!widget.product
                              .verifyMultiple(int.parse(value.trim()))) {
                            return "A unidade mínima de embarque deste produto é ${widget.product.multiple.toString()}";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              FittedBox(
                child: ElevatedButton(
                  onPressed: () {
                    if(validate()) {
                      OrderItem orderItem = OrderItem(
                        price: _moneyMaskedTextController.numberValue,
                        product: widget.product,
                        quantity: int.parse(_textEditingController.text)
                      );
                      /*
                       * Faz um pop para fechar o form modal e retornando o orderItem.
                       */
                      Navigator.of(context).pop(orderItem);
                    }
                  },
                  child: Row(
                    children: [Icon(Icons.add), Text("Adicionar")],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
