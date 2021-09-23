//Configuração das vizualizações dos produtos (Grade ou Lista)

import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/screens/product_screen.dart';


//O ProductData contém todos os campos sobre o produto
class ProductTile extends StatelessWidget {

  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    //o InkWell diferentemente do Gesture Detector, tem uma animação melhor ao tocar no widget
    return InkWell(

      //ao clicar
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProductScreen(product))
        );
      },

      child: Card(

        //se o tipo for grade então retorna uma coluna , se não retorna uma linha
        //stretch quer dizer que vai ficar esticado (imagens no caso)
        //altura / largura = aspect ratio
        child: type == "grid" ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            //Pegando a primeira imagem para exibir:
            AspectRatio(
              aspectRatio: 0.8,
              child: Image.network(product.images[0], fit: BoxFit.cover,),
            ),

            //Título e Preço:
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(product.title, style: TextStyle(fontWeight: FontWeight.w500),),
                    Text("R\$ ${product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],

        ) : Row(
          children: <Widget>[

            //imagem:
            Flexible(
              flex: 1,
              child: Image.network(product.images[0], fit: BoxFit.cover,),
            ),

            //texto:
            Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(product.title, style: TextStyle(fontWeight: FontWeight.w500),),
                    Text("R\$ ${product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
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
