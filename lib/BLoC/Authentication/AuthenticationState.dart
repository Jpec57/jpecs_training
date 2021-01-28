import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}
// waiting to see if the user is authenticated or not on app start.
class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}

// waiting to persist/delete a token
class AuthenticationLoading extends AuthenticationState {}