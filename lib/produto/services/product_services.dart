import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:mercadinho/produto/models/product.dart';
import 'package:mercadinho/utils/my_firebase_auth_exceptions.dart';
import 'package:mercadinho/utils/my_firebase_exceptions.dart';
import 'package:mercadinho/utils/my_platform_exceptions.dart';

class ProductServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // estanciar o storage
  final FirebaseStorage _storage = FirebaseStorage.instance;
  //..DTo instsncia da classe de dados
  Product? product;

  //--Método de save, recebe uma instrancia do produto e uma imagem
  save(Product product, dynamic image) {
    try {
      // -- manda adcionar para json
      _firestore.collection('products').add(product.toMap());
    } on FirebaseAuthException catch (e) {
      throw MyFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw MyFirebaseExceptions(e.code).message;
    } on PlatformException catch (e) {
      throw MyPlatformExceptions(e.code).message;
    } catch (e) {
      throw 'Algo está errado. Por favor, tente novamente';
    }
  }
}
