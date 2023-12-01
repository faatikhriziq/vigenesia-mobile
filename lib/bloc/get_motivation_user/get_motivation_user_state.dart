part of 'get_motivation_user_bloc.dart';

@immutable
sealed class GetMotivationUserState {}

final class GetMotivationUserInitial extends GetMotivationUserState {}

final class GetMotivationUserLoading extends GetMotivationUserState {}

final class GetMotivationUserSuccess extends GetMotivationUserState {
  final GetMotivationUserResponseModel motivation;

  GetMotivationUserSuccess(this.motivation);
}

final class GetMotivationUserError extends GetMotivationUserState {
  final String message;

  GetMotivationUserError(this.message);
}
