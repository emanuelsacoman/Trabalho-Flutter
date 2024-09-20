import 'package:flutter/material.dart';
import 'package:projeto/models/Login.dart';
import 'package:projeto/main.dart';
import 'package:projeto/view/telaInicial.dart';

class Telainicial extends StatefulWidget {
  const Telainicial({super.key});

  @override
  State<Telainicial> createState() => _TelainicialState();
}

class _TelainicialState extends State<Telainicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela Inicial', style: TextStyle(fontSize: 25, color: Colors.black),), backgroundColor: Color.fromARGB(255, 203, 118, 252),),
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
            accountName: Text('Emanuel', style: TextStyle(fontSize: 20),), 
            accountEmail: Text('emanuel@gmail.com'),
            ),
            FloatingActionButton(onPressed: (){
            },
            child: Icon(Icons.logout),
            )
        ],)
      ),
      body: Stack(children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 300, left: 50),
              child: Text('Bem-Vindo a Tela Inicial!', style: TextStyle(fontSize: 25))
            )
          ],
        ),
          ],),
    );
  }

  
}
