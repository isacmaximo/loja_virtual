//Produtos (Catergoria)

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      //pegando os dados do firebase
      future: Firestore.instance.collection("products").getDocuments(),
      builder: (context,snapshot){
        //se não tiver dados, então aparece a animação de carregamento:
        if (!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);

        }
        //se tiver algum dado é retornado a lista
        else{

          //pega o documento e transforma em uma lista
          //e cada ítem desse tem uma divisão
          var dividedTiles = ListTile.divideTiles(
            tiles: snapshot.data.documents.map((doc){
                  return CategoryTile(doc);
                }).toList(),
            color: Colors.grey[500]).toList();

          return ListView(
            children: dividedTiles,
          );
        }
      },
    );
  }
}
