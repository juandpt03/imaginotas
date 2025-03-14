import 'package:imaginotas/src/core/utils/regex_validator.dart';

extension StringValidatorExtension on String {
  bool get isEmailValid => RegexValidator.email.hasMatch(this);
  bool get isPasswordValid => RegexValidator.password.hasMatch(this);
}
