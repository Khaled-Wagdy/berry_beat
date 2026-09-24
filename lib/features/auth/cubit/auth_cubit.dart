import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoadingState());
    final error = await _authRepo.signIn(email: email, password: password);
    if (error == null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(error));
    }
  }

  Future<void> signUp({
    required String fullName,
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required String country,
    required String phoneNumber,
  }) async {
    emit(AuthLoadingState());
    final error = await _authRepo.signUp(
      fullName: fullName,
      userName: userName,
      email: email,
      country: country,
      phoneNumber: phoneNumber,
      password: password,
      confirmPassword: confirmPassword,
    );
    if (error == null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(error));
    }
  }
}
