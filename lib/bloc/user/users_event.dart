part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUsers extends UsersEvent {
  final int page;
  FetchUsers(this.page);

  @override
  List<Object> get props => [page];
}
