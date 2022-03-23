import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  final int totalNotification;
  const NotificationBadge({Key? key, required this.totalNotification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration:
          const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            "$totalNotification",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
