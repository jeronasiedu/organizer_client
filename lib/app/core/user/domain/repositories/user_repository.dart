import 'package:dartz/dartz.dart';
import 'package:organizer_client/app/core/user/domain/entities/user.dart';
import 'package:organizer_client/shared/error/failure.dart';

abstract class UserRepository {
  /// Sign user in with google repository
  Future<Either<Failure, void>> signInWithGoogle();

  /// Register user by taking in additional user details
  Future<Either<Failure, void>> register(AppUser appUser);

  /// Retrieve authenticated user from local db
  Future<Either<Failure, AppUser>> authenticatedUser();

  /// Sign user out of the app
  Future<Either<Failure, void>> signOut();
}
