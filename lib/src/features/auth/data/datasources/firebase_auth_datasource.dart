import 'package:imaginotas/src/core/core.dart';
import 'package:imaginotas/src/features/auth/data/data.dart';
import 'package:imaginotas/src/features/auth/domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDatasource implements AuthDatasource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDatasource({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  @override
  Future<Either<AppException<Exception>, UserEntity>> login({
    required UserEntity user,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return Either.left(AppException.nullValue());

      return Either.right(UserModel.fromFirebaseUser(firebaseUser));
    } on FirebaseAuthException catch (e) {
      return Either.left(AppException.fromMessage(e.message));
    } catch (e) {
      return Either.left(AppException.fromMessage(e.toString()));
    }
  }

  @override
  Future<Either<AppException<Exception>, UserEntity>> register({
    required UserEntity user,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return Either.left(AppException.nullValue());

      return Either.right(UserModel.fromFirebaseUser(firebaseUser));
    } on FirebaseAuthException catch (e) {
      return Either.left(AppException.fromMessage(e.message));
    } catch (e) {
      return Either.left(AppException.fromMessage(e.toString()));
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges =>
      _firebaseAuth.authStateChanges().map((user) {
        if (user == null) return null;
        return UserModel.fromFirebaseUser(user);
      });

  @override
  UserEntity? get currentUser {
    final user = _firebaseAuth.currentUser;
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  @override
  Future<Either<AppException, void>> logout() async {
    try {
      final response = await _firebaseAuth.signOut();
      return Either.right(response);
    } on FirebaseAuthException catch (e) {
      return Either.left(AppException.fromMessage(e.message));
    } catch (e) {
      return Either.left(AppException.fromMessage(e.toString()));
    }
  }
}
