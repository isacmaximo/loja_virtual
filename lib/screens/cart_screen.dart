//Tela do Carrinho

import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/screens/order_screen.dart';
import 'package:loja_virtual/tiles/cart_tile.dart';
import 'package:loja_virtual/widgets/cart_price.dart';
import 'package:loja_virtual/widgets/discount_card.dart';
import 'package:loja_virtual/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model){

                int qtdProduct = model.products.length;

                return Text(
                  //se qtdProduct for nulo ele retorna 0, caso contrário ele retorna o valor de qtdProduct
                  //se a quantidade de ítens for igual a 1 retorna ítem, se for mais, retorna ítens
                  "${qtdProduct ?? 0}  ${qtdProduct == 1 ? " ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),

      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model){

          //se estiver carregando
          if(model.isLoading && UserModel.of(context).isLoggedIn()){
            return Center(child: CircularProgressIndicator(),);
          }

          //se não estiver logado
          else if(!UserModel.of(context).isLoggedIn()){
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart, size: 80.0, color: Theme.of(context).primaryColor),

                  SizedBox(height: 16.0,),

                  Text("Faça o login para adicionar produtos!",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold, ),
                    textAlign: TextAlign.center,),

                  SizedBox(height: 16.0,),

                  ElevatedButton(
                    child: Text("Entrar", style: TextStyle(fontSize: 18.0, color: Colors.white),),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),

                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen())
                      );
                    },

                  ),

                ],
              ),
            );
          }

          //se não estiver nada no carrinho
          else if(model.products.length == null ||model.products.length == 0){
            return Center(
              child: Text("Nenhum produto no carrinho",
                style: TextStyle(
                fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
            );
          }

          //se estiver logado e tiver produtos no carrinho
          else{
            return ListView(
              children: <Widget>[
                Column(
                  children: model.products.map((product){
                    return CartTile(product);

                  }).toList(),
                ),
                DiscountCard(),
                ShipCard(),
                CartPrice(() async{
                  String orderId = await model.finishOrder();
                  if (orderId != null){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => OrderScreen(orderId))
                    );
                  }
                })
              ],
            );
          }
        },
      ),
    );
  }
}
