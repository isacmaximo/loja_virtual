//Home Tab (Inicial)


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //essa seta quer dizer : retorna
    //essa função vai servir para fazer o fundo:
    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
        //gradinte para fazer o degradê no fundo:
        gradient: LinearGradient(
          //passamos a lista de cores para fazer o degradê
          colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 181, 168),
          ],
          //aqui vai indicar onde começa e onde termina o degradê:
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
    );

    //utilizaremos o stack, pois queremos colocar o conteúdo acima do fundo
    return Stack(
      children: <Widget>[

        //fundo da home tab
        _buildBodyBack(),

        //menu que permite a alternância entre páginas
        //características: flutuante, aparece ou desaparece conforme vai rolando a página
        CustomScrollView(
         slivers: <Widget>[
           SliverAppBar(
             floating: true,
             snap: true,
             backgroundColor: Colors.transparent,
             elevation: 0.0,
             flexibleSpace: FlexibleSpaceBar(
               title: const Text("Novidades"),
               centerTitle: true,

             ),
           ),

           //future builder pois as imagens não são adiquiridas de forma instantânea
           FutureBuilder<QuerySnapshot>(
             future: Firestore.instance.collection("home").orderBy("pos").getDocuments(),
             builder: (context, snapshot){

               //se não tiver dados:
               if(!snapshot.hasData) {
                 //aqui colocaremos o widget circular de progresso, entretanto não podemos
                 //colocar diretamente, temos colocar dentro de um widget do tipo sliver
                 return SliverToBoxAdapter(
                   child: Container(
                     height: 200.0,
                     alignment: Alignment.center,
                     child: CircularProgressIndicator(
                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                     ),
                   ),
                 );
               }

               //se tiver dados(as imagens no caso)
               else{
                 //grade de imagens
                 //colocamos count pois sabemos a quntidade exata de ítens que vamos colocar
                return SliverStaggeredGrid.count(
                  //quntidade de ítens na horizontal, espaçamento entre as imagens (horizontal e vertical)
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  //lista de dimensões de cada imagem
                  //vamos pegar esses dados (imagem) e mapea-los
                  staggeredTiles: snapshot.data.documents.map(
                      (doc){
                        //pegando o x e o y
                        return StaggeredTile.count(doc.data["x"], doc.data["y"]);
                      }
                  ).toList(),

                  children: snapshot.data.documents.map(
                      (doc){
                        //retornando a imagem com fade de carregamento
                        return FadeInImage.memoryNetwork(
                          //imagem de subistituição, caminho no firebase, cobrir o espaço das imagens
                            placeholder: kTransparentImage,
                            image: doc.data["image"],
                            fit: BoxFit.cover,
                        );
                      }
                  ).toList(),

                );
               }
             },
           ),

         ],
        )

      ],
    );
  }
}
