import 'package:flutter/material.dart';

class ProductRowLabelWidget extends StatelessWidget {
  final BoxConstraints constraints;

  ProductRowLabelWidget(this.constraints);

  @override
  Widget build(BuildContext context) {

    TextStyle labelTextStyle() {
      return TextStyle(
        fontSize: 20,
        color: Theme.of(context).primaryColor,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: constraints.maxWidth * 0.20,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("ID", style: labelTextStyle())
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: constraints.maxWidth * 0.20,
          child: Text("Nome", style: labelTextStyle()),
        ),
        Container(
          alignment: Alignment.center,
          width: constraints.maxWidth * 0.20,
          child:
          Text("Unidade de embarque", style: labelTextStyle()),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: constraints.maxWidth * 0.20,
          child: Text("Valor", style: labelTextStyle()),
        )
      ],
    );
  }
}
