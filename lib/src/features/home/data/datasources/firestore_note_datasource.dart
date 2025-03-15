import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/home/data/model/note_model.dart';
import 'package:imaginotas/src/features/home/domain/domain.dart';

class FirestoreNoteDatasource implements NoteDatasource {
  final FirebaseFirestore _firestore;
  final String _collectionPath = Collections.notes;

  FirestoreNoteDatasource({required FirebaseFirestore firestore})
    : _firestore = firestore;

  CollectionReference<Map<String, dynamic>> get _notesCollection =>
      _firestore.collection(_collectionPath);

  @override
  Future<Either<AppException, NoteEntity>> createNote({
    required NoteEntity note,
  }) async {
    try {
      final noteModel = NoteModel.fromEntity(note);

      final docRef = await _notesCollection.add(noteModel.toJson());

      final doc = await docRef.get();
      final createdNote = NoteModel.fromFirestore(doc);

      return Either.right(createdNote);
    } catch (e) {
      return Either.left(AppException.fromMessage(e.toString()));
    }
  }

  @override
  Future<Either<AppException, NoteEntity>> updateNote({
    required NoteEntity note,
  }) async {
    try {
      final noteModel = NoteModel.fromEntity(note);

      await _notesCollection.doc(note.id).update(noteModel.toJson());

      final doc = await _notesCollection.doc(note.id).get();
      final updatedNote = NoteModel.fromFirestore(doc);

      return Either.right(updatedNote);
    } on FirebaseException catch (e) {
      return Either.left(AppException.fromMessage(e.message));
    } catch (e) {
      return Either.left(AppException.fromMessage(e.toString()));
    }
  }

  @override
  Future<Either<AppException, void>> deleteNote({
    required String noteId,
  }) async {
    try {
      await _notesCollection.doc(noteId).delete();
      return Either.right(null);
    } on FirebaseException catch (e) {
      return Either.left(AppException.fromMessage(e.message));
    } catch (e) {
      return Either.left(AppException.fromMessage(e.toString()));
    }
  }

  @override
  Future<Either<AppException, NoteEntity>> getNoteById({
    required String noteId,
  }) async {
    try {
      final doc = await _notesCollection.doc(noteId).get();

      if (!doc.exists) {
        return Either.left(AppException.nullValue());
      }

      final note = NoteModel.fromFirestore(doc);
      return Either.right(note);
    } on FirebaseException catch (e) {
      return Either.left(AppException.fromMessage(e.message));
    } catch (e) {
      return Either.left(AppException.fromMessage(e.toString()));
    }
  }

  @override
  Stream<List<NoteEntity>> getNotes({required String userId}) {
    return _notesCollection
        .where('userId', isEqualTo: userId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => NoteModel.fromFirestore(doc))
              .toList();
        });
  }

  @override
  Stream<List<NoteEntity>> getNotesByCategory({
    required String userId,
    required String category,
  }) {
    return _notesCollection
        .where('userId', isEqualTo: userId)
        .where('category', isEqualTo: category)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => NoteModel.fromFirestore(doc))
              .toList();
        });
  }

  @override
  Future<Either<AppException, List<NoteEntity>>> searchNotes({
    required String userId,
    required String query,
  }) async {
    try {
      final snapshot =
          await _notesCollection.where('userId', isEqualTo: userId).get();

      final notes =
          snapshot.docs.map((doc) => NoteModel.fromFirestore(doc)).where((
            note,
          ) {
            final titleMatch = note.title.toLowerCase().contains(
              query.toLowerCase(),
            );
            final contentMatch = note.content.toLowerCase().contains(
              query.toLowerCase(),
            );
            final categoryMatch = note.category.toLowerCase().contains(
              query.toLowerCase(),
            );

            return titleMatch || contentMatch || categoryMatch;
          }).toList();

      return Either.right(notes);
    } on FirebaseException catch (e) {
      return Either.left(AppException.fromMessage(e.message));
    } catch (e) {
      return Either.left(AppException.fromMessage(e.toString()));
    }
  }
}
