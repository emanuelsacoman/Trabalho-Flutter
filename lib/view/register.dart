import 'package:flutter/material.dart';
import 'package:projeto/services/authentication_service.dart';
import 'package:projeto/widgets/snack_bar_widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a 
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Registre-se"),
      ),
      body: Column(
            children: [
              Center(
                heightFactor: 5,
                child: Text(
                  'Registre-se',
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
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório!';
                            }
                            return null;
                          },

                          onChanged: (value) {
                            print(_nameController.text);
                          },

                          decoration: InputDecoration(
                            label: Text('Nome'),
                            border: OutlineInputBorder(
                              borderRadius: 
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            icon: Icon(Icons.lock)
                          ),
                        ),
                      ),
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
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 180, 255, 235)),
                        ),
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            String name = _nameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;

                            _authService.registerUser(
                              name: name, email: email, password: password
                            ).then((value){
                              if(value != null){
                                snackBarWidget(context: context, title: value, isError: true);
                              }else {
                                snackBarWidget(context: context, title: "Cadastro efetuado com sucesso!", isError: false);
                                Navigator.pop(context);
                              }

                            });

                              Navigator.pushNamed(context, '/telaInicial');
                          }
                        }, 
                        child: 
                          Text('Entrar'),
                        
                        ),
                    ],
                    
                  ),
                  
                )
              )
            ]
          ),
    );
  }
}