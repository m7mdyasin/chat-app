part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpSucsses extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpFailure extends SignUpState {
  String errorMessage;
  SignUpFailure({required this.errorMessage});
}
