import 'package:flutter/material.dart';
import 'package:quickWork/core/common/elements/top_bar.dart';
import 'package:quickWork/core/constants/colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, String>> notifications = [
    {
      "title": "Work Accepted",
      "message":
          "Your plumbing work request has been accepted by the service provider.",
      "time": "2025-08-13 09:15:00",
    },
    {
      "title": "Work Completed",
      "message":
          "Your AC service was completed successfully. Please rate the service.",
      "time": "2025-08-12 18:45:00",
    },
    {
      "title": "Payment Reminder",
      "message": "Your payment for the painting job is pending.",
      "time": "2025-08-10 11:30:00",
    },
    {
      "title": "New Service Available",
      "message":
          "We have added a new electrical installation service in your area.",
      "time": "2025-08-09 15:00:00",
    },
  ];

  String _formatTime(String dateTime) {
    DateTime dt = DateTime.parse(dateTime);
    return "${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Notifications'),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColor.primaryColor1,
                child: Icon(Icons.notifications, color: Colors.white),
              ),
              title: Text(
                notif["title"] ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notif["message"] ?? ""),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(notif["time"] ?? ""),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
