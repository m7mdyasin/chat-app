import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit() : super(SigninInitial());
  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    emit(SigninLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(SigninSucsses());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SigninFailure(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(SigninFailure(errorMessage: 'Wrong password for that user.'));
      }
    } catch (e) {
      emit(
        SigninFailure(
          errorMessage: 'An unexpected error occurred. Please try again later.',
        ),
      );
    }
  }
}
