//Home Tab (Inicial)

import 'package:flutter/material.dart';

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
           )

         ],
        )

      ],
    );
  }
}
