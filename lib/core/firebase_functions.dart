import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/task_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:evently/providers/home_tab_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class FirebaseFunctions {
  static CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection('Users')
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) {
            return UserModel.fromJson(snapshot.data()!);
          },
          toFirestore: (value, _) {
            return value.toJson();
          },
        );
  }

  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection('Tasks')
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) {
            return TaskModel.fromJson(snapshot.data()!);
          },
          toFirestore: (value, _) {
            return value.toJson();
          },
        );
  }

  static Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  static Future<void> saveUser(UserModel user) {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  static Future<void> signOut(BuildContext context) async {
    context.read<HomeTabProvider>().dispose();
    await FirebaseAuth.instance.signOut();
  }

  static Future<UserModel?>? readUser() async {
    var collection = getUsersCollection();
    var data = await collection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return data.data();
  }

  static Future<void> createTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> updateTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc(task.id);
    return docRef.update(task.toJson());
  }

  static Future<void> deleteTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc(task.id);
    return docRef.delete();
  }

  static Stream<QuerySnapshot<TaskModel>> getFavoriteTasks() {
    var data = getTasksCollection()
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("isFavorite", isEqualTo: true)
        .snapshots();
    return data;
  }

  static Stream<QuerySnapshot<TaskModel>> getTasksStream({String? category}) {
    var data;
    if (category != null) {
      data = getTasksCollection()
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("category", isEqualTo: category)
          .snapshots();
    } else {
      data = getTasksCollection()
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots();
    }
    return data;
  }

  static Future<void> signInWithGoogle({
    required Function onSuccess,
    required Function onError,
  }) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential,);
    final firebaseUser = userCredential.user;
    final existingUser = await getUsersCollection().doc(firebaseUser?.uid).get();
    if (firebaseUser == null) {
      onError("Google login failed");
      return;
    }
    if (!existingUser.exists) {
      await saveUser(
        UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? "",
          name: firebaseUser.displayName ?? "Google User",
        ),
      );
    }
    onSuccess();
  }

  static Future<void> login(
    String email,
    String password, {
    required Function onSuccess,
    required Function onError,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user!.emailVerified) {
        onSuccess();
      } else {
        onError("Email not verified");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        onError('Wrong password provided for that user.');
      } else {
        onError(e.code);
      }
    }
  }

  static Future<void> createUser(
    String email,
    String password,
    String name, {
    required Function onSuccess,
    required Function onError,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      saveUser(
        UserModel(
          email: email,
          name: name,
          id: FirebaseAuth.instance.currentUser!.uid,
        ),
      );
      onSuccess();
      await credential.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError('The account already exists for that email.');
      }
    } catch (e) {
      onError(e.toString());
    }
  }
}
