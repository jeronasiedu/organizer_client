import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_details_controller.dart';
import 'package:organizer_client/shared/enums/spinner.dart';
import 'package:organizer_client/shared/theme/theme.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';
import 'package:organizer_client/shared/ui/error_page.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class GroupDetailsPage extends GetView<GroupDetailsController> {
  const GroupDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.groupName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Ionicons.copy_outline),
              onPressed: () {
                controller.copyGroupId();
              },
              splashRadius: 24,
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: Spinner(),
            );
          }
          if (controller.errorOccurred.value) {
            return ErrorPage(
              callback: () {
                controller.findGroup();
              },
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.group.members.length,
                  itemBuilder: (BuildContext context, int index) {
                    final member = controller.group.members[index];
                    final isMe =
                        member.id == FirebaseAuth.instance.currentUser!.uid;
                    return ListTile(
                      title: Text(isMe ? "You" : member.fullName),
                      subtitle: Text(member.phoneNumber),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(member.profile),
                      ),
                    );
                  },
                ),
              ),
              GetBuilder(
                init: controller,
                builder: (controller) {
                  return SizedBox(
                    height: 75,
                    width: double.maxFinite,
                    child: Card(
                      child: Center(
                        child: Wrap(
                          spacing: 20,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            ...List.generate(
                              controller.group.socialLinks.length,
                              (index) {
                                final socialLink =
                                    controller.group.socialLinks[index];
                                return IconButton(
                                  onPressed: () {
                                    controller
                                        .launchSocialLink(socialLink.link);
                                  },
                                  icon: controller
                                      .socialIconToDisplay(socialLink.type),
                                  splashRadius: 24,
                                  tooltip: socialLink.type,
                                );
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                showCustomBottomSheet(
                                  height: Get.height * 0.32,
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Social Media Group Type",
                                      ),
                                      const SizedBox(height: 4),
                                      Center(
                                        child: GetBuilder(
                                          init: controller,
                                          initState: (_) {},
                                          builder: (_) {
                                            return ToggleButtons(
                                              isSelected:
                                                  controller.selectedSocial,
                                              onPressed:
                                                  controller.toggleSocial,
                                              children:
                                                  controller.socialMediaIcons,
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      Form(
                                        key: controller.formKey,
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller:
                                              controller.groupLinkController,
                                          keyboardType: TextInputType.url,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter a link";
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            hintText: "Link to group",
                                            contentPadding: inputPadding,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 14),
                                      SizedBox(
                                        width: double.maxFinite,
                                        child: Obx(() => ElevatedButton.icon(
                                              onPressed: () {
                                                controller.addSocialGroup();
                                              },
                                              icon: controller
                                                      .isAddingSocial.value
                                                  ? const Spinner(
                                                      size: SpinnerSize.sm,
                                                    )
                                                  : const Icon(Ionicons.add),
                                              label: Text(controller
                                                      .isAddingSocial.value
                                                  ? "Adding..."
                                                  : "Add"),
                                            )),
                                      )
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Ionicons.add),
                              splashRadius: 24,
                              tooltip: "New social Group",
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
