// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key? key,
    this.message,
    required this.callback,
  }) : super(key: key);
  final String? message;
  final VoidCallback callback;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/error.png',
            width: 100,
          ),
          const SizedBox(height: 20),
          Text(
            message ?? "Oops, something went wrong",
            style: Get.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          const Text("Please try again"),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: callback,
            icon: const Icon(Ionicons.reload),
            label: const Text("Try Again"),
          )
        ],
      ),
    );
  }
}