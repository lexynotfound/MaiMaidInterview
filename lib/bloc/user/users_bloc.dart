import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/response/users_response_model.dart';
import '../../data/remote/apiClient.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final ApiClient apiClient;

  UsersBloc({required this.apiClient}) : super(UsersInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UsersState> emit) async {
    if (state is UsersLoading) return;
    emit(UsersLoading());

    final result = await apiClient.fetchUsers(page: event.page);
    result.fold(
      (error) => emit(UsersError(error)),
      (users) => emit(UsersLoaded(users: users.data, hasReachedMax: false)),
    );
  }
}
