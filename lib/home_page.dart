import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_firebase/model/pushnotification_model.dart';
import 'package:push_notification_firebase/notification_badge.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _totalNotificationCounter = 0;
    super.initState();
  }

  //initializing FirebaseMessaging
  late final FirebaseMessaging _messaging;
  late int _totalNotificationCounter;

  //calling model
  PushNotification? _notificationInfo;

  //register Notification
  void registerNotification() async {
    //creating instance of firebase messaging
    _messaging = FirebaseMessaging.instance;

    //generated the permissions
    NotificationSettings _settings = await _messaging.requestPermission(
        alert: true, sound: true, badge: true, provisional: true);

    //check if user has granted the particular permission
    if (_settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User Granted Permission");

      //main message would be send from here
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        //Remote message is message from firebase server

        //saved the message to model
        PushNotification notification = PushNotification(
          title: message.notification!.title.toString(),
          body: message.notification!.body.toString(),
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );

        setState(() {
          _notificationInfo = notification;
          _totalNotificationCounter++;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Push Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Flutter Push Notification',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            NotificationBadge(totalNotification: _totalNotificationCounter),
          ],
        ),
      ),
    );
  }
}
