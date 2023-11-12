import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imagecaptiongenerator/core/failure/failure.dart';
import 'package:imagecaptiongenerator/features/auth/data/repository/auth_remote_repository.dart';
import 'package:imagecaptiongenerator/features/auth/domain/entity/user_entity.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return ref.read(authRemoteRepositoryProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(UserEntity user);
  Future<Either<Failure, bool>> loginUser(String username, String password);
  Future<Either<Failure, bool>> changeuser(UserEntity user, String id);
}
