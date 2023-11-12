import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imagecaptiongenerator/core/failure/failure.dart';
import 'package:imagecaptiongenerator/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:imagecaptiongenerator/features/auth/domain/entity/user_entity.dart';
import 'package:imagecaptiongenerator/features/auth/domain/repository/auth_repository.dart';

final authRemoteRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRemoteRepository(
    ref.read(authRemoteDataSourceProvider),
  );
});

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(
      String username, String password) async {
    return await _authRemoteDataSource.loginUser(username, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(UserEntity user) {
    return _authRemoteDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, bool>> changeuser(UserEntity user, String id) {
    return _authRemoteDataSource.changeuser(user, id);
  }
}
