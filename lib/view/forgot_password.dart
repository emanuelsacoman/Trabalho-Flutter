import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto/services/authentication_service.dart';
import 'package:projeto/services/text_form_field_wdiget.dart';
import 'package:projeto/widgets/snack_bar_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController = TextEditingController();
  AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Text(
          textAlign: TextAlign.center,
          "Esqueceu a senha? Digite seu email para enviarmos um link para redefinir.",
          style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 10),
        Padding(padding: EdgeInsets.symmetric(horizontal: 25),
          child: TextFormField(
            controller: _emailController,
            decoration: decoration("Email"),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => requiredValidator(value, "o email"),
          ),
        ),
        SizedBox(height: 10),
        MaterialButton(
          onPressed: (){
            _authService.passwordReset(_emailController.text).then((erro) {
              if(erro != null){
                snackBarWidget(context: context, title: erro, isError: true);
              }else{
                snackBarWidget(context: context, title: "Link enviado com sucesso!", isError: false);
              }
            });
          },
          child: Text("Resetar senha"),
          color: Colors.deepPurple,
          textColor: Colors.white,
          )
      ],),
    );
  }
}