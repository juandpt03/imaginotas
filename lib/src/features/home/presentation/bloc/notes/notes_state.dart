part of 'notes_bloc.dart';

sealed class NotesState extends Equatable {
  const NotesState();

  @override
  List<Object> get props => [];
}

final class NotesLoading extends NotesState {
  const NotesLoading();
}

final class NotesSuccess extends NotesState {
  final List<NoteEntity> notes;
  final List<NoteEntity> allNotes;
  final List<String> categories;
  final String selectedCategory;

  const NotesSuccess({
    required this.notes,
    required this.allNotes,
    required this.categories,
    required this.selectedCategory,
  });

  NotesSuccess copyWith({
    List<NoteEntity>? notes,
    List<NoteEntity>? allNotes,
    List<String>? categories,
    String? selectedCategory,
  }) {
    return NotesSuccess(
      notes: notes ?? this.notes,
      allNotes: allNotes ?? this.allNotes,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object> get props => [notes, allNotes, categories, selectedCategory];
}

final class NotesError extends NotesState {
  final AppException error;

  const NotesError(this.error);

  @override
  List<Object> get props => [error];
}
