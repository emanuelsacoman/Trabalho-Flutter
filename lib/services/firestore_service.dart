import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService{
  final CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

  String get userId => FirebaseAuth.instance.currentUser!.uid;

  Future addTask(String title, String description){
      return tasks.add({
        "title": title,
        "description": description,
        "userId": userId,
    });
  }

  Future<void> updateTask(String docId, String newTitle, String newDescription){
    return tasks.doc(docId).update({
      "title": newTitle,
      "description": newDescription,
    });
  }

  Future<void> deleteTask(String docId){
    return tasks.doc(docId).delete();
  }

  Stream<QuerySnapshot> getTasksStream(){
    return tasks
      .where('userId', isEqualTo: userId)
      .snapshots();
  }

  Future<DocumentSnapshot> getTask(String docId){
    return tasks.doc(docId).get();
  }
}