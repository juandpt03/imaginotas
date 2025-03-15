part of 'note_form_bloc.dart';

class NoteFormState extends Equatable {
  final NoteEntity note;
  final bool isLoading;
  final bool isSuccess;
  final bool isEditing;
  final AppException? error;

  const NoteFormState({
    required this.note,
    this.isLoading = false,
    this.isSuccess = false,
    this.isEditing = false,
    this.error,
  });

  NoteFormState copyWith({
    NoteEntity? note,
    bool? isLoading,
    bool? isSuccess,
    bool? isEditing,
    AppException? error,
  }) {
    return NoteFormState(
      note: note ?? this.note,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEditing: isEditing ?? this.isEditing,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [note, isLoading, isSuccess, isEditing, error];
}
