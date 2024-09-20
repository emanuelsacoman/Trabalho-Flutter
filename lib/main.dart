import 'package:flutter/material.dart';
import 'package:projeto/models/Login.dart';
import 'package:projeto/view/telaInicial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      routes: {
        '/telaInicial': (context) => Telainicial(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  final Login? login;
  const MyHomePage({super.key, this.login});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                            )
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
                            )
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 180, 255, 235)),
                        ),
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            String email = _emailController.text;
                            String password = _passwordController.text;

                            
                              Navigator.pushNamed(context, '/telaInicial');

                            
                          }
                        }, 
                        child: 
                          Text('Entrar'),
                        
                        )
                    ],
                    
                  ),
                  
                )
              )
            ]
          ),
    );
  }
}
