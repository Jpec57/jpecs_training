import 'package:formz/formz.dart';

enum PasswordValidationError { empty, tooShort }
const MIN_LENGTH_PASSWORD = 4;

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError validator(String value) {
    if (value?.isNotEmpty == true) {
      if (value.length < MIN_LENGTH_PASSWORD) {
        return PasswordValidationError.tooShort;
      }
    }
    // return value?.isNotEmpty == true ? null : UsernameValidationError.empty;
    return value?.isNotEmpty == true ? null : PasswordValidationError.empty;
  }
}
