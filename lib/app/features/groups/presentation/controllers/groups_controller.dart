import 'package:get/state_manager.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_joined_groups.dart';
import 'package:organizer_client/shared/ui/error_snackbar.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class GroupsController extends GetxController {
  RxBool isEmpty = true.obs;
  RxBool isLoading = false.obs;
  RxBool errorOccurred = false.obs;
  final FindJoinedGroupsUseCase findJoinedGroupUseCase;
  final AuthenticatedUserUseCase authenticatedUserUseCase;
  late List<GroupEntity> groups;
  GroupsController({
    required this.findJoinedGroupUseCase,
    required this.authenticatedUserUseCase,
  });

  @override
  void onInit() {
    findJoinedGroupsWrapper();
    super.onInit();
  }

  Future<void> findJoinedGroupsWrapper() async {
    isLoading.value = true;
    final results = await authenticatedUserUseCase.call(NoParams());
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
    }, (user) {
      findJoinedGroups(user);
    });
  }

  Future<void> findJoinedGroups(AppUser user) async {
    final results = await findJoinedGroupUseCase.call(StringParams(user.id));
    results.fold((failure) {
      showErrorSnackbar(message: failure.message);
      errorOccurred.value = true;
      isLoading.value = false;
    }, (groups) {
      this.groups = groups;
      isEmpty.value = groups.isEmpty;
      isLoading.value = false;
    });
  }
}
