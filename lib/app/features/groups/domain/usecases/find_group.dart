// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/groups/domain/entities/group_entity.dart';
import 'package:organizer_client/app/features/groups/domain/repositories/group_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class FindGroupUseCase implements Usecase<GroupEntity, StringParams> {
  final GroupRepository repository;

  FindGroupUseCase({required this.repository});

  @override
  Future<Either<Failure, GroupEntity>> call(StringParams params) {
    return repository.findGroup(params.value);
  }
}
