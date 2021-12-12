import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tecnoflix/model/resource.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

Future<Resource> auth(String email, String password) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    await preferences.setString('email', email);
    return Resource(true, "");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return Resource(false, "Nenhum usuário encontrado com este email");
    } else if (e.code == 'wrong-password') {
      return Resource(false, "Senha incorreta");
    }
  }
  return Resource(false, "Erro desconhecido");
}

Future<Resource> registration(String email, String password) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await preferences.setString('email', email);
    return Resource(true, "");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return Resource(false, "A senha fornecida é muito curta");
    } else if (e.code == 'email-already-in-use') {
      return Resource(false, "Este email já está em uso");
    }
  }
  return Resource(false, "Erro desconhecido");
}
