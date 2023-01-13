import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:safe_access/features/presentation/resources/strings_res.dart';

class Storage {
  late final FlutterSecureStorage _storage;

  void init() {
    _storage = const FlutterSecureStorage();
  }

  Future<String?> getHeaderCookies() => _storage.read(key: _headerCookies);

  Future<void> setHeaderCookies(String value) async {
    print('Login Cookies: $value');
    await _storage.write(key: _headerCookies, value: value);
  }

  Future<bool> getIsLoggedIn() async {
    final String? isLogged = await _storage.read(key: _isLoggedIn);
    return isLogged != null && isLogged == StringsRes.isLoggedIn;
  }

  Future<void> setIsLoggedIn(String value) async {
    await _storage.write(key: _isLoggedIn, value: value);
  }

  Future<String?> getWorkerLastSelectedProject() =>
      _storage.read(key: _workerLastSelectedProject);

  Future<void> setWorkerLastSelectedProject(String value) async {
    await _storage.write(key: _workerLastSelectedProject, value: value);
  }

  Future<String?> getWorkerLastSelectedProjectSearch() =>
      _storage.read(key: _workerLastSelectedProjectSearch);

  Future<void> setWorkerLastSelectedProjectSearch(String value) async {
    await _storage.write(key: _workerLastSelectedProjectSearch, value: value);
  }

  Future<String> getFCMMessageID() async {
    return await _storage.read(key: _fCMMessageID) ?? 'id';
  }

  Future<void> setFCMMessageID(String value) =>
      _storage.write(key: _fCMMessageID, value: value);

  Future<String?> getEventsLastSelectedProject() =>
      _storage.read(key: _eventsLastSelectedProject);

  Future<void> setEventsLastSelectedProject(String value) async {
    await _storage.write(key: _eventsLastSelectedProject, value: value);
  }
}

String get _headerCookies => 'HeaderCookie';

String get _isLoggedIn => 'IsLoggedIn';

String get _workerLastSelectedProject => 'WorkerLastSelectedProject';

String get _workerLastSelectedProjectSearch =>
    'WorkerLastSelectedProjectSearch';

String get _fCMMessageID => 'FCMMessageID';

String get _eventsLastSelectedProject => 'EventsLastSelectedProject';
