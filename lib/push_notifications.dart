import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class PushNotification_ extends StatefulWidget {
  const PushNotification_({super.key});

  @override
  State<PushNotification_> createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification_> {
  @override
  void initState() {
    // TODO: implement initState
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  triggerNotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'MAD Project',
            body: 'Hey! I\'m a push notification'));
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
    child:ElevatedButton(

      onPressed: triggerNotification,
      child: const Text("Trigger Notification"),
      style: const ButtonStyle(

        backgroundColor:
            MaterialStatePropertyAll<Color>(Colors.teal),
      ),
    ),
    );
  }
}
