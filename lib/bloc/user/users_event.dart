part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object?> get props => [];
}

class FetchUsers extends UsersEvent {
  final int page;
  const FetchUsers(this.page);
}

class RefreshUsers extends UsersEvent {}
