import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/forget_password_repo.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  String? email;
  String? code;

  Future<void> sendCode(String email) async {
    final trimmedEmail = email.trim();
    this.email = trimmedEmail;
    emit(ForgetPasswordLoading());
    final error = await ForgetPasswordRepo.sendResetPasswordCode(email: trimmedEmail);
    if (error == null) {
      emit(CodeSentSuccess());
    } else {
      emit(ForgetPasswordError(error));
    }
  }

  Future<void> verifyCode(String code) async {
    if (email == null) {
      emit(const ForgetPasswordError("Email is missing"));
      return;
    }
    this.code = code;
    emit(ForgetPasswordLoading());
    final error = await ForgetPasswordRepo.confirmCode(
      email: email!,
      code: code,
    );
    if (error == null) {
      emit(CodeVerifiedSuccess());
    } else {
      emit(ForgetPasswordError(error));
    }
  }

  void setCode(String code) {
    this.code = code;
  }

  Future<void> resetPassword({
    required String newPassword,
  }) async {
    if (email == null || code == null) {
      emit(const ForgetPasswordError("Email or code is missing"));
      return;
    }

    emit(ForgetPasswordLoading());
    final error = await ForgetPasswordRepo.resetPassword(
      email: email!,
      code: code!,
      newPassword: newPassword,
    );

    if (error == null) {
      emit(PasswordResetSuccess());
    } else {
      emit(ForgetPasswordError(error));
    }
  }
}
