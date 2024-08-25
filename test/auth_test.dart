import 'package:flutter_application_2/services/auth/auth_exceptions.dart';
import 'package:flutter_application_2/services/auth/auth_provider.dart';
import 'package:flutter_application_2/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('Should not be initialized in start', () {
      expect(provider.isInitialzed, false);
    });
    test('cant logout if not logged in', () {
      expect(provider.logOut(),
          throwsA(const TypeMatcher<NotInitializedException>()));
    });
    test('should be able to initialze', () async {
      await provider.intialize();
      expect(provider.isInitialzed, true);
    });
    test('user should be null after initialization', () {
      expect(provider.currentUser, null);
    });
    test('should be able to initialze in 2 seconds', () async {
      await provider.intialize();
      expect(provider.isInitialzed, true);
    }, timeout: const Timeout(Duration(seconds: 2)));
    test('create user should delgate to login function', () async {
      final badEmailUser = provider.createUser(
        email: 'asd@g.com',
        password: 'password',
      );
      expect(badEmailUser,
          throwsA(const TypeMatcher<UserNotFoundAuthException>()));
      final badPassUser =
          provider.createUser(email: 'any@g.com', password: 'fofofo');
      expect(badPassUser,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()));

      final user = await provider.createUser(
        email: 'sadff',
        password: 'adf',
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('logged in user should be able to get verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });
    test(
      'should be able to logout and login again',
      () async {
        await provider.logOut();
        await provider.login(email: 'email', password: 'password');
        final user = provider.currentUser;
        expect(user, isNotNull);
      },
    );
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialzed => _isInitialized;
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!_isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return login(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> intialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<void> logOut() async {
    if (!_isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) {
    if (!_isInitialized) throw NotInitializedException();
    if (email == 'asd@g.com') throw UserNotFoundAuthException();
    if (password == 'fofofo') throw WrongPasswordAuthException();

    const user = AuthUser(
      id: 'my_id',
      isEmailVerified: false,
      email: 'asd@g.com',
    );
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!_isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(
      isEmailVerified: true,
      email: 'asd@g.com',
      id: 'my_id',
    );
    _user = newUser;
  }
}
