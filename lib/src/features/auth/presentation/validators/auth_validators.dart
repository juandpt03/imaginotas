import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/core/extensions/string_validator_extension.dart';

class AuthValidators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return ValidatorMessages.emailRequired;

    if (!email.isEmailValid) return ValidatorMessages.invalidEmail;

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return ValidatorMessages.passwordRequired;
    }

    if (password.length < 8) return ValidatorMessages.min8Characters;

    if (!password.isPasswordValid) {
      return ValidatorMessages.includeLetterAndNumber;
    }

    return null;
  }

  static String? validateConfirmPassword(
    String? confirmPassword,
    String? password,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return ValidatorMessages.confirmPasswordRequired;
    }

    if (confirmPassword != password) {
      return ValidatorMessages.passwordsDoNotMatch;
    }

    return null;
  }
}

class ValidatorMessages {
  static String get emailRequired => AppLocalizations.current.emailIsRequired;
  static String get invalidEmail =>
      AppLocalizations.current.invalidEmailAddress;
  static String get passwordRequired =>
      AppLocalizations.current.passwordIsRequired;
  static String get min8Characters =>
      AppLocalizations.current.passwordMustBeAtLeast8Characters;
  static String get includeLetterAndNumber =>
      AppLocalizations.current.includeLetterAndNumber;
  static String get confirmPasswordRequired =>
      AppLocalizations.current.confirmPasswordIsRequired;
  static String get passwordsDoNotMatch => AppLocalizations.current.passwordsDoNotMatch;
}
