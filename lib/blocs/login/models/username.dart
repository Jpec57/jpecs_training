import 'package:formz/formz.dart';

enum UsernameValidationError { empty, tooShort }
const MIN_LENGTH_USERNAME = 4;
class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      if (value!.length < MIN_LENGTH_USERNAME) {
        return UsernameValidationError.tooShort;
      }
    }
    return value?.isNotEmpty == true ? null : UsernameValidationError.empty;
  }
}
