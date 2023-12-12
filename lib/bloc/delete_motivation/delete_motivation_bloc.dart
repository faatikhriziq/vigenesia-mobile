import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vigenesia/data/datasource/remote/motivation_datasource.dart';

import '../../data/model/response/delete_respnose_model.dart';

part 'delete_motivation_event.dart';
part 'delete_motivation_state.dart';

class DeleteMotivationBloc extends Bloc<DeleteMotivationEvent, DeleteMotivationState> {
  final MotivationDatasource _motivationDatasource;
  DeleteMotivationBloc(this._motivationDatasource) : super(DeleteMotivationInitial()) {
    on<DeleteMotivation>((event, emit) async {
      emit(DeleteMotivationLoading());
      await _motivationDatasource.deleteMotivation(event.id).then((value) {
        value.fold(
          (l) => emit(DeleteMotivationFailure(l)),
          (r) => emit(DeleteMotivationSuccess(r)),
        );
      });
    });
  }
}
