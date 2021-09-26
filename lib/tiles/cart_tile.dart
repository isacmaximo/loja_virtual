
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/models/cart_model.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {

    //_buildContent() = mostar dados
    Widget _buildContent(){
      //atualizar os valores
      CartModel.of(context).updatePrices();
      return Row(
        children: <Widget>[
          //imagem do produto
          Container(
            padding: EdgeInsets.all(8.0),
            width: 120.0,
            child: Image.network(cartProduct.productData.images[0]),
          ),

          //as demais informações
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Text(
                    cartProduct.productData.title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                  ),

                  Text("Tamanho: ${cartProduct.size}",
                  style: TextStyle(fontWeight: FontWeight.w300),
                  ),

                  Text("R\$ ${cartProduct.productData.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),

                  //adicionar a quantidade de ítens
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      IconButton(
                        icon: Icon(Icons.remove),
                        //se a quantidade for maior que um então o botão fica habilitado
                        onPressed: cartProduct.quantity  > 1 ?
                        (){
                         CartModel.of(context).decProduct(cartProduct);
                        } : null,
                      ),

                      Text(cartProduct.quantity.toString()),

                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: (){
                          CartModel.of(context).incProduct(cartProduct);
                        },
                      ),

                      TextButton(
                        child: Text("Remover",),
                        style: TextButton.styleFrom(primary: Colors.grey[500]),
                        onPressed: (){
                          //remove o ítem
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                      )

                    ],
                  )

                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
      //se fechar o aplicativo, ou precisar recuperar o que tem no carrinho do usuário,
      //então pegamos o que tem no carrinho no Firestore e recuperamos essas informações

      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cartProduct.productData == null ?
      FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection("products").document(cartProduct.category).
        collection("items").document(cartProduct.pid).get(),

        builder: (context, snapshot){
          if(snapshot.hasData){
            cartProduct.productData = ProductData.fromDocument(snapshot.data);
            return _buildContent();
          }
          else{
            return Container(
              height: 70.0,
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            );
          }
        },
      ) : _buildContent(),
    );
  }
}
