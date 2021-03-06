import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notify/model/push_notification.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(MyApp());
}

PushNotification _notificationInfo;
int _totalNotifications;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Notify',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

Future<dynamic> _firebaseMessagingBackgroundHandler(
  Map<String, dynamic> message,
) async {
  // Initialize the Firebase app
  // await Firebase.initializeApp();
  print('onBackgroundMessage received: $message');
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // FirebaseMessaging _messaging = FirebaseMessaging();

  // void registerNotification() async {
  //   // Initialize the Firebase app
  //   // await Firebase.initializeApp();

  //   // On iOS, this helps to take the user permissions
  //  // await _messaging.requestNotificationPermissions(
  //   //   IosNotificationSettings(
  //   //     alert: true,
  //   //     badge: true,
  //   //     provisional: false,
  //   //     sound: true,
  //   //   ),
  //   // );

  //   // For handling the received notifications
  //  // _messaging.configure(
  //     // onMessage: (message) async {
  //     //   print('onMessage received: $message');

  //     //   PushNotification notification = PushNotification.fromJson(message);

  //     //   setState(() {
  //     //     _notificationInfo = notification;
  //     //     _totalNotifications++;
  //     //   });

  //       // For displaying the notification as an overlay
  //       showSimpleNotification(Text("Приветики!!!"),
  //           leading: NotificationBadge(totalNotifications: _totalNotifications),
  //           subtitle: Text(_notificationInfo.body),
  //           background: Colors.cyan[700],
  //           duration: Duration(seconds: 2),
  //           position: NotificationPosition.bottom);
  //     },
  //     onBackgroundMessage: _firebaseMessagingBackgroundHandler,
  //     onLaunch: (message) async {
  //       print('onLaunch: $message');

  //       PushNotification notification = PushNotification.fromJson(message);

  //       setState(() {
  //         _notificationInfo = notification;
  //         _totalNotifications++;
  //       });
  //     },
  //     onResume: (message) async {
  //       print('onResume: $message');

  //       PushNotification notification = PushNotification.fromJson(message);

  //       setState(() {
  //         _notificationInfo = notification;
  //         _totalNotifications++;
  //       });
  //     },
  //   );

  //   // Used to get the current FCM token
  //   _messaging.getToken().then((token) {
  //     print('Token: $token');
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  @override
  void initState() {
    _totalNotifications = 0;
    // registerNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notify'),
        brightness: Brightness.dark,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'App for capturing Firebase Push Notifications',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 16.0),
          NotificationBadge(totalNotifications: _totalNotifications),
          SizedBox(height: 16.0),
          _notificationInfo != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TITLE: ${_notificationInfo.title ?? _notificationInfo.dataTitle}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'BODY: ${_notificationInfo.body ?? _notificationInfo.dataBody}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

  const NotificationBadge({@required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: new BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$totalNotifications',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
