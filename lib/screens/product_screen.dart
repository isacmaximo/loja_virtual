//Tela do Produto em sí

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  //acessando o product dentro do state:
  final ProductData product;

  String sizeProduct;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[

          //imagens do produto com o plugin Carousel
          //aqui vai pegar cada url e transformar em uma NetworkImage, se não retornaria apenas as urls
          AspectRatio(aspectRatio: 0.9, child: Carousel(
            images: product.images.map((url){
              return NetworkImage(url);
            }).toList(),
            //botão em baixo das imagens (...)
            dotSize: 4.0,
            //espaçamento entre os pontos:
            dotSpacing: 15.0,
            //fundo dos dots:
            dotBgColor: Colors.transparent,
            //cor do dot:
            dotColor: Theme.of(context).primaryColor,
            //passagem das imagens:
            autoplay: false,
          ),),

          //textos e outras informações:
          //maxLines = ocupação máxima de linhas
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Text(product.title,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500), maxLines: 3,),

                Text("R\S ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),),

                SizedBox(height: 16.0,),

                Text("Tamanho",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),),

                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    //definindo a rolagem para ser na horizontal:
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      //espaçamento apenas na horizontal, pois não haverá ítem em cima de outro
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),

                      //lista de tamanhos:
                    children: product.sizes.map((sizes){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            sizeProduct = sizes;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            border: Border.all(
                              //se tiver clicado no tamanho ele fica com  a cor primária,
                              //se não então ele fica cinza
                              color: sizes == sizeProduct ? Theme.of(context).primaryColor :
                                Colors.grey[500], width: 3.0),),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(sizes),
                        ),
                      );
                    }).toList(),

                  ),
                ),

                SizedBox(height: 16.0,),

                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    //ao selecionar um tamanho ele muda de estado
                    onPressed:
                      sizeProduct != null ? (){}: null,

                    child: Text("Adicionar ao Carrinho",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
                    ),
                  ),
                ),

                SizedBox(height: 16.0,),

                Text("Descrição:",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),),

                Text(product.description,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),)

              ],
            ),
          )
        ],
      ),
    );
  }
}
