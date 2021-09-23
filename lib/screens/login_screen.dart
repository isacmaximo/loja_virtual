//Tela de Login
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {

  //chave global para acessar o formulário:
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[

          ElevatedButton(
            child: Text("CRIAR CONTA",
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,),),
            onPressed: (){

            },
          ),
        ],
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[

            TextFormField(
              decoration: InputDecoration(
                hintText: "E-mail"
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (text){
                if (text.isEmpty || !text.contains("@")){
                  return "Email Inválido";
                }
                else{
                  return null;
                }
              },
            ),

            SizedBox(height: 16.0,),

            TextFormField(
              decoration: InputDecoration(
                  hintText: "Senha"
              ),
              //como é um campo de senha, então não mostra
              obscureText: true,
              validator: (text){
                if (text.isEmpty || text.length < 6){
                  return "Senha Inválida!";
                }
                else{
                  return null;
                }
              },

            ),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: (){},
                child: Text("Esqueci minha senha", textAlign: TextAlign.right,),
              ),
            ),

            SizedBox(height: 16.0,),

            SizedBox(
              height: 44.0,
              child: ElevatedButton(
                child: Text("Entrar", style: TextStyle(
                  fontSize: 18.0,
                ),),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),

                onPressed: (){
                  if (_formKey.currentState.validate()){

                  }
                },
              ),
            ),


          ],
        ),
      ),

    );
  }
}
