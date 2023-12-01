part of 'delete_motivation_bloc.dart';

@immutable
sealed class DeleteMotivationEvent {}

final class DeleteMotivation extends DeleteMotivationEvent {
  final int id;

  DeleteMotivation(this.id);
}
