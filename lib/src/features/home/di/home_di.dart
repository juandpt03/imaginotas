import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/home/data/data.dart';
import 'package:imaginotas/src/features/home/domain/domain.dart';

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
