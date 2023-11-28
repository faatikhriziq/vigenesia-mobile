import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vigenesia/data/datasource/remote/motivation_datasource.dart';
import 'package:vigenesia/data/model/request/motivation_request_model.dart';

import '../../data/model/response/motivation_response_model.dart';

part 'motivation_event.dart';
part 'motivation_state.dart';

class MotivationBloc extends Bloc<MotivationEvent, MotivationState> {
  final MotivationDatasource _motivationDatasource;
  MotivationBloc(this._motivationDatasource) : super(MotivationInitial()) {
    on<PostMotivation>((event, emit) async {
      emit(MotivationLoading());
      final result = await _motivationDatasource.postMotivation(event.motivation);
      result.fold(
        (l) => emit(MotivationError(l)),
        (r) => emit(
          MotivationSuccess(r),
        ),
      );
    });
  }
}
