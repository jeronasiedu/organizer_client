// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class DiscoverController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final groupCodeController = TextEditingController();
  final FindGroupUseCase findGroupUseCase;
  DiscoverController({
    required this.findGroupUseCase,
  });

  void findGroup() async {
    final results =
        await findGroupUseCase.call(StringParams(groupCodeController.text));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
    }, (group) {
      bool isMember = false;
      String subGroupId = '';
      outerLoop:
      for (var subGroup in group.subGroups) {
        subGroupId = subGroup.id;
        for (var member in subGroup.members) {
          if (member.id == FirebaseAuth.instance.currentUser!.uid) {
            isMember = true;
            break outerLoop;
          }
        }
      }

      if (isMember) {
        Get.toNamed('/sub_group/$subGroupId?groupId=${group.id}');
      } else {
        Get.toNamed('/join_group/${group.id}');
      }
    });
  }
}
