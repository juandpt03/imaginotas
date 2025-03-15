import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/home/domain/datasources/note_datasource.dart';
import 'package:imaginotas/src/features/home/domain/entities/note.dart';
import 'package:imaginotas/src/features/home/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDatasource _datasource;

  NoteRepositoryImpl({required NoteDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Either<AppException, NoteEntity>> createNote({
    required NoteEntity note,
  }) {
    return _datasource.createNote(note: note);
  }

  @override
  Future<Either<AppException, void>> deleteNote({required String noteId}) {
    return _datasource.deleteNote(noteId: noteId);
  }

  @override
  Future<Either<AppException, NoteEntity>> getNoteById({
    required String noteId,
  }) {
    return _datasource.getNoteById(noteId: noteId);
  }

  @override
  Stream<List<NoteEntity>> getNotes({required String userId}) {
    return _datasource.getNotes(userId: userId);
  }

  @override
  Stream<List<NoteEntity>> getNotesByCategory({
    required String userId,
    required String category,
  }) {
    return _datasource.getNotesByCategory(userId: userId, category: category);
  }

  @override
  Future<Either<AppException, NoteEntity>> updateNote({
    required NoteEntity note,
  }) {
    return _datasource.updateNote(note: note);
  }

  @override
  Future<Either<AppException, List<NoteEntity>>> searchNotes({
    required String userId,
    required String query,
  }) {
    return _datasource.searchNotes(userId: userId, query: query);
  }
}
