import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:mercos_challenge/models/debouncer.dart';
import 'package:mercos_challenge/models/order.dart';
import 'package:mercos_challenge/models/product.dart';

class ProductFormModal extends StatefulWidget {
  final Product product;

  ProductFormModal(this.product);

  @override
  _ProductFormModalState createState() => _ProductFormModalState();
}

class _ProductFormModalState extends State<ProductFormModal> {
  final _form = GlobalKey<FormState>();

  /*
   * Validar o formulário
   */
  bool validate() {
    return _form.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    /*
     * Utilizando o _debouncer para executar uma ação depois de 500ms do usuário
     * ter parado de digitar (calcular a rentabilidade)
     */
    final _debouncer = Debouncer(milliseconds: 500);

    /*
     * Configurações dos TextControllers de valor e quantidade
     */
    final _moneyMaskedTextController = MoneyMaskedTextController(
        decimalSeparator: ",",
        thousandSeparator: ".",
        initialValue: widget.product.price,
        leftSymbol: "R\$   ");
    final _textEditingController = TextEditingController()
      ..text = widget.product.multiple != null
          ? widget.product.multiple.toString()
          : "1";

    /*
     * Calcular a porcentagem de diferença entre o valor do produto e o valor inserido
     */
    double calculatePriceDifference(double itemPrice) {
      OrderItem oderItem = OrderItem(
          widget.product,
          _moneyMaskedTextController.numberValue,
          int.parse(_textEditingController.text.trim()));
      /*
       * Arredondar o double para 2 casas decimais retorna uma String, então deve
       * fazer um parse novamente.
       */
      double pctDifference = oderItem.pctDifference();
      pctDifference = double.parse(pctDifference.toStringAsFixed(2));
      return pctDifference;
    }

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
                          suffixStyle: TextStyle(color: Colors.red),
                        ),
                        onChanged: (value) {
                          _debouncer.run(() {
                            print(calculatePriceDifference(_moneyMaskedTextController.numberValue));
                          });
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
                    //validate();
                  },
                  child: Row(
                    children: [Icon(Icons.add), Text("Adicionar")],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
