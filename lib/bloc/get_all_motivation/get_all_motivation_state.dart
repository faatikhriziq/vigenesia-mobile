part of 'get_all_motivation_bloc.dart';

@immutable
sealed class GetAllMotivationState {}

final class GetAllMotivationInitial extends GetAllMotivationState {}

final class GetAllMotivationLoading extends GetAllMotivationState {}

final class GetAllMotivationSuccess extends GetAllMotivationState {
  final GetMotivationResponseModel motivation;

  GetAllMotivationSuccess(this.motivation);
}

final class GetAllMotivationError extends GetAllMotivationState {
  final String message;

  GetAllMotivationError(this.message);
}
