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
  final _nameController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _categoryController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.black), 
        ),
        backgroundColor: Colors.green, 
      ),
    );
  }

  void _openModalForm(context, {String? docId}) async {
    if (docId != null) {
      DocumentSnapshot document = await firestoreService.getRecipe(docId);
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      _nameController.text = data['name'];
      _ingredientsController.text = data['ingredients'];
      _instructionsController.text = data['instructions'];
      _categoryController.text = data['category'];
    }

    showModalBottomSheet(
        backgroundColor: Color.fromARGB(255, 99, 131, 151),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Criar nova receita',
                  style: TextStyle(fontSize: 17),
                ),
                Divider(color: Colors.white),
                SizedBox(height: 10),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: 'Nome',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.text_fields_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _ingredientsController,
                  maxLines: 4, // Aumentando o número de linhas
                  decoration: InputDecoration(
                      labelText: 'Ingredientes',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.list),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _instructionsController,
                  maxLines: 4, // Aumentando o número de linhas
                  decoration: InputDecoration(
                      labelText: 'Instruções',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                      labelText: 'Categoria',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.category),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (docId == null) {
                      firestoreService.addRecipe(
                        _nameController.text,
                        _ingredientsController.text,
                        _instructionsController.text,
                        _categoryController.text,
                      );
                      _showSnackBar('Receita inserida com sucesso!');
                    } else {
                      firestoreService.updateRecipe(
                        docId,
                        _nameController.text,
                        _ingredientsController.text,
                        _instructionsController.text,
                        _categoryController.text,
                      );
                      _showSnackBar('Receita editada com sucesso!');
                    }
                    _nameController.clear();
                    _ingredientsController.clear();
                    _instructionsController.clear();
                    _categoryController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Salvar'),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de Receitas'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
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
              onTap: () {
                AuthenticationService().logoutUser();
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _nameController.clear();
          _ingredientsController.clear();
          _instructionsController.clear();
          _categoryController.clear();
          _openModalForm(context);
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getRecipesStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List recipeList = snapshot.data!.docs;

              return ListView.builder(
                itemCount: recipeList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = recipeList[index];
                  String docId = document.id;
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String name = data["name"];
                  String ingredients = data["ingredients"];
                  String instructions = data["instructions"];
                  String category = data["category"];

                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: ListTile(
                      tileColor: Color.fromARGB(90, 171, 171, 171),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: Text(name),
                      subtitle: Text('Categoria: $category'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              _openModalForm(context, docId: docId);
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              firestoreService.deleteRecipe(docId);
                              _showSnackBar('Receita excluída com sucesso!');
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
