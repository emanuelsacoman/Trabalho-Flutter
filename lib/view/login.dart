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
  AuthenticationService _authenticationService = AuthenticationService();

  bool _obscurePassword = true;

  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              ),
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
                        } else if (!emailRegex.hasMatch(value)) {
                          return 'Email inválido!';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        print(_emailController.text);
                      },
                      decoration: InputDecoration(
                        label: Text('Email'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        icon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        icon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            !_obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/forgotPassword");
                        },
                        child: Text(
                          "Esqueci a senha",
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 180, 255, 235)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate() ?? false) {
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        _authenticationService.loginUser(email: email, password: password).then((value) {
                          if (value != null) {
                            snackBarWidget(context: context, title: value, isError: true);
                          }
                        });
                      }
                    },
                    child: Text('Entrar'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text('Não tem uma conta? Registre-se'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
