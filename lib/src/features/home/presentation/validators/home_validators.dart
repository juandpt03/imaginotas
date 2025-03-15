import 'package:imaginotas/src/core/config/intl/l10n.dart';

class HomeValidators {
  static String? validateTitle(String? title) {
    if (title == null || title.isEmpty) {
      return HomeValidatorMessages.titleRequired;
    }

    if (title.length < 3) {
      return HomeValidatorMessages.titleTooShort;
    }

    return null;
  }

  static String? validateContent(String? content) {
    if (content == null || content.isEmpty) {
      return HomeValidatorMessages.contentRequired;
    }

    return null;
  }

  static String? validateCategory(String? category) {
    if (category != null && category.isNotEmpty && category.length < 2) {
      return HomeValidatorMessages.categoryTooShort;
    }

    return null;
  }
}

class HomeValidatorMessages {
  static String get titleRequired => AppLocalizations.current.titleIsRequired;
  static String get titleTooShort =>
      AppLocalizations.current.titleMustBeAtLeast3Characters;
  static String get contentRequired =>
      AppLocalizations.current.contentIsRequired;
  static String get categoryTooShort =>
      AppLocalizations.current.categoryMustBeAtLeast2Characters;
}
