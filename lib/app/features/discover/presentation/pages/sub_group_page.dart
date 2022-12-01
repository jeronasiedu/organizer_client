import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/sub_group_controller.dart';
import 'package:organizer_client/shared/ui/spinner.dart';

class SubGroupPage extends GetView<SubGroupController> {
  const SubGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => controller.isLoading.value
            ? const SizedBox.shrink()
            : Text(controller.subGroupEntity.name)),
        actions: [
          Obx(
            () => controller.isLoading.value
                ? const SizedBox.shrink()
                : controller.subGroupEntity.isMember
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {},
                          splashRadius: 24,
                        ),
                      )
                    : const SizedBox.shrink(),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: Spinner(),
                )
              : controller.subGroupEntity.members.isEmpty
                  ? const Center(
                      child: Text(
                        "Be the first person to join this group",
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final member = controller.subGroupEntity.members[index];
                        return ListTile(
                          title: Text(member.name),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(member.profile),
                          ),
                          subtitle: Text(member.phoneNumber),
                          onTap: () {},
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const Divider(height: 0),
                      itemCount: controller.subGroupEntity.members.length,
                    ),
        ),
      ),
      // floatingActionButton: ,
      // only show the floating action button if the user is not a member of the sub group
      floatingActionButton: Obx(
        () => controller.isLoading.value
            ? const SizedBox.shrink()
            : controller.subGroupEntity.isMember
                ? const SizedBox.shrink()
                : FloatingActionButton.extended(
                    onPressed: () {
                      controller.joinGroupWrapper();
                    },
                    label: Text("Join ${controller.subGroupEntity.name}"),
                  ),
      ),
    );
  }
}
