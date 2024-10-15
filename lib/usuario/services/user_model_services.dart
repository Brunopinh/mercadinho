import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mercadinho/usuario/models/user_model.dart';

class UserModelServices {
  // obtendo a instancia do firabase de autenticação
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  UserModel? userModel;

  signUp(UserModel user, dynamic image, bool plataform) async {
    User? users = (await _auth.createUserWithEmailAndPassword(
            email: user.email!, password: user.password!))
        .user;
    user.id = users!.uid;
    userModel = user;
  }
  saveDatails() async{
    await _firestore.collection('users').add(userModel!.toMap());
  }
}
