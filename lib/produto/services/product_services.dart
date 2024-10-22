Future<void> initializeApp() async {
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  log('Initialized Default APP $app');
}import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mercadinho/product/models/product.dart';
import 'package:mercadinho/utils/exceptions/my_firebase_auth_exceptions.dart';
import 'package:mercadinho/utils/exceptions/my_firebase_exceptions.dart';
import 'package:mercadinho/utils/exceptions/my_platform_exceptions.dart';
import 'package:uuid/uuid.dart';

class ProductServices {
  //-- instanciar o firebase (database)
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //-- instanciar o Storage (medias)
  final FirebaseStorage _storage = FirebaseStorage.instance;
  //-- DTO
  Product? product;

  //-- save method
  save(Product product, dynamic image, bool platform) {
    try {
      _firestore.collection('products').add(product.toMap());
      this.product = product;
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

  _uploadImage(dynamic image, bool platform) async {
    //gerando id para armazenar a image no FireStore
    final uuid = Uuid().v4();
    //criando referência para o produto
    Reference storageRef = _storage.ref().child('products').child(product!.id!);
    //gerenciador de tarefas para upload da imagens
    UploadTask task;
    //upload da imagem web ou mobile
    if (!platform) {
      //enviando imagem de celular
      //vinculando a imagem com o uuid para identificação
      task = storageRef.child(uuid).putFile(image);
    } else {
      //enviando imagem da web
      task = storageRef.child(uuid).putData(image);
    }
    //fazendo o upload da image
    String url = await (await task.whenComplete(() {
      debugPrint('Upload realizado com sucesso');
    })).ref.getDownloadURL();
    product!.image = url;
    await _firestore.collection('products').doc(product!.id).set(product!.toMap());
  }
}
