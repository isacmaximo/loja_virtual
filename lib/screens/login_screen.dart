//Tela de Login
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/singup_screen.dart';
import 'package:scoped_model/scoped_model.dart';


class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //controladores:
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  //chave global para acessar o formulário:
  final _formKey = GlobalKey<FormState>();

  //chave global para o scaffold
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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

        //Colocando o Form dentro de ScopedModelDescendant, criamos uma forma de acessar o modelo (login do usuário)
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){

            //se o modelo estiver carregando, então retorna um widget circular (carregando)
            if (model.isLoading){
              return Center(child: CircularProgressIndicator(),);
            }

            else {
              return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[

                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: "E-mail"
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty || !text.contains("@")) {
                          return "Email Inválido";
                        }
                        else {
                          return null;
                        }
                      },
                    ),

                    SizedBox(height: 16.0,),

                    TextFormField(
                      controller: _passController,
                      decoration: InputDecoration(
                          hintText: "Senha"
                      ),
                      //como é um campo de senha, então não mostra
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6) {
                          return "Senha Inválida!";
                        }
                        else {
                          return null;
                        }
                      },

                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          //se o campo de email  está vazio
                          if (_emailController.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Insira seu e-mail para recuperação!"),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 2),
                            ));
                          }
                          else{
                            model.recoverPass(_emailController.text);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Confira seu e-mail!"),
                              backgroundColor: Theme.of(context).primaryColor,
                              duration: Duration(seconds: 2),
                            ));
                          }

                        },
                        child: Text("Esqueci minha senha",
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Theme
                              .of(context)
                              .primaryColor),),
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
                            backgroundColor: MaterialStateProperty.all(Theme
                                .of(context)
                                .primaryColor)),

                        onPressed: () {
                          if (_formKey.currentState.validate()) {

                          }

                          model.singIn(
                              email: _emailController.text,
                              pass: _passController.text,
                              onSuccess: _onSuccess,
                              onFail: _onFail
                          );
                        },

                      ),
                    ),
                  ],
                ),
              );
            }

          },
        )

    );
  }

  void _onSuccess(){
    Navigator.of(context).pop();
  }

  void _onFail(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Falha ao Entrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

}


