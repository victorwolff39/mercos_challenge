import 'package:flutter/material.dart';

class OrderRowLabelWidget extends StatelessWidget {
  final BoxConstraints constraints;

  OrderRowLabelWidget(this.constraints);

  @override
  Widget build(BuildContext context) {

    TextStyle labelTextStyle() {
      return TextStyle(
        fontSize: 20,
        color: Theme.of(context).primaryColor,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: constraints.maxWidth * 0.30,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Produto", style: labelTextStyle())
                ),
              ),
              Container(
                width: constraints.maxWidth * 0.20,
                child: Text("Valor Unitário", style: labelTextStyle()),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: constraints.maxWidth * 0.20,
                child: Text("Qtd.", style: labelTextStyle()),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: constraints.maxWidth * 0.20,
                child: Text("Total", style: labelTextStyle()),
              ),
              //SizedBox(width: constraints.maxWidth * 0.05)
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
