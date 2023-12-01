import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/datasource/remote/motivation_datasource.dart';
import '../../data/model/response/get_motivation_response_model.dart';

part 'get_all_motivation_event.dart';
part 'get_all_motivation_state.dart';

class GetAllMotivationBloc extends Bloc<GetAllMotivationEvent, GetAllMotivationState> {
  final MotivationDatasource _motivationDatasource;
  GetAllMotivationBloc(this._motivationDatasource) : super(GetAllMotivationInitial()) {
    on<GetAllMotivation>((event, emit) async {
      emit(GetAllMotivationLoading());
      final result = await _motivationDatasource.getMotivation();
      result.fold(
        (l) => emit(GetAllMotivationError(l)),
        (r) => emit(GetAllMotivationSuccess(r)),
      );
    });
  }
}
