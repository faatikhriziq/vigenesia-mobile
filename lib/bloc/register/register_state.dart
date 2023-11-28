part of 'register_bloc.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final RegisterResponseModel model;

  RegisterSuccess({
    required this.model,
  });
}

final class RegisterError extends RegisterState {
  final String message;
  RegisterError({
    required this.message,
  });
}
