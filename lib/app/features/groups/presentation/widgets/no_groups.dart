import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/routes/app_pages.dart';

class NoGroups extends StatelessWidget {
  const NoGroups({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
        child: Column(
          children: [
            Image.asset(
              'assets/empty-folder.png',
            ),
            const SizedBox(height: 10),
            Text(
              "You're not in any group yet",
              style: Get.textTheme.headline6,
            ),
            const SizedBox(height: 8),
            const Text(
              "Create a community and invite your friends or join one from the discover page",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(AppRoutes.NEW_GROUP);
              },
              icon: const Icon(Ionicons.add),
              label: const Text("New Community"),
            )
          ],
        ),
      ),
    );
  }
}
