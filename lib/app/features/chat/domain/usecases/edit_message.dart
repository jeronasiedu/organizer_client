import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/features/chat/domain/entities/message.dart';
import 'package:organizer_client/app/features/chat/domain/repositories/chat_repository.dart';
import 'package:organizer_client/shared/error/failure.dart';
import 'package:organizer_client/shared/usecase/usecase.dart';

class EditMessageUseCase implements Usecase<Unit, MessageEntity> {
  final ChatRepository repository;
  EditMessageUseCase({required this.repository});

  @override
  Future<Either<Failure, Unit>> call(MessageEntity params) {
    return repository.editMessage(params);
  }
}
