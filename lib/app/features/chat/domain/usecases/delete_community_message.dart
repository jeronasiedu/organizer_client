import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/chat/domain/entities/community_message.dart';
import 'package:organizer_client/app/features/chat/domain/repositories/community_chat_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class DeleteCommunityMessageUseCase
    implements Usecase<Unit, CommunityMessageEntity> {
  final CommunityChatRepository repository;
  DeleteCommunityMessageUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(CommunityMessageEntity params) {
    return repository.deleteCommunityMessage(params);
  }
}
