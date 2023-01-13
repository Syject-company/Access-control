import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMS {
  FirebaseMessaging? _messaging;

  Future<void> init() async {
    await Firebase.initializeApp().then((FirebaseApp firebase) {
      if (firebase != null) {
        _messaging = FirebaseMessaging.instance;
      }
    });
  }

  Future<String?> get token async => _messaging?.getToken();

  Future<RemoteMessage?> get fcmDataTerminated async =>
      await _messaging?.getInitialMessage();

  Stream<RemoteMessage> get fcmDataBackground =>
      FirebaseMessaging.onMessageOpenedApp;
}
