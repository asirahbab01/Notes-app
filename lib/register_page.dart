import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register"),backgroundColor: Colors.lightGreen,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: controller.nameController,
            decoration: const InputDecoration(labelText: "Full Name"),
          ),
          TextField(
            controller: controller.emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          TextField(
            controller: controller.passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: "Password"),
          ),
          const SizedBox(height: 20),
          Obx(() => controller.isLoading.value
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () => controller.register(context),
                  child: const Text("Submit"),
                )),
        ]),
      ),
    );
  }
}
