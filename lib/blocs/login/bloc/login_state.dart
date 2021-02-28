part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.serverState = const ServerState(),
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final ServerState serverState;

  LoginState copyWith(
      {FormzStatus status,
      Username username,
      Password password,
      ServerState serverState}) {
    return LoginState(
      serverState: serverState ?? this.serverState,
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}
