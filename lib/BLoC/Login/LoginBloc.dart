import 'dart:async';
import 'package:jpec_training/BLoC/Authentication/AuthenticationBloc.dart';
import 'package:jpec_training/BLoC/Authentication/AuthenticationEvent.dart';
import 'package:jpec_training/BLoC/Login/LoginEvent.dart';
import 'package:jpec_training/BLoC/Login/LoginState.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
//https://medium.com/flutter-community/flutter-login-tutorial-with-flutter-bloc-ea606ef701ad
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}