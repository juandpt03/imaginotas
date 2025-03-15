class NoteValidators {
  static String? validateTitle(String? title) {
    if (title == null || title.isEmpty) {
      return ValidatorMessages.titleRequired;
    }

    if (title.length < 3) {
      return ValidatorMessages.titleTooShort;
    }

    return null;
  }

  static String? validateContent(String? content) {
    if (content == null || content.isEmpty) {
      return ValidatorMessages.contentRequired;
    }

    return null;
  }

  static String? validateCategory(String? category) {
    if (category != null && category.isNotEmpty && category.length < 2) {
      return ValidatorMessages.categoryTooShort;
    }

    return null;
  }
}

class ValidatorMessages {
  static const String titleRequired = "Title is required";
  static const String titleTooShort = "Title must be at least 3 characters";
  static const String contentRequired = "Content is required";
  static const String categoryTooShort =
      "Category must be at least 2 characters";
}
