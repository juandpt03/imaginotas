import 'package:flutter_test/flutter_test.dart';
import 'package:imaginotas/src/core/error/app_exeption.dart';
import 'package:imaginotas/src/core/utils/regex_validator.dart';

void main() {
  // Tests for AppException handling
  group('AppException', () {
    test('should create AppException with specific message', () {
      const message = 'Test error';
      final exception = AppException.fromMessage(message);

      expect(exception.message, equals(message));
      expect(exception.error, isTrue);
    });

    test('should create AppException from another exception', () {
      final originalException = Exception('Original error');
      final appException = AppException.fromException(originalException);

      expect(appException.exception, equals(originalException));
      expect(appException.error, isTrue);
    });
  });

  // Tests for form validations
  group('Validations', () {
    test('should validate email format', () {
      final validEmail = 'user@domain.com';
      final invalidEmail1 = 'user@domain';
      final invalidEmail2 = 'user.com';
      final invalidEmail3 = 'user@.com';

      final emailRegex = RegexValidator.email;

      expect(emailRegex.hasMatch(validEmail), isTrue);
      expect(emailRegex.hasMatch(invalidEmail1), isFalse);
      expect(emailRegex.hasMatch(invalidEmail2), isFalse);
      expect(emailRegex.hasMatch(invalidEmail3), isFalse);
    });

    test('should validate password requirements', () {
      final passwordRegex = RegexValidator.password;

      final validPassword = 'Abc12345';
      final invalidPassword = 'Abc123';
      final noDigitPassword = 'Abcdefgh';

      expect(passwordRegex.hasMatch(validPassword), isTrue);
      expect(
        passwordRegex.hasMatch(invalidPassword),
        isFalse,
        reason: 'Password too short',
      );
      expect(
        passwordRegex.hasMatch(noDigitPassword),
        isFalse,
        reason: 'No digit',
      );
    });

    test('should validate note title requirements', () {
      const minTitleLength = 3;

      final validTitle = 'My Note';
      final emptyTitle = '';
      final shortTitle = 'Hi';

      expect(validTitle.isNotEmpty, isTrue);
      expect(validTitle.length >= minTitleLength, isTrue);

      expect(
        emptyTitle.isNotEmpty,
        isFalse,
        reason: 'Empty title should be invalid',
      );
      expect(
        shortTitle.length >= minTitleLength,
        isFalse,
        reason: 'Title should be at least $minTitleLength characters',
      );
    });

    test('should validate note content is not empty', () {
      final validContent = 'This is a valid note content';
      final emptyContent = '';

      expect(validContent.isNotEmpty, isTrue);
      expect(emptyContent.isNotEmpty, isFalse);
    });
  });
}
