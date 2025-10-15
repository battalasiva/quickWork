import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/core/common/commonMethods.dart';
import 'package:quickWork/core/common/elements/AppLoaderWidget.dart';
import 'package:quickWork/core/common/elements/top_bar.dart';
import 'package:quickWork/presentations/cubit/work-request/work-requests-list/get_work_requests_list_cubit.dart';
import 'package:quickWork/presentations/cubit/work-request/work-requests-list/get_work_requests_list_state.dart';

class WorksHistory extends StatefulWidget {
  const WorksHistory({super.key});

  @override
  State<WorksHistory> createState() => _WorksHistoryState();
}

class _WorksHistoryState extends State<WorksHistory> {
  @override
  void initState() {
    super.initState();
    context.read<GetWorkRequestsListCubit>().fetchWorkRequests(context);
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "completed":
        return Colors.green;
      case "in progress":
        return Colors.blue;
      case "cancelled":
        return Colors.red;
      case "pending":
      case "pending_admin_review":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Work History'),
      body: BlocBuilder<GetWorkRequestsListCubit, GetWorkRequestsListState>(
        builder: (context, state) {
          if (state is GetWorkRequestsListLoading) {
            return const Center(child: AppLoader());
          } else if (state is GetWorkRequestsListError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is GetWorkRequestsListLoaded) {
            final workRequests = state.workRequests;

            if (workRequests.isEmpty) {
              return const Center(child: Text("No work requests found"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: workRequests.length,
              itemBuilder: (context, index) {
                final work = workRequests[index];

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
                        // Title Row (status)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Request #${work.id}",
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
                                  work.status ?? "",
                                ).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                work.status ?? "",
                                style: TextStyle(
                                  color: _getStatusColor(work.status ?? ""),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        // Created At
                        if (work.createdAt != null)
                          Text(
                            'Created On : ${formatDate(work.createdAt.toString())}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),

                        const SizedBox(height: 8),

                        // Description
                        Text(
                          work.description ?? "",
                          style: const TextStyle(fontSize: 14),
                        ),

                        const SizedBox(height: 8),

                        // WorkTypes chips
                        if (work.workTypes != null &&
                            work.workTypes!.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            children: work.workTypes!
                                .map(
                                  (type) => Chip(
                                    label: Text(type),
                                    backgroundColor: Colors.blue.withOpacity(
                                      0.1,
                                    ),
                                    labelStyle: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
