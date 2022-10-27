import 'package:bkapp/domain/models/user_model.dart';
import 'package:bkapp/domain/repository/mock_api_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_data_event.dart';
part 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final MockApiRepository _repository;
  UserDataBloc(MockApiRepository repository)
      : _repository = repository,
        super(const UserDataState()) {
    //onUserDataFetchEvent func
    on<UserDataFetchEvent>(_onUserDataFetch);
  }

// onUserDataFetchEvent func body
  void _onUserDataFetch(
      UserDataFetchEvent event, Emitter<UserDataState> emit) async {
    try {
      if (state.status == FetchStatus.initial) {
        final result = await _repository.fetchData();
        return emit(state.copyWith(status: FetchStatus.success, users: result));
      }

      final users = await _repository.fetchData();
      users!.isEmpty
          ? emit(state.copyWith(status: FetchStatus.failure))
          : emit(state.copyWith(
              status: FetchStatus.success,
              users: List.of(state.users)..addAll(users)));
    } catch (_) {
      emit(state.copyWith(status: FetchStatus.failure));
    }
  }
}
