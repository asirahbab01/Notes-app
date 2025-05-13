import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/auth_controller.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome to Notes App"),backgroundColor: Colors.lightGreen,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
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
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.login(context),
                    child: const Text("Login"),
                  ),
                  ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => GoRouter.of(context).go('/register'),
                    child: const Text("Register"),
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
