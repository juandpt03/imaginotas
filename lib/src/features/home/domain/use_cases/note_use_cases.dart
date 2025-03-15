import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/home/domain/domain.dart';

class NoteUseCases {
  final NoteRepository _noteRepository;

  NoteUseCases({required NoteRepository noteRepository})
    : _noteRepository = noteRepository;

  Future<Either<AppException, NoteEntity>> createNote({
    required NoteEntity note,
  }) {
    return _noteRepository.createNote(note: note);
  }

  Future<Either<AppException, NoteEntity>> updateNote({
    required NoteEntity note,
  }) {
    return _noteRepository.updateNote(note: note);
  }

  Future<Either<AppException, void>> deleteNote({required String noteId}) {
    return _noteRepository.deleteNote(noteId: noteId);
  }

  Future<Either<AppException, NoteEntity>> getNoteById({
    required String noteId,
  }) {
    return _noteRepository.getNoteById(noteId: noteId);
  }

  Stream<List<NoteEntity>> getNotes({required String userId}) {
    return _noteRepository.getNotes(userId: userId);
  }

  Stream<List<NoteEntity>> getNotesByCategory({
    required String userId,
    required String category,
  }) {
    return _noteRepository.getNotesByCategory(
      userId: userId,
      category: category,
    );
  }

  Future<Either<AppException, List<NoteEntity>>> searchNotes({
    required String userId,
    required String query,
  }) {
    return _noteRepository.searchNotes(userId: userId, query: query);
  }
}
