import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/core/extensions/string_validator_extension.dart';

class AuthValidators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AuthValidatorMessages.emailRequired;
    }

    if (!email.isEmailValid) return AuthValidatorMessages.invalidEmail;

    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AuthValidatorMessages.passwordRequired;
    }

    if (password.length < 8) return AuthValidatorMessages.min8Characters;

    if (!password.isPasswordValid) {
      return AuthValidatorMessages.includeLetterAndNumber;
    }

    return null;
  }

  static String? validateConfirmPassword(
    String? confirmPassword,
    String? password,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return AuthValidatorMessages.confirmPasswordRequired;
    }

    if (confirmPassword != password) {
      return AuthValidatorMessages.passwordsDoNotMatch;
    }

    return null;
  }
}

class AuthValidatorMessages {
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
  static String get passwordsDoNotMatch =>
      AppLocalizations.current.passwordsDoNotMatch;
}
