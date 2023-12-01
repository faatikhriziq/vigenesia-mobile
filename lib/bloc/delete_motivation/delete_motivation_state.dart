part of 'delete_motivation_bloc.dart';

@immutable
sealed class DeleteMotivationState {}

final class DeleteMotivationInitial extends DeleteMotivationState {}

final class DeleteMotivationLoading extends DeleteMotivationState {}

final class DeleteMotivationSuccess extends DeleteMotivationState {
  final DeleteResponseModel model;

  DeleteMotivationSuccess(this.model);
}

final class DeleteMotivationFailure extends DeleteMotivationState {
  final String error;

  DeleteMotivationFailure(this.error);
}
