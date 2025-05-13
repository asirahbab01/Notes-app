import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final isLoading = false.obs;

  Future<void> login(BuildContext context) async {
    isLoading.value = true;
    try {
      // Sign in the user
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Logged in successfully!"),
        backgroundColor: Colors.lightGreen,
      ),
      );

      // Redirect to home page using GoRouter
      GoRouter.of(context).go('/home');
    } on FirebaseAuthException catch (e) {
      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message ?? "Login failed"),
        backgroundColor: Colors.red,
      ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final fullName = nameController.text.trim();

    if (email.isEmpty || password.isEmpty || fullName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("All fields are required"),
        backgroundColor: Colors.red,
      ),
    );
      return;
    }

    isLoading.value = true;

    try {
      // Create user in Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store additional user details in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        'createdAt': DateTime.now(),
      });

      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Account created successfully!"),
        backgroundColor: Colors.lightGreen,
      ),
    );

      // Redirect to home page using GoRouter
      GoRouter.of(context).go('/home');
    } on FirebaseAuthException catch (e) {
      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message ?? "Registration failed"),
        backgroundColor: Colors.red,
      ),
    );
    } finally {
      isLoading.value = false;
    }
  }
}
