// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/community/domain/entities/community_entity.dart';
import 'package:organizer_client/app/features/community/domain/repositories/community_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class FindCommunityUseCase implements Usecase<CommunityEntity, StringParams> {
  final CommunityRepository repository;
  FindCommunityUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, CommunityEntity>> call(StringParams params) {
    return repository.findCommunity(params.value);
  }
}
