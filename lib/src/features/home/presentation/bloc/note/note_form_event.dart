part of 'note_form_bloc.dart';

sealed class NoteFormEvent {
  const NoteFormEvent();
}

class TitleChanged extends NoteFormEvent {
  final String title;
  const TitleChanged(this.title);
}

class ContentChanged extends NoteFormEvent {
  final String content;
  const ContentChanged(this.content);
}

class CategoryChanged extends NoteFormEvent {
  final String category;
  const CategoryChanged(this.category);
}

class FormSubmitted extends NoteFormEvent {
  final String userId;
  const FormSubmitted({required this.userId});
}

class FormReset extends NoteFormEvent {}

class SetLoading extends NoteFormEvent {
  final bool isLoading;
  const SetLoading(this.isLoading);
}
