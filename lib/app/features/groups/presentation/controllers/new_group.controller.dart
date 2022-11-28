import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:organizer_client/shared/ui/custom_bottomsheet.dart';

class NewGroupController extends GetxController {
  /// The first value holds the group method and the second value
  /// holds the people method
  List<bool> selectedGroupingMethod = [false, true];
  void changeSelectedGroup(int index) {
    for (var i = 0; i < selectedGroupingMethod.length; i++) {
      selectedGroupingMethod[i] = i == index;
    }
    update();
  }

  final formKey = GlobalKey<FormState>();
  final groupCodeController = TextEditingController();
  final groupNameController = TextEditingController();
  final totalPeopleController = TextEditingController();
  final peoplePerGroupController = TextEditingController();
  final numberOfGroupsController = TextEditingController();

  void computeGroupData() {
    final totalPeopleInput = int.parse(totalPeopleController.text);
    late final int resultingPeoplePerGroup;
    late final int resultingPeopleWithoutGroup;
    late final int resultingTotalGroups;

    /// Check if the selected grouping method is [group]
    if (selectedGroupingMethod[0]) {
      final numberOfGroupsInput = int.parse(numberOfGroupsController.text);
      resultingTotalGroups = numberOfGroupsInput;

      /// get the exact even number of people that can form a group
      resultingPeoplePerGroup = totalPeopleInput ~/ numberOfGroupsInput;

      /// Get the number of people that will be shared across groups
      resultingPeopleWithoutGroup =
          totalPeopleInput.remainder(numberOfGroupsInput);
    } else {
      final peoplePerGroupInput = int.parse(peoplePerGroupController.text);
      resultingPeoplePerGroup = peoplePerGroupInput;

      /// Get the number of groups that can be form without remainder
      resultingTotalGroups = totalPeopleInput ~/ peoplePerGroupInput;

      /// Get the number of people that will be shared across groups
      resultingPeopleWithoutGroup =
          totalPeopleInput.remainder(peoplePerGroupInput);
    }
    print(
        "There are going to be $resultingTotalGroups groups, each group will have $resultingPeoplePerGroup members with $resultingPeopleWithoutGroup groups having an extra member. That's ${resultingPeoplePerGroup + 1}");

    showCustomBottomSheet(
        child: Column(
      children: [
        RichText(
          text: TextSpan(
            style: Get.textTheme.bodyText1,
            text: "There will be ",
            children: [
              TextSpan(
                text: "$resultingTotalGroups",
                style: TextStyle(
                  color: Get.theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }

  /// Ask user if he wants to discard the form
  Future<bool?> willPop() async {
    return Get.dialog<bool>(
      AlertDialog(
        title: const Text("Are you sure you want to quit?"),
        titleTextStyle: Get.textTheme.headline6!.copyWith(
          fontSize: 17,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        icon: const Icon(Ionicons.warning_outline),
        iconColor: Get.theme.colorScheme.error,
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(
              foregroundColor: Get.theme.colorScheme.error,
            ),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}
