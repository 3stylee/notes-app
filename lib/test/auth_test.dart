import 'package:notes_app/services/auth/auth_exceptions.dart';
import 'package:notes_app/services/auth/auth_provider.dart';
import 'package:notes_app/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();

    test('Should not be initialised to begin with', () {
      expect(provider.isInitialised, false);
    });

    test('Cannot log out if not initialised', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitialisedException>()),
      );
    });

    test('Should be able to be initialsed', () async {
      await provider.initialise();
      expect(provider.isInitialised, true);
    });

    test('User should be null after initialisation', () {
      expect(provider.currentUser, null);
    });

    test('Should be able to initialise in less than 2 seconds', () async {
      await provider.initialise();
      expect(provider.isInitialised, true);
    }, timeout: const Timeout(Duration(seconds: 2)));
  });
}

class NotInitialisedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialised = false;
  bool get isInitialised => _isInitialised;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialised) throw NotInitialisedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialise() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialised = true;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    if (!isInitialised) throw NotInitialisedException();
    const user = AuthUser(
      isEmailVerified: false,
      email: 'random@rand.com',
      id: 'myID',
    );
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialised) throw NotInitialisedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialised) throw NotInitialisedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(
      isEmailVerified: true,
      email: 'random@rand.com',
      id: 'myID',
    );
    _user = newUser;
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) {
    throw UnimplementedError();
  }
}
