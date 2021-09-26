//Widget Cartão de Desconto

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class DiscountCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text("Cupom de Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),),
        //ícone que vai ficar na esquerda
        leading: Icon(Icons.card_giftcard),
        //ícone que vai ficar na direita
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            //campo (input) do cartão de desconto
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom"
              ),
              //caso o cupom já tenha sido aplicado seu código vai aparecer, se não mostrará um texto vazio
              initialValue: CartModel.of(context).couponCode ?? "",
              //quando digitar o cupom e selecionar concluído/ok/símbolo do check, então vai aplicar este cupom
              onFieldSubmitted: (text){
                Firestore.instance.collection("coupons").document(text).get().then((docSnap){
                  //se o cupom existe:
                  if(docSnap.data != null){
                    CartModel.of(context).setCoupon(text, docSnap.data["percent"]);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Desconto de ${docSnap.data["percent"]}% aplicado!"),
                      backgroundColor: Theme.of(context).primaryColor,
                      duration: Duration(seconds: 2),
                    ));
                  }
                  //se o cupom não existe:
                  else{
                    CartModel.of(context).setCoupon(null, 0);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Cupom não existente!"),
                      backgroundColor: Colors.redAccent,
                      duration: Duration(seconds: 2),
                    ));
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
