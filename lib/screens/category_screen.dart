//Tela dos produtos

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data["title"]),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              //ícones de vizualização em lista ou em grade
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list))
            ],
          ),
        ),

        //DocumentSnapshot: Utilizamos quando queremos a "fotografia" de apenas um documento
        //QuerySnapshot: Utilizamos quando queremos obter uma "fotografia" de uma coleção
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("products").document(snapshot.documentID).collection("items").getDocuments(),
          builder: (context, snapshot){

            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }

            else{
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  //grade:
                  GridView.builder(
                    padding: EdgeInsets.all(4.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //quantidade de ítens na coluna, espaço na vertical e na horizontal, aspect ratio
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.65,
                      ),
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index){
                        return ProductTile("grid", ProductData.fromDocument(snapshot.data.documents[index]));
                      }
                  ),
                  //lista:
                  ListView.builder(
                    padding: EdgeInsets.all(4.0),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return ProductTile("list", ProductData.fromDocument(snapshot.data.documents[index]));
                    }
                  ),

                ],
              );
            }

          },
        )
      ),
    );
  }
}
