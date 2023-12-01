import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vigenesia/data/datasource/local/auth_local_datasource.dart';
import 'package:vigenesia/data/model/response/get_motivation_user_response_model.dart';

import '../../data/datasource/remote/motivation_datasource.dart';

part 'get_motivation_user_event.dart';
part 'get_motivation_user_state.dart';

class GetMotivationUserBloc extends Bloc<GetMotivationUserEvent, GetMotivationUserState> {
  final MotivationDatasource _motivationDatasource;
  final AuthLocalDatasource _authLocalDatasource;
  GetMotivationUserBloc(this._motivationDatasource, this._authLocalDatasource) : super(GetMotivationUserInitial()) {
    on<GetMotivationUser>((event, emit) async {
      emit(GetMotivationUserLoading());
      final result = await _motivationDatasource.getMotivationByUserId(await _authLocalDatasource.getUserId());
      result.fold(
        (l) => emit(GetMotivationUserError(l)),
        (r) => emit(GetMotivationUserSuccess(r)),
      );
    });
  }
}
