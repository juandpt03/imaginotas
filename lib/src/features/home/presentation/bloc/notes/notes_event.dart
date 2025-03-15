part of 'notes_bloc.dart';

sealed class NotesEvent {
  const NotesEvent();
}

class LoadNotes extends NotesEvent {
  final String userId;
  const LoadNotes({required this.userId});
}

class NotesUpdated extends NotesEvent {
  final List<NoteEntity> notes;
  const NotesUpdated({required this.notes});
}

class FilterByCategory extends NotesEvent {
  final String userId;
  final String category;
  const FilterByCategory({required this.userId, required this.category});
}

class ClearFilter extends NotesEvent {}

class SearchNotes extends NotesEvent {
  final String userId;
  final String query;
  const SearchNotes({required this.userId, required this.query});
}

class DeleteNote extends NotesEvent {
  final String noteId;
  const DeleteNote({required this.noteId});
}

class OnNotesError extends NotesEvent {
  final AppException error;
  const OnNotesError(this.error);
}
