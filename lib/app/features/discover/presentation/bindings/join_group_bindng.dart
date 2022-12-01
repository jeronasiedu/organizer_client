import 'package:get/get.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/join_group_controller.dart';
import 'package:organizer_client/app/features/groups/data/database/groups_remote_database.dart';
import 'package:organizer_client/app/features/groups/data/repositories/groups_repository_impl.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/groups_repository.dart';
import 'package:organizer_client/app/features/groups/domain/usecases/find_group.dart';
import 'package:organizer_client/shared/network/network.dart';

class JoinGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupsRemoteDatabase>(() => GroupsRemoteDatabaseImpl());
    Get.lazyPut<GroupsRepository>(
      () => GroupsRepositoryImpl(
        networkInfo: Get.find<NetworkInfoImpl>(),
        remoteDatabase: Get.find<GroupsRemoteDatabase>(),
      ),
    );
    Get.lazyPut<FindGroupUseCase>(
        () => FindGroupUseCase(repository: Get.find<GroupsRepository>()));
    Get.lazyPut<JoinGroupController>(
      () => JoinGroupController(
        findGroupUseCase: Get.find(),
      ),
    );
  }
}