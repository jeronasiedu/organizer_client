import 'package:get/get.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/join_group.dart';
import 'package:organizer_client/app/features/groups/presentation/controllers/group_details_controller.dart';

class GroupDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoinGroupUseCase>(
        () => JoinGroupUseCase(repository: Get.find()));
    Get.lazyPut<GroupDetailsController>(
      () => GroupDetailsController(findGroupUseCase: Get.find()),
    );
  }
}