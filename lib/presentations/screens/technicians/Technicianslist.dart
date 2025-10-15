import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/core/common/elements/AppLoaderWidget.dart';
import 'package:quickWork/core/common/elements/top_bar.dart';
import 'package:quickWork/core/constants/app_sizes.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/data/model/technicians/GetTechniciansListModel.dart';
import 'package:quickWork/presentations/cubit/technicians/get-technicians-list/get_technicians_list_cubit.dart';
import 'package:quickWork/presentations/cubit/technicians/get-technicians-list/get_technicians_list_state.dart';
import 'package:quickWork/presentations/cubit/technicians/approve-technician/approve_technician_cubit.dart';
import 'package:quickWork/presentations/cubit/technicians/approve-technician/approve_technician_state.dart';
import 'package:quickWork/presentations/cubit/technicians/delete-technician/delete_technician_cubit.dart';
import 'package:quickWork/presentations/cubit/technicians/delete-technician/delete_technician_state.dart';

class Technicianslist extends StatefulWidget {
  const Technicianslist({super.key});

  @override
  State<Technicianslist> createState() => _TechnicianslistState();
}

class _TechnicianslistState extends State<Technicianslist> {
  int? approvingId;
  int? deletingId;

  @override
  void initState() {
    super.initState();
    context.read<GetTechniciansListCubit>().fetchTechnicians(context);
  }

  void _approveTechnician(BuildContext context, int id) async {
    setState(() => approvingId = id);

    final cubit = context.read<ApproveTechnicianCubit>();
    await cubit.approveTechnician(context, id);

    if (mounted) {
      setState(() => approvingId = null);
      // ✅ Refresh list
      context.read<GetTechniciansListCubit>().fetchTechnicians(context);
    }
  }

  void _deleteTechnician(BuildContext context, int id) async {
    setState(() => deletingId = id);

    final cubit = context.read<DeleteTechnicianCubit>();
    await cubit.deleteTechnician(context, id);

    if (mounted) {
      setState(() => deletingId = null);
      // ✅ Refresh list
      context.read<GetTechniciansListCubit>().fetchTechnicians(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: 'Technicians List'),
      body: BlocBuilder<GetTechniciansListCubit, GetTechniciansListState>(
        builder: (context, state) {
          if (state is GetTechniciansListLoading) {
            return const Center(child: AppLoader());
          } else if (state is GetTechniciansListError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (state is GetTechniciansListSuccess) {
            if (state.technicians.isEmpty) {
              return const Center(child: Text("No technicians found"));
            }

            return ListView.separated(
              padding: EdgeInsets.all(AppSizes.width(16)),
              itemCount: state.technicians.length,
              separatorBuilder: (_, __) => AppSizes.vSpace(12),
              itemBuilder: (context, index) {
                final technician = state.technicians[index];
                final isApproving = approvingId == technician.technicianId;
                final isDeleting = deletingId == technician.technicianId;

                return _buildTechnicianCard(
                  context,
                  technician,
                  isApproving,
                  isDeleting,
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTechnicianCard(
    BuildContext context,
    GetTechniciansListModel technician,
    bool isApproving,
    bool isDeleting,
  ) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.radius(12)),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.width(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name + Status or ✅ tick
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      technician.fullName ?? "NA",
                      style: TextStyle(
                        fontSize: AppSizes.font(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (technician.status == "APPROVED") ...[
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 18,
                      ),
                    ],
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.width(10),
                    vertical: AppSizes.height(4),
                  ),
                  decoration: BoxDecoration(
                    color: technician.status == "APPROVED"
                        ? Colors.green.withOpacity(0.2)
                        : Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    technician.status ?? "Pending",
                    style: TextStyle(
                      color: technician.status == "APPROVED"
                          ? Colors.green
                          : Colors.orange,
                      fontSize: AppSizes.font(12),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            AppSizes.vSpace(8),

            // Phone + City
            Row(
              children: [
                const Icon(Icons.phone, size: 16, color: Colors.grey),
                SizedBox(width: AppSizes.width(6)),
                Text(technician.phone ?? "NA"),
              ],
            ),
            AppSizes.vSpace(4),
            Text(
              "${technician.city ?? 'NA'}, ${technician.state ?? 'NA'} - ${technician.postalCode ?? 'NA'}",
              style: TextStyle(
                fontSize: AppSizes.font(13),
                color: Colors.grey[700],
              ),
            ),
            AppSizes.vSpace(8),

            // Work types
            if (technician.workTypes != null &&
                technician.workTypes!.isNotEmpty)
              Wrap(
                spacing: 6,
                children: technician.workTypes!
                    .map(
                      (type) => Chip(
                        label: Text(type),
                        backgroundColor: AppColor.primaryColor1.withOpacity(
                          0.1,
                        ),
                        labelStyle: TextStyle(
                          color: AppColor.primaryColor1,
                          fontSize: AppSizes.font(12),
                        ),
                      ),
                    )
                    .toList(),
              ),

            // Action buttons
            if (technician.status != "APPROVED")
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Approve
                  isApproving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.green,
                          ),
                          onPressed: () => _approveTechnician(
                            context,
                            technician.technicianId!,
                          ),
                          icon: const Icon(Icons.check_circle, size: 18),
                          label: const Text("Approve"),
                        ),
                  SizedBox(width: AppSizes.width(10)),

                  // Delete
                  isDeleting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          onPressed: () => _deleteTechnician(
                            context,
                            technician.technicianId!,
                          ),
                          icon: const Icon(Icons.delete, size: 18),
                          label: const Text("Delete"),
                        ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
