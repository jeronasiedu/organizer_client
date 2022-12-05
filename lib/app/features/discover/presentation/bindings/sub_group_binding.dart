import 'package:get/get.dart';
import 'package:organizer_client/app/core/user/data/repositories/user_repository_impl.dart';
import 'package:organizer_client/app/core/user/domain/usecases/authenticated_user.dart';
import 'package:organizer_client/app/features/community/data/database/community_remote_database.dart';
import 'package:organizer_client/app/features/community/data/repositories/community_repository_impl.dart';
import 'package:organizer_client/app/features/community/domain/repositories/community_repository.dart';
import 'package:organizer_client/app/features/community/domain/usecases/find_community.dart';
import 'package:organizer_client/app/features/community/domain/usecases/find_sub_group.dart';
import 'package:organizer_client/app/features/community/domain/usecases/join_group.dart';
import 'package:organizer_client/app/features/discover/presentation/controllers/sub_group_controller.dart';
import 'package:organizer_client/shared/network/network.dart';

class SubGroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommunityRemoteDatabase>(() => CommunityRemoteDatabaseImpl());
    Get.lazyPut<GroupsRepository>(
      () => GroupsRepositoryImpl(
        networkInfo: Get.find<NetworkInfoImpl>(),
        remoteDatabase: Get.find<CommunityRemoteDatabase>(),
      ),
    );
    Get.lazyPut<FindSubGroupUseCase>(
        () => FindSubGroupUseCase(repository: Get.find<GroupsRepository>()));
    Get.lazyPut<FindGroupUseCase>(
        () => FindGroupUseCase(repository: Get.find<GroupsRepository>()));
    Get.lazyPut<JoinGroupUseCase>(
        () => JoinGroupUseCase(repository: Get.find<GroupsRepository>()));
    Get.put(
      AuthenticatedUserUseCase(userRepository: Get.find<UserRepositoryImpl>()),
    );
    Get.lazyPut<SubGroupController>(
      () => SubGroupController(
        findSubGroupUseCase: Get.find<FindSubGroupUseCase>(),
        findGroupUseCase: Get.find<FindGroupUseCase>(),
        joinGroupUseCase: Get.find<JoinGroupUseCase>(),
        authenticatedUserUseCase: Get.find<AuthenticatedUserUseCase>(),
      ),
    );
  }
}
