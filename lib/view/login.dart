import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto/services/authentication_service.dart';
import 'package:projeto/widgets/snack_bar_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _loginController = TextEditingController();
  AuthenticationService _authenticationService = AuthenticationService();
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a 
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Login"),
      ),
      body: Column(
            children: [
              Center(
                heightFactor: 5,
                child: Text(
                  'Login',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 32,
                  color: Colors.black,
                  )
                ),
                
              ),
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório!';
                            }
                            return null;
                          },

                          onChanged: (value) {
                            print(_emailController.text);
                          },

                          decoration: InputDecoration(
                            label: Text('Email'),
                            border: OutlineInputBorder(
                              borderRadius: 
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            icon: Icon(Icons.email)

                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório!';
                            }
                            return null;
                          },

                          onChanged: (value) {
                            print(_passwordController.text);
                          },

                          decoration: InputDecoration(
                            label: Text('Senha'),
                            border: OutlineInputBorder(
                              borderRadius: 
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            icon: Icon(Icons.lock)
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: (){
                            Navigator.pushNamed(context, "/forgotPassword");
                          }, child: Text("Esqueci a senha",
                          style: TextStyle(color: Colors.blue, fontSize: 14),))
                        ],
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 180, 255, 235)),
                        ),
                        onPressed: () async{
                          if (_formKey.currentState!.validate() ?? false){
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            _authenticationService.loginUser(email: email, password: password).then((value){
                              if(value != null){
                                snackBarWidget(context: context, title: value, isError: true);
                              }
                            });
                          }
                        }, 
                        child: 
                          Text('Entrar'),
                        
                        ),
                        TextButton(onPressed: () async{
                          Navigator.pushNamed(context, '/register');
                        }, child: Text('Náo tem uma conta? Registre-se') )
                    ],
                    
                  ),
                  
                )
              )
            ]
          ),
    );
  }
}