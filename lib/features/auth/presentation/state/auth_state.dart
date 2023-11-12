import 'package:imagecaptiongenerator/features/auth/domain/entity/user_entity.dart';

class AuthState {
  List<UserEntity>? users;
  final bool isLoading;
  final String? error;

  AuthState({
    required this.isLoading,
    this.error,
    this.users,
  });

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      users: [],
    );
  }

  AuthState copyWith({
    bool? isLoading,
    String? error,
    List<UserEntity>? users,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      users: users,
    );
  }

  @override
  String toString() => 'AuthState(isLoading: $isLoading, error: $error)';
}
