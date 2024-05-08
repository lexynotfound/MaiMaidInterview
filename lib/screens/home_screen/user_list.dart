import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user/users_bloc.dart';
import '../custome_screen/view_card.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final ScrollController _scrollController = ScrollController();
  late UsersBloc _usersBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _usersBloc = context.read<
        UsersBloc>(); // Assuming UsersBloc is provided above this widget in the tree
    _usersBloc.add(const FetchUsers(1)); // Initially load the first page
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _usersBloc.add(
          FetchUsers((_usersBloc.state as UsersLoaded).users.length ~/ 10 + 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is UsersLoading && state is! UsersLoaded) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UsersLoaded) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.users.length
                : state.users.length +
                    1, // Plus one for the loading indicator at the bottom
            itemBuilder: (BuildContext context, int index) {
              return index >= state.users.length
                  ? const Center(child: CircularProgressIndicator())
                  : ViewCard(
                      imageUrl: state.users[index].avatar,
                      firstName: state.users[index].firstName,
                      lastName: state.users[index].lastName,
                      email: state.users[index].email,
                    );
            },
          );
        } else if (state is UsersError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const Center(child: Text('Please wait...'));
      },
    );
  }
}
