import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/order.dart';
import '../../providers/orders_provider.dart';
import '../widgets/order/order_widget.dart';

class OrdersScreen extends StatefulWidget {
  final Function(int, Order) selectScreen;

  OrdersScreen(this.selectScreen);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrdersProvider>(context, listen: false)
        .loadOrders()
        .then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  /*
   * Função para atualizar a tela de pedidos.
   */
  Future<void> _refreshProducts(BuildContext context) {
    setState(() {
      _isLoading = true;
    });
    return Provider.of<OrdersProvider>(context, listen: false)
        .loadOrders()
        .then((value) => {
              setState(() {
                _isLoading = false;
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final orders = ordersProvider.items;

    /*
     * deleteOrder e editOrder estão dentro do build para pegar o BuildContext.
     */
    void deleteOrder(Order order) {
      ordersProvider.deleteOrder(order).then((value) => {
        _refreshProducts(context)
      });
      Fluttertoast.showToast(msg: "Pedido removido.");
    }

    void editOrder(Order order) {
      widget.selectScreen(3, order);
    }

    return RefreshIndicator(
      onRefresh: () => _refreshProducts(context),
      child: _isLoading
          ? LinearProgressIndicator()
          : orders.length > 0
              ? ListView.builder(
                  itemCount: ordersProvider.itemsCount(),
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      OrderWidget(
                        order: orders[index],
                        editOrder: editOrder,
                        deleteOrder: deleteOrder,
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Nenhum pedido cadastrado",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(height: 20),
                      FittedBox(
                        child: ElevatedButton(
                          onPressed: () async {
                            widget.selectScreen(3, null);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text("Adicionar pedido")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
