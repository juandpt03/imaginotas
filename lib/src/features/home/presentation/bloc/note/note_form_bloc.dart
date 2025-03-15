import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginotas/src/core/error/app_exeption.dart';
import 'package:imaginotas/src/features/home/domain/domain.dart';

part 'note_form_event.dart';
part 'note_form_state.dart';

class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  final NoteUseCases _noteUseCases;

  NoteFormBloc({required NoteUseCases noteUseCases, NoteEntity? initialNote})
    : _noteUseCases = noteUseCases,
      super(
        NoteFormState(
          note: initialNote ?? NoteEntity.empty(),
          isEditing: initialNote != null,
        ),
      ) {
    on<TitleChanged>(_onTitleChanged);
    on<ContentChanged>(_onContentChanged);
    on<CategoryChanged>(_onCategoryChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<FormReset>(_onFormReset);
    on<SetLoading>(_onSetLoading);
  }

  void _onTitleChanged(TitleChanged event, Emitter<NoteFormState> emit) {
    final updatedNote = state.note.copyWith(title: event.title);
    emit(state.copyWith(note: updatedNote));
  }

  void _onContentChanged(ContentChanged event, Emitter<NoteFormState> emit) {
    final updatedNote = state.note.copyWith(content: event.content);
    emit(state.copyWith(note: updatedNote));
  }

  void _onCategoryChanged(CategoryChanged event, Emitter<NoteFormState> emit) {
    final updatedNote = state.note.copyWith(category: event.category);
    emit(state.copyWith(note: updatedNote));
  }

  void _onSetLoading(SetLoading event, Emitter<NoteFormState> emit) {
    emit(state.copyWith(isLoading: event.isLoading));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<NoteFormState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, isSuccess: false));

    final noteWithUser = state.note.copyWith(
      userId: event.userId,
      updatedAt: DateTime.now(),
    );

    final result =
        state.isEditing
            ? await _noteUseCases.updateNote(note: noteWithUser)
            : await _noteUseCases.createNote(note: noteWithUser);

    result.when(
      left:
          (exception) =>
              emit(state.copyWith(isLoading: false, error: exception)),
      right:
          (note) => emit(
            state.copyWith(isLoading: false, isSuccess: true, note: note),
          ),
    );
  }

  void _onFormReset(FormReset event, Emitter<NoteFormState> emit) {
    emit(
      NoteFormState(
        note: NoteEntity(createdAt: DateTime.now(), updatedAt: DateTime.now()),
      ),
    );
  }

  // Public methods to dispatch events
  void onTitleChanged(String title) => add(TitleChanged(title));
  void onContentChanged(String content) => add(ContentChanged(content));
  void onCategoryChanged(String category) => add(CategoryChanged(category));
  void onFormSubmitted(String userId) => add(FormSubmitted(userId: userId));
  void onFormReset() => add(FormReset());
  void setLoading(bool isLoading) => add(SetLoading(isLoading));
}
