import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/home/data/datasources/firestore_note_datasource.dart';
import 'package:imaginotas/src/features/home/data/repositories/note_repository_impl.dart';
import 'package:imaginotas/src/features/home/domain/datasources/note_datasource.dart';
import 'package:imaginotas/src/features/home/domain/repositories/note_repository.dart';
import 'package:imaginotas/src/features/home/domain/use_cases/note_use_cases.dart';

class HomeDependency {
  HomeDependency._();

  static void init() {
    DI.sl.registerLazySingleton<NoteDatasource>(
      () => FirestoreNoteDatasource(firestore: DI.sl.get()),
    );

    DI.sl.registerLazySingleton<NoteRepository>(
      () => NoteRepositoryImpl(datasource: DI.sl.get()),
    );

    DI.sl.registerLazySingleton<NoteUseCases>(
      () => NoteUseCases(noteRepository: DI.sl.get()),
    );
  }
}
