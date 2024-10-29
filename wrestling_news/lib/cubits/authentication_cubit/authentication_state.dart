part of 'authentication_cubit.dart';

class MainAuthState extends Equatable {
  final UserCredential? user;

  const MainAuthState({
    this.user,
  });

  MainAuthState copyWith({
    UserCredential? user,
  }) {
    return MainAuthState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        user,
      ];
}

abstract class AuthState extends Equatable {
  final MainAuthState mainAuthState;

  const AuthState(this.mainAuthState);

  @override
  List<Object?> get props => [mainAuthState];
}

class AuthInitial extends AuthState {
  const AuthInitial() : super(const MainAuthState());
}

class AuthLoading extends AuthState {
  const AuthLoading(MainAuthState mainAuthState) : super(mainAuthState);
}

class AuthLoaded extends AuthState {
  const AuthLoaded(MainAuthState mainAuthState) : super(mainAuthState);
}

class AuthError extends AuthState {
  final String error;

  const AuthError(MainAuthState mainAuthState, this.error)
      : super(mainAuthState);
}
