part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends UsersEvent {
  final int page;
  final int perPage;
  FetchUsers(this.page, {this.perPage = 10});

  @override
  List<Object> get props => [page];
}
