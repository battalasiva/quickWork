import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickWork/core/common/elements/top_bar.dart';

class WorksHistory extends StatefulWidget {
  const WorksHistory({super.key});

  @override
  State<WorksHistory> createState() => _WorksHistoryState();
}

class _WorksHistoryState extends State<WorksHistory> {
  // Dummy work history data
  final List<Map<String, String>> workHistory = [
    {
      "title": "AC Service",
      "description": "General service and filter cleaning",
      "workType": "Maintenance",
      "date": "2025-07-28",
      "status": "Completed",
    },
    {
      "title": "Plumbing Work",
      "description": "Fix bathroom tap leakage",
      "workType": "Repair",
      "date": "2025-07-22",
      "status": "In Progress",
    },
    {
      "title": "Painting Job",
      "description": "Paint the kitchen walls",
      "workType": "Renovation",
      "date": "2025-07-15",
      "status": "Cancelled",
    },
    {
      "title": "Electrical Work",
      "description": "Install new LED lights in hall",
      "workType": "Installation",
      "date": "2025-07-05",
      "status": "Completed",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return Colors.green;
      case "in progress":
        return Colors.blue;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Work History'),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: workHistory.length,
        itemBuilder: (context, index) {
          final work = workHistory[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        work["title"] ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(
                            work["status"] ?? "",
                          ).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          work["status"] ?? "",
                          style: TextStyle(
                            color: _getStatusColor(work["status"] ?? ""),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    work["description"] ?? "",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Work Type: ${work["workType"]}",
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Date: ${DateFormat('dd MMM yyyy').format(DateTime.parse(work["date"]!))}",
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
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
