import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wrestling_news/services/authentication_service.dart';

part 'authentication_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  Future<void> signInAnon() async {
    try {
      emit(
        AuthLoading(state.mainAuthState),
      );
      AuthService authService = AuthService();
      bool isUserSignedIn = await authService.checkIfSignedIn();

      if (isUserSignedIn) {
        emit(
          AuthLoaded(state.mainAuthState),
        );
      } else {
        UserCredential user = await authService.signInAnonymously();
        emit(
          AuthLoaded(state.mainAuthState.copyWith(
            user: user,
          )),
        );
      }
    } catch (e) {
      emit(AuthError(state.mainAuthState, 'Authentication error: $e'));
    }
  }
}
