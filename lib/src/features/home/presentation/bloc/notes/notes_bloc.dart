import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginotas/src/core/error/app_exeption.dart';
import 'package:imaginotas/src/features/auth/domain/domain.dart';
import 'package:imaginotas/src/features/home/domain/domain.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NoteUseCases _noteUseCases;
  final UserEntity? _currentUser;
  StreamSubscription<List<NoteEntity>>? _notesSubscription;

  NotesBloc({
    required NoteUseCases noteUseCases,
    required UserEntity? currentUser,
  }) : _noteUseCases = noteUseCases,
       _currentUser = currentUser,
       super(const NotesLoading()) {
    eventsHandler();
    loadNotes();
  }

  void eventsHandler() {
    on<LoadNotes>(_onLoadNotes);
    on<OnNotesError>(_onNotesError);
    on<NotesUpdated>(_onNotesUpdated);
    on<FilterByCategory>(_onFilterByCategory);
    on<ClearFilter>(_onClearFilter);
    on<SearchNotes>(_onSearchNotes);
    on<DeleteNote>(_onDeleteNote);
  }

  void _onLoadNotes(LoadNotes event, Emitter<NotesState> emit) {
    emit(const NotesLoading());

    _notesSubscription?.cancel();
    _notesSubscription = _noteUseCases
        .getNotes(userId: event.userId)
        .listen(
          (notes) {
            if (!isClosed) {
              add(NotesUpdated(notes: notes));
            }
          },
          onError: (error) {
            if (!isClosed) {
              _addError(AppException.fromMessage(error.toString()));
            }
          },
        );
  }

  void _onNotesError(OnNotesError event, Emitter<NotesState> emit) {
    emit(NotesError(event.error));
  }

  void _onNotesUpdated(NotesUpdated event, Emitter<NotesState> emit) {
    final categories =
        event.notes
            .map((note) => note.category)
            .where((category) => category.isNotEmpty)
            .toSet()
            .toList();

    categories.sort();

    emit(
      NotesSuccess(
        notes: event.notes,
        allNotes: event.notes,
        categories: categories,
        selectedCategory: '',
      ),
    );
  }

  void _onFilterByCategory(FilterByCategory event, Emitter<NotesState> emit) {
    if (state is! NotesSuccess) return;

    emit(const NotesLoading());

    _notesSubscription?.cancel();
    _notesSubscription = _noteUseCases
        .getNotesByCategory(userId: event.userId, category: event.category)
        .listen(
          (notes) {
            if (!isClosed) {
              add(NotesUpdated(notes: notes));

              if (state is NotesSuccess) {
                final notesState = state as NotesSuccess;
                add(NotesUpdated(notes: notesState.notes));
              }
            }
          },
          onError: (error) {
            if (!isClosed) {
              _addError(AppException.fromMessage(error.toString()));
            }
          },
        );
  }

  void _onClearFilter(ClearFilter event, Emitter<NotesState> emit) {
    if (state is! NotesSuccess) return;

    final currentState = state as NotesSuccess;
    emit(
      currentState.copyWith(notes: currentState.allNotes, selectedCategory: ''),
    );
  }

  void _onSearchNotes(SearchNotes event, Emitter<NotesState> emit) async {
    if (state is! NotesSuccess) return;

    final currentState = state as NotesSuccess;

    if (event.query.isEmpty) {
      emit(currentState.copyWith(notes: currentState.allNotes));
      return;
    }

    emit(const NotesLoading());

    try {
      final result = await _noteUseCases.searchNotes(
        userId: event.userId,
        query: event.query,
      );

      if (emit.isDone || isClosed) return;

      result.when(
        left: (error) {
          add(OnNotesError(error));
        },
        right: (notes) {
          emit(
            NotesSuccess(
              notes: notes,
              allNotes: currentState.allNotes,
              categories: currentState.categories,
              selectedCategory: currentState.selectedCategory,
            ),
          );
        },
      );
    } catch (e) {
      if (!isClosed) {
        add(OnNotesError(AppException.fromMessage(e.toString())));
      }
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    try {
      final result = await _noteUseCases.deleteNote(noteId: event.noteId);

      if (emit.isDone || isClosed) return;

      result.when(left: (error) => add(OnNotesError(error)), right: (_) {});
    } catch (e) {
      if (!isClosed) {
        add(OnNotesError(AppException.fromMessage(e.toString())));
      }
    }
  }

  @override
  Future<void> close() {
    _notesSubscription?.cancel();
    return super.close();
  }

  void loadNotes() {
    final userId = _currentUser?.id;
    if (userId == null) return;
    add(LoadNotes(userId: userId));
  }

  void _addError(AppException error) {
    add(OnNotesError(error));
  }

  // Public methods to dispatch events
  void filterByCategory(String userId, String category) =>
      add(FilterByCategory(userId: userId, category: category));
  void clearFilter() => add(ClearFilter());
  void searchNotes(String? userId, String query) {
    if (userId == null) return;
    add(SearchNotes(userId: userId, query: query));
  }

  void deleteNote(String noteId) => add(DeleteNote(noteId: noteId));
}
