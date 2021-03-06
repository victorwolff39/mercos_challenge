import 'package:flutter/material.dart';
import 'package:mercos_challenge/ui/widgets/products/product_row_label_widget.dart';
import 'package:provider/provider.dart';
import '../../providers/products_provider.dart';
import '../widgets/products/product_item.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  /*
   * A tela inicia com um indicador de loading, quando termina de pegar
   * os produtos ele é retirado.
   */
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductsProvider>(context, listen: false)
        .loadProducts()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
     * Pega a lista de produtos do provider.
     */
    final productsProvider = Provider.of<ProductsProvider>(context);
    final products = productsProvider.items;

    return _isLoading
        ? LinearProgressIndicator()
        : LayoutBuilder(builder: (ctx, constraints) {
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  ProductRowLabelWidget(constraints),
                  Divider(),
                  Container(
                    height: constraints.maxHeight * 0.83,
                    child: ListView.builder(
                      itemCount: productsProvider.itemsCount(),
                      itemBuilder: (ctx, index) => Column(
                        children: [
                          ProductItem(
                            product: products[index],
                            /*
                           * Caso a tela esteja somente no modo de visualização, não envio
                           * a função e o enableSelection como false.
                           *
                           * Para acessar os parms do Widget state, se usa
                           * this.widget.allowSelection.
                           */
                            enableSelection: false,
                            selectProduct: null,
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
  }
}
