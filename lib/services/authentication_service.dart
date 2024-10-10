import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto/models/login.dart';

class AuthenticationService{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  registerUser({
    required String name, 
    required String email, 
    required String password
    }) async{
      try {
        UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

        await credential.user!.updateDisplayName(name);

      } on FirebaseAuthException catch (e){
        if (e.code == 'email-already-in-use') {
          return 'Email já cadastrado!';
        }
      }
  }

  loginUser({required String email, required String password}) async{
    try{
      return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      if (e.code == 'invalid-credential'){
        return "Email ou senha incorreto";
      }
      return "Erro de login";
    }
  }

  logoutUser(){
    return _firebaseAuth.signOut();
  }

  Future passwordReset(email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}