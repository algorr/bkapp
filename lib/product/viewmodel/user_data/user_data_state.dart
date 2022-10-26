// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_data_bloc.dart';

// enums status for user data fetch
enum FetchStatus { initial, success, failure }

class UserDataState extends Equatable {
  const UserDataState({
    this.status = FetchStatus.initial,
    this.users = const <User>[],
  });
  final FetchStatus status;
  final List<User> users;
  //final bool isMaxReached;
  @override
  List<Object?> get props => [status, users];

  UserDataState copyWith({
    FetchStatus? status,
    List<User>? users,
  }) {
    return UserDataState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
