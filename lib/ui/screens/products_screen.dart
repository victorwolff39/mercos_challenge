import 'package:flutter/material.dart';
import 'package:mercos_challenge/providers/products_provider.dart';
import 'package:mercos_challenge/ui/widgets/products/product_item.dart';
import 'package:provider/provider.dart';

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
    bool allowSelection = false;
    //Pega os args enviados usando o pushNamed
    final bool arguments = ModalRoute.of(context).settings.arguments as bool;
    if(arguments != null) {
      allowSelection = arguments;
    }

    /*
     * Pega a lista de produtos do provider.
     */
    final productsProvider = Provider.of<ProductsProvider>(context);
    final products = productsProvider.items;

    return _isLoading
        ? LinearProgressIndicator()
        : Padding(
            padding: const EdgeInsets.only(top: 8),
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
                    enableSelection: allowSelection,
                    selectProduct: null,
                  ),
                  Divider(),
                ],
              ),
            ),
          );
  }
}
