import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/home/domain/entities/note.dart';

abstract class NoteDatasource {
  Future<Either<AppException, NoteEntity>> createNote({
    required NoteEntity note,
  });
  Future<Either<AppException, NoteEntity>> updateNote({
    required NoteEntity note,
  });
  Future<Either<AppException, void>> deleteNote({required String noteId});
  Future<Either<AppException, NoteEntity>> getNoteById({
    required String noteId,
  });
  Stream<List<NoteEntity>> getNotes({required String userId});
  Stream<List<NoteEntity>> getNotesByCategory({
    required String userId,
    required String category,
  });
  Future<Either<AppException, List<NoteEntity>>> searchNotes({
    required String userId,
    required String query,
  });
}
