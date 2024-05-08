part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<Datum> users;
  final bool hasReachedMax;

  UsersLoaded({required this.users, required this.hasReachedMax});

  @override
  List<Object> get props => [users, hasReachedMax];
}

class UsersError extends UsersState {
  final String message;

  UsersError(this.message);

  @override
  List<Object> get props => [message];
}
