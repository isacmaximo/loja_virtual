//Cartão de Frete (Ainda não disponibilizado)

import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text("Calcular Frete",
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),),
        //ícone que vai ficar na esquerda
        leading: Icon(Icons.location_on),
        //ícone que vai ficar na direita
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            //campo (input) do cartão de desconto
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite seu CEP"
              ),
              initialValue: "",
              onFieldSubmitted: (text){

              }

              ),
            ),
        ],
      ),
    );
  }
}
