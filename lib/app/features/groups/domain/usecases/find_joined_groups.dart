import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/group_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class FindJoinedGroupsUseCase
    implements Usecase<Stream<List<GroupEntity>>, StringParams> {
  final GroupRepository repository;
  FindJoinedGroupsUseCase({required this.repository});

  @override
  Future<Either<Failure, Stream<List<GroupEntity>>>> call(StringParams params) {
    return repository.findJoinedGroups(params.value);
  }
}
