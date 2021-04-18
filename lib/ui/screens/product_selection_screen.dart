import 'package:flutter/material.dart';
import 'package:mercos_challenge/models/order.dart';
import 'package:mercos_challenge/models/product.dart';
import 'package:mercos_challenge/providers/products_provider.dart';
import 'package:mercos_challenge/ui/widgets/products/product_form_modal.dart';
import 'package:mercos_challenge/ui/widgets/products/product_item.dart';
import 'package:provider/provider.dart';

class ProductSelectionScreen extends StatefulWidget {
  @override
  _ProductSelectionScreenState createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
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

  /*
   * Form modal para colocar o valor e quantidade do produto a ser inserido.
   */
  _openProductFormModal(BuildContext context, Product product) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return ProductFormModal(product);
        }).then((value) {
      if (value != null) {
        OrderItem orderItem = value;
        Navigator.of(context).pop(orderItem);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
     * Pega a lista de produtos do provider.
     */
    final productsProvider = Provider.of<ProductsProvider>(context);
    final products = productsProvider.items;

    /*
     * Função que é executada ao clicar no produto.
     * Está dentro do build para ter acesso ao context.
     */
    void selectProduct(Product product) {
      _openProductFormModal(context, product);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionar produto"),
        centerTitle: true,
      ),
      body: _isLoading
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
                      enableSelection: true,
                      selectProduct: selectProduct,
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
    );
  }
}
