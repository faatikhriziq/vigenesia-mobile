part of 'motivation_bloc.dart';

@immutable
sealed class MotivationState {}

final class MotivationInitial extends MotivationState {}

final class MotivationLoading extends MotivationState {}

final class MotivationGetLoading extends MotivationState {}

final class MotivationSuccess extends MotivationState {
  final MotivationResponseModel motivation;

  MotivationSuccess(this.motivation);
}

final class MotivationSuccessGetMotivation extends MotivationState {
  final GetMotivationResponseModel motivation;

  MotivationSuccessGetMotivation(this.motivation);
}

final class MotivationError extends MotivationState {
  final String message;

  MotivationError(this.message);
}

final class MotivationGetError extends MotivationState {
  final String message;

  MotivationGetError(this.message);
}
