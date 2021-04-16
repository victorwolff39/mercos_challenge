import 'package:flutter/material.dart';
import 'package:mercos_challenge/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {


    return LayoutBuilder(builder: (ctx, constraints) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
      Container(
        alignment: Alignment.centerLeft,
        width: constraints.maxWidth * 0.20,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(product.id.toString()),
              SizedBox(
                width: 10,
              ),
              if(constraints.maxWidth >= 600)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                ),
                child: Container(
                  width: 80,
                  height: 50,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        width: constraints.maxWidth * 0.20,
        child: Text(product.name),
      ),
      Container(
        alignment: Alignment.center,
        width: constraints.maxWidth * 0.20,
        child: Text(product.multiple != null ? product.multiple.toString() : ""),
      ),
      Container(
        alignment: Alignment.centerLeft,
        width: constraints.maxWidth * 0.20,
        child: Text(product.formattedPrice()),
      )
        ],
      );
    });
  }
}
