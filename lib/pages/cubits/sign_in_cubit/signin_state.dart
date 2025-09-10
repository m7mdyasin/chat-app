part of 'signin_cubit.dart';

@immutable
abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninSucsses extends SigninState {}

class SigninLoading extends SigninState {}

class SigninFailure extends SigninState {
  String errorMessage;
  SigninFailure({required this.errorMessage});
}
