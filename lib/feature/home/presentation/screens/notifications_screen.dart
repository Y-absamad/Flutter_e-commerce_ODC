import 'package:flutter/material.dart';

import '../../data/model/notification_model.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final List<NotificationModel> notifications = [
    NotificationModel(
      icon: Icons.local_offer,
      title: '30% Special Discount!',
      subtitle: 'Special promotion only valid today',
    ),
    NotificationModel(
      icon: Icons.apple,
      title: 'New Apple Promotion',
      subtitle: 'Special promo to all apple device',
    ),
    NotificationModel(
      icon: Icons.local_offer,
      title: 'Special Offer! 40% Off',
      subtitle: 'Special offer for new account, valid until 20 Nov 2022',
    ),
    NotificationModel(
      icon: Icons.local_offer,
      title: 'Special Offer! 50% Off',
      subtitle: 'Special offer for new account, valid until 20 Nov 2022',
    ),
    NotificationModel(
      icon: Icons.credit_card,
      title: 'Credit Card Connected',
      subtitle: 'Special promotion only valid today',
    ),
    NotificationModel(
      icon: Icons.account_box,
      title: 'Account Setup Successful!',
      subtitle: 'Special promotion only valid today',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Notification",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 20),
            Text('Today'),
            notificationTile(notifications[0]),
            notificationTile(notifications[1]),
            SizedBox(height: 10),
            Text('Yesterday'),
            notificationTile(notifications[2]),
            notificationTile(notifications[3]),
            notificationTile(notifications[4]),
            notificationTile(notifications[5]),
          ],
        ),
      ),
    );
  }
}

Widget notificationTile(NotificationModel notification) {
  return Column(
    children: [
      ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(notification.icon, color: Colors.red),
        ),
        title: Text(
          notification.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          notification.subtitle,
          style: const TextStyle(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
      ),
      const Divider(thickness: 0.5),
    ],
  );
}
