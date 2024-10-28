import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference recipes = FirebaseFirestore.instance.collection('recipes');

  String get userId => FirebaseAuth.instance.currentUser!.uid;

  Future addRecipe(String name, String ingredients, String instructions, String category) {
    return recipes.add({
      "name": name,
      "ingredients": ingredients,
      "instructions": instructions,
      "category": category,
      "userId": userId,
    });
  }

  Future<void> updateRecipe(String docId, String newName, String newIngredients, String newInstructions, String newCategory) {
    return recipes.doc(docId).update({
      "name": newName,
      "ingredients": newIngredients,
      "instructions": newInstructions,
      "category": newCategory,
    });
  }

  Future<void> deleteRecipe(String docId) {
    return recipes.doc(docId).delete();
  }

  Stream<QuerySnapshot> getRecipesStream() {
    return recipes
      .where('userId', isEqualTo: userId)
      .snapshots();
  }

  Future<DocumentSnapshot> getRecipe(String docId) {
    return recipes.doc(docId).get();
  }
}
