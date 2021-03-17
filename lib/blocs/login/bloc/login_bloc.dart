import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:jpec_training/blocs/login/models/models.dart';
import 'package:jpec_training/blocs/login/models/username.dart';
import 'package:jpec_training/blocs/server/bloc/server_state.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  LoginState _mapUsernameChangedToState(
    LoginUsernameChanged event,
    LoginState state,
  ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  String? getUsernameError(LoginState state) {
    if (state.username.invalid) {
      if (state.username.error == UsernameValidationError.tooShort) {
        return "Your username must have at least $MIN_LENGTH_USERNAME";
      }
      return 'Username cannot be left blank';
    }
    return null;
  }

  String? getPasswordError(LoginState state) {
    if (state.password.invalid) {
      if (state.password.error == PasswordValidationError.tooShort) {
        return "Too short.";
      }
      return 'Password cannot be left blank';
    }
    return null;
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        bool isLoginSuccess = await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        if (isLoginSuccess) {
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } else {
          yield state.copyWith(
              serverState: ServerState(
                  code: 403, message: "You are not Jpec and never will be."),
              status: FormzStatus.submissionFailure);
        }
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
