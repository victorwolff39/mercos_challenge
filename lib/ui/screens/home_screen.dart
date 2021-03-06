import 'package:flutter/material.dart';
import 'package:mercos_challenge/models/order.dart';
import '../screens/clients_screen.dart';
import '../screens/new_order_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/products_screen.dart';
import '../widgets/drawer/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _screenIndex = 0;
  Order order;

  void selectScreen(int screen, Order order) {
    this.order = null;
    if (order != null) {
      this.order = order;
    }
    setState(() {
      _screenIndex = screen;
    });
  }

  /*
   * Função para selecionar a tela de pedidos.
   */
  void selectOrderScreen() {
    selectScreen(0, null);
  }

  @override
  Widget build(BuildContext context) {
    /*
     * Foi usado uma estratégia diferente para trocar para a tela de cadastro de pedidos.
     * Não queria usar uma stack de tela (uma tela sobre a outra) e depois dar um pop por
     * conta das dificuldades em passar funções pelos parâmetros.
     */
    List<Map> _screens = [
      {"title": "Pedidos", "screen": OrdersScreen(selectScreen)},
      {"title": "Clientes", "screen": ClientsScreen()},
      {"title": "Produtos", "screen": ProductsScreen()},
    ];

    return Scaffold(
      appBar: AppBar(
        /*
         * Colocar o botão de voltar na tela de cadastro de pedido.
         */
        leading: _screenIndex == 3
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  selectOrderScreen();
                })
            : null,
        actions: [
          /*
           * Deixar o botão de adicionar pedido visivel somente na tela de pedidos.
           */
          if (_screenIndex == 0)
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  selectScreen(3, null);
                })
        ],
        /*
         * Modificar o título da página caso seja a tela de cadastro de pedidos.
         */
        title: _screenIndex != 3
            ? Text(_screens[_screenIndex]["title"])
            : Text("Novo Pedido"),
        centerTitle: true,
      ),
      /*
       * Retirar o drawer da tela de cadastro de pedido.
       */
      drawer: _screenIndex != 3 ? MainDrawer(selectScreen) : null,
      /*
       * Override na escolha de telas para o cadastro de pedidos.
       */
      body: _screenIndex != 3
          ? _screens[_screenIndex]["screen"]
          : NewOrderScreen(selectOrderScreen: selectOrderScreen, currentOrder: order ?? null,),
    );
  }
}
