// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(
      _current != null,
      'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(
      instance != null,
      'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `An unknown error occurred`
  String get anUnknownErrorOccurred {
    return Intl.message(
      'An unknown error occurred',
      name: 'anUnknownErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected null value`
  String get unexpectedNullValue {
    return Intl.message(
      'Unexpected null value',
      name: 'unexpectedNullValue',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Logging in...`
  String get loggingIn {
    return Intl.message('Logging in...', name: 'loggingIn', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Email is required`
  String get emailIsRequired {
    return Intl.message(
      'Email is required',
      name: 'emailIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email address`
  String get invalidEmailAddress {
    return Intl.message(
      'Invalid email address',
      name: 'invalidEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordIsRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get passwordMustBeAtLeast8Characters {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'passwordMustBeAtLeast8Characters',
      desc: '',
      args: [],
    );
  }

  /// `Include letter and number`
  String get includeLetterAndNumber {
    return Intl.message(
      'Include letter and number',
      name: 'includeLetterAndNumber',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Login here`
  String get loginHere {
    return Intl.message('Login here', name: 'loginHere', desc: '', args: []);
  }

  /// `Welcome back you have been missed!`
  String get welcomeBackYouHaveBeenMissed {
    return Intl.message(
      'Welcome back you have been missed!',
      name: 'welcomeBackYouHaveBeenMissed',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create a new account`
  String get createANewAccount {
    return Intl.message(
      'Create a new account',
      name: 'createANewAccount',
      desc: '',
      args: [],
    );
  }

  /// `Fill in your details to create an account`
  String get fillInYourDetailsToCreateAnAccount {
    return Intl.message(
      'Fill in your details to create an account',
      name: 'fillInYourDetailsToCreateAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password is required`
  String get confirmPasswordIsRequired {
    return Intl.message(
      'Confirm password is required',
      name: 'confirmPasswordIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Creating account...`
  String get creatingAccount {
    return Intl.message(
      'Creating account...',
      name: 'creatingAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? Login`
  String get alreadyHaveAnAccountLogin {
    return Intl.message(
      'Already have an account? Login',
      name: 'alreadyHaveAnAccountLogin',
      desc: '',
      args: [],
    );
  }

  /// `My notes`
  String get myNotes {
    return Intl.message('My notes', name: 'myNotes', desc: '', args: []);
  }

  /// `Search notes...`
  String get searchNotes {
    return Intl.message(
      'Search notes...',
      name: 'searchNotes',
      desc: '',
      args: [],
    );
  }

  /// `No notes yet`
  String get noNotesYet {
    return Intl.message('No notes yet', name: 'noNotesYet', desc: '', args: []);
  }

  /// `Create your first note by tapping the button below.`
  String get createYourFirstNoteByTappingTheButtonBelow {
    return Intl.message(
      'Create your first note by tapping the button below.',
      name: 'createYourFirstNoteByTappingTheButtonBelow',
      desc: '',
      args: [],
    );
  }

  /// `Title is required`
  String get titleIsRequired {
    return Intl.message(
      'Title is required',
      name: 'titleIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Title must be at least 3 characters`
  String get titleMustBeAtLeast3Characters {
    return Intl.message(
      'Title must be at least 3 characters',
      name: 'titleMustBeAtLeast3Characters',
      desc: '',
      args: [],
    );
  }

  /// `Content is required`
  String get contentIsRequired {
    return Intl.message(
      'Content is required',
      name: 'contentIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Category must be at least 2 characters`
  String get categoryMustBeAtLeast2Characters {
    return Intl.message(
      'Category must be at least 2 characters',
      name: 'categoryMustBeAtLeast2Characters',
      desc: '',
      args: [],
    );
  }

  /// `Delete Note`
  String get deleteNote {
    return Intl.message('Delete Note', name: 'deleteNote', desc: '', args: []);
  }

  /// `Are you sure you want to delete this note?`
  String get areYouSureYouWantToDeleteThisNote {
    return Intl.message(
      'Are you sure you want to delete this note?',
      name: 'areYouSureYouWantToDeleteThisNote',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Note updated successfully!`
  String get noteUpdatedSuccessfully {
    return Intl.message(
      'Note updated successfully!',
      name: 'noteUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Note created successfully!`
  String get noteCreatedSuccessfully {
    return Intl.message(
      'Note created successfully!',
      name: 'noteCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Edit Note`
  String get editNote {
    return Intl.message('Edit Note', name: 'editNote', desc: '', args: []);
  }

  /// `Create Note`
  String get createNote {
    return Intl.message('Create Note', name: 'createNote', desc: '', args: []);
  }

  /// `Title`
  String get title {
    return Intl.message('Title', name: 'title', desc: '', args: []);
  }

  /// `Category (optional)`
  String get categoryOptional {
    return Intl.message(
      'Category (optional)',
      name: 'categoryOptional',
      desc: '',
      args: [],
    );
  }

  /// `Note content`
  String get noteContent {
    return Intl.message(
      'Note content',
      name: 'noteContent',
      desc: '',
      args: [],
    );
  }

  /// `Update Note`
  String get updateNote {
    return Intl.message('Update Note', name: 'updateNote', desc: '', args: []);
  }

  /// `Save Note`
  String get saveNote {
    return Intl.message('Save Note', name: 'saveNote', desc: '', args: []);
  }

  /// `Updating...`
  String get updating {
    return Intl.message('Updating...', name: 'updating', desc: '', args: []);
  }

  /// `Saving...`
  String get saving {
    return Intl.message('Saving...', name: 'saving', desc: '', args: []);
  }

  /// `Are you sure you want to delete this note? This action cannot be undone.`
  String get areYouSureYouWantToDeleteThisNoteThis {
    return Intl.message(
      'Are you sure you want to delete this note? This action cannot be undone.',
      name: 'areYouSureYouWantToDeleteThisNoteThis',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
