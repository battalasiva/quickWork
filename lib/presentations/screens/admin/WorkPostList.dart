import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickWork/core/common/elements/top_bar.dart';

class WorkpostList extends StatefulWidget {
  const WorkpostList({super.key});

  @override
  State<WorkpostList> createState() => _WorkpostListState();
}

class _WorkpostListState extends State<WorkpostList> {
  // Dummy data
  final List<Map<String, String>> postedWorks = [
    {
      "title": "Plumbing Work",
      "description": "Fix kitchen sink leakage",
      "workType": "Maintenance",
      "date": "2025-08-13",
      "status": "Pending",
    },
    {
      "title": "Electrical Work",
      "description": "Install ceiling fan in living room",
      "workType": "Installation",
      "date": "2025-08-10",
      "status": "Completed",
    },
    {
      "title": "Painting Work",
      "description": "Repaint bedroom walls",
      "workType": "Renovation",
      "date": "2025-08-15",
      "status": "In Progress",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;
      case "completed":
        return Colors.green;
      case "in progress":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Posted Works'),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: postedWorks.length,
        itemBuilder: (context, index) {
          final work = postedWorks[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              title: Text(
                work["title"] ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(work["description"] ?? ""),
                  const SizedBox(height: 6),
                  Text("Work Type: ${work["workType"]}"),
                  const SizedBox(height: 4),
                  Text(
                    "Date: ${DateFormat('dd MMM yyyy').format(DateTime.parse(work["date"]!))}",
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Status: ",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        work["status"] ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(work["status"] ?? ""),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () {
                  // Call action here
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
