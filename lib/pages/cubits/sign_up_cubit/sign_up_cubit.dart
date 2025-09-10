import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpLoading());
  Future<void> signUpUser({
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SignUpSucsses());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignUpFailure(errorMessage: 'Weak password'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignUpFailure(errorMessage: 'Email already in use'));
      }
    } catch (e) {
      emit(SignUpFailure(errorMessage: e.toString()));
    }
  }
}
