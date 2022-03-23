import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_firebase/model/pushnotification_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //initializing FirebaseMessaging
  late final FirebaseMessaging _messaging;
  late int _totalNotificationCounter;

  //calling model
  PushNotification? _notificationInfo;

  //register Notification
  void registerNotification() async {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
