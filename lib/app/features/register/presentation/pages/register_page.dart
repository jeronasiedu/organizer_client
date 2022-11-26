import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/register/presentation/controllers/register_controller.dart';
import 'package:organizer_client/app/routes/app_pages.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/illustration.webp'),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: const Text(
                "Group organizer is here to help you with all your class groupings. You're just a button away from exploring everything Organizer got to offer ",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: () {
                Get.offNamed(AppRoutes.HOME);
              },
              icon: const Icon(Ionicons.logo_google),
              label: const Text("Continue with Google"),
            )
          ],
        ),
      ),
    );
  }
}
