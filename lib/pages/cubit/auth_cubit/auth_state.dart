part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


final class RegisterCubitInitial extends AuthState {}

final class RegisterCubitSuccess extends AuthState {}

final class RegisterCubitLoading extends AuthState {}

final class RegisterCubitFailure extends AuthState {
  final String message;
  RegisterCubitFailure(this.message);
}




final class LoginInitial extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginFailure extends AuthState {
  final String message;
  LoginFailure(this.message);
}
