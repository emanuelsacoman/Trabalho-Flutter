import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto/services/authentication_service.dart';
import 'package:projeto/services/firestore_service.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

  void _openModalForm(context, { String? docId}) async{ 

    if(docId != null){
      DocumentSnapshot document = await firestoreService.getTask(docId);
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      _titleController.text = data['title'];
      _descriptionController.text = data['description'];
    }

    showModalBottomSheet(

      backgroundColor: Color.fromARGB(255, 99, 131, 151),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context, 
      builder: (BuildContext context){
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
            .viewInsets
            .bottom,
            left: 16,
            right: 16,
            top: 16,  
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Criar novo post', style: TextStyle(fontSize: 17),
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                fillColor: Colors.white,
                focusColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.text_fields_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                fillColor: Colors.white,
                focusColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.text_fields_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if(docId == null){
                  firestoreService.addTask(
                  _titleController.text, _descriptionController.text);
                }else {
                  firestoreService.updateTask(docId, _titleController.text, _descriptionController.text);
                }                
                  _titleController.clear();
                  _descriptionController.clear();
                  Navigator.pop(context);
              },
              child: Text('Salvar'),
            )
          ],
        ),);
      });
      
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela Inicial'),
      ),
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.user.displayName != null
            ? widget.user.displayName!
            : "Não informado!"),
            accountEmail: Text(widget.user.email != null
            ? widget.user.email!
            : "Não informado!"),          
          ),
          ListTile(
            title: Text('Sair'),
            leading: Icon(Icons.logout),
            onTap: (){
              AuthenticationService().logoutUser();
            },
          )
        ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _titleController.clear();
          _descriptionController.clear();
          _openModalForm(context);
        },
        child: Icon(Icons.add),

      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getTasksStream(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            List taskList = snapshot.data!.docs;

            return ListView.builder(itemCount: taskList.length, itemBuilder: (context, index) {
               
              DocumentSnapshot document = taskList[index];
              String docId = document.id;
                Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
                String title = data["title"];
                String description = data["description"];

                return Padding(
                  padding: EdgeInsets.all(16),
                  child: 
                  ListTile(
                    tileColor: Color.fromARGB(90, 171, 171, 171),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    title: Text(title),
                    subtitle: Text(description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: (){
                            _openModalForm(context, docId: docId);
                          }, icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: (){
                            firestoreService.deleteTask(docId);
                          }, icon: Icon(Icons.delete)),
                      ]
                    ),
                  ));
            },
            );
          } else {
            return Container();
          }
        }
      ),
    );
  }
}