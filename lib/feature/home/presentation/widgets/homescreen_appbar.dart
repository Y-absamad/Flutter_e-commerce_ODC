
import 'package:flutter/material.dart';

import '../screens/notifications_screen.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    shadowColor: Color(0xFFFD6C8A),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFD6C8A), Color.fromARGB(255, 236, 231, 230)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    title: Row(
      children: [
        Icon(Icons.location_on, color: Colors.white, size: 20),
        SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Text(
              "Condong Catur",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.white, size: 24),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsScreen()));
          },
        ),
        SizedBox(width: 16),
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg",
          ),
        ),
      ],
    ),
  );
}