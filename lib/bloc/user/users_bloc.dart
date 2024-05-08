import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import '../../constant/variables.dart';
import '../../data/models/response/users_response_model.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final http.Client httpClient;
  final int perPage = 10;

  UsersBloc({required this.httpClient}) : super(UsersInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<RefreshUsers>(_onRefreshUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UsersState> emit) async {
    if (state is UsersLoading) return;
    final currentState = state;
    var nextPage = 1;

    if (currentState is UsersLoaded) {
      if (currentState.hasReachedMax) return;
      nextPage = (currentState.users.length ~/ perPage) + 1;
    }

    emit(UsersLoading());
    try {
      final response = await httpClient.get(
        Uri.parse('${Variables.baseUrl}?page=$nextPage'),
      );
      if (response.statusCode == 200) {
        final usersResponse = Users.fromJson(json.decode(response.body));
        bool hasReachedMax = usersResponse.data.length < perPage;
        emit(UsersLoaded(
            users: currentState is UsersLoaded
                ? currentState.users + usersResponse.data
                : usersResponse.data,
            hasReachedMax: hasReachedMax));
      } else {
        // Log the error or handle it accordingly
        print('Server returned status code: ${response.statusCode}');
        emit(const UsersError('Failed to fetch users'));
      }
    } catch (e) {
      print('Error fetching users: $e');
      emit(UsersError(e.toString()));
    }
  }


  void _onRefreshUsers(RefreshUsers event, Emitter<UsersState> emit) async {
    add(const FetchUsers(1));
  }
}
