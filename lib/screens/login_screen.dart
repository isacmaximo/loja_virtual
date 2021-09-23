//Tela de Login
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/singup_screen.dart';

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
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
            onPressed: (){
              //podemos usar o pushReplacement, para quando clicar subistituir pela tela pela Criar Conta
              //pois ao criar a conta o usuário já vai estar autenticado
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SingUpScreen())
              );
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
              child: TextButton(
                onPressed: (){
                },
                child: Text("Esqueci minha senha",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Theme.of(context).primaryColor),),
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
