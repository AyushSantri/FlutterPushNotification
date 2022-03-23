import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //initializing FirebaseMessaging
  late final FirebaseMessaging _messaging;
  late int _totalNotificationCounter;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
