import 'package:bery_beat/features/auth/cubit/auth_state.dart';
import 'package:bery_beat/features/auth/data/repo/auth%20_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  signIn({required String email, required String password}) async {
    emit(AuthLoadingState());
    final error = await AuthRepo.signIn(email: email, password: password);
    if (error == null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(error));
    }
  }

  signUp({
    required String fullName,
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required String country,
    required String phoneNumber,
  }) async {
    emit(AuthLoadingState());
    final error = await AuthRepo.signUp(
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
