
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

class OrderTile extends StatelessWidget {

  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        //como é em tempo real:
        child: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance.collection("orders")
                .document(orderId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(),);
              }

              else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text("Código do Pedido: ${snapshot.data.documentID}",
                        style: TextStyle(fontWeight: FontWeight.bold)),

                    SizedBox(height: 4.0,),

                    Text(_buildProductsText(snapshot.data)),

                  ],
                );
              }
            }
        ),
      ),
    );
  }
    String _buildProductsText(DocumentSnapshot snapshot){
      String text = "Descrição:\n";
      //para cada um dos produtos do pedido
      for(LinkedHashMap p in snapshot.data["products"]){
        text += "${p["quantity"]} x ${p["product"]["title"]} (R\$ ${p["product"]["price"].toStringAsFixed(2)})\n";
      }
      text += "Total: R\$ ${snapshot.data["totalPrice"].toStringAsFixed(2)}\n";
       return text;
    }
}
