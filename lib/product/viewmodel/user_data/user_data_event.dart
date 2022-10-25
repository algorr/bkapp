part of 'user_data_bloc.dart';

@immutable
abstract class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object> get props => [];
}

@immutable
class UserDataFetchEvent extends UserDataEvent {
  const UserDataFetchEvent();
}
