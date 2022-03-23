import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
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
    registerNotification();
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
    await Firebase.initializeApp();
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
          title: message.notification!.title,
          body: message.notification!.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );

        setState(() {
          _notificationInfo = notification;
          _totalNotificationCounter++;
        });
        print("hello");
        print(notification.body);
        //if notification received from firebase is not null then go for overlay support
        showSimpleNotification(Text("${_notificationInfo!.title}"),
            leading:
                NotificationBadge(totalNotification: _totalNotificationCounter),
            subtitle: Text("${_notificationInfo!.body}"),
            background: Colors.cyan.shade700,
            duration: const Duration(seconds: 10));
      });
    } else {
      print("Permission Declined");
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
            const SizedBox(
              height: 10,
            ),

            //we will be counting the notification we receive via badge
            NotificationBadge(totalNotification: _totalNotificationCounter),

            _notificationInfo != null
                ? Column(
                    children: [
                      Text(
                        "TITLE : ${_notificationInfo!.title}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "TITLE : ${_notificationInfo!.body}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
