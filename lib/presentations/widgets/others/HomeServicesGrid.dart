import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickWork/core/constants/app_sizes.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/presentations/screens/users/workPostingScreen.dart';

class HomeServicesGrid extends StatelessWidget {
  const HomeServicesGrid({super.key});

  final List<_ServiceItem> services = const [
    _ServiceItem('Plumbing', Icons.plumbing, Color(0xFFCCE5FF)),
    _ServiceItem('Electrician', Icons.electrical_services, Color(0xFFFFE0B2)),
    _ServiceItem('Cleaning', Icons.cleaning_services, Color(0xFFE1BEE7)),
    _ServiceItem('Carpentry', Icons.handyman, Color(0xFFD1C4E9)),
    _ServiceItem('Painting', Icons.format_paint, Color(0xFFFFF9C4)),
    _ServiceItem('Pest Control', Icons.bug_report, Color(0xFFFFCDD2)),
    _ServiceItem('AC Repair', Icons.ac_unit, Color(0xFFB2EBF2)),
    _ServiceItem('Appliance Repair', Icons.build_circle, Color(0xFFFFF3E0)),
    _ServiceItem('Laundry', Icons.local_laundry_service, Color(0xFFC8E6C9)),
    _ServiceItem('Gardening', Icons.grass, Color(0xFFA5D6A7)),
    _ServiceItem('Interior Design', Icons.chair, Color(0xFFF8BBD0)),
    _ServiceItem('Movers & Packers', Icons.local_shipping, Color(0xFFB3E5FC)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.width(16),
            vertical: AppSizes.height(12),
          ),
          child: Text(
            'Available Services',
            style: TextStyle(
              fontSize: AppSizes.font(18),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        ListView.builder(
          itemCount: services.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: AppSizes.width(12)),
          itemBuilder: (context, index) {
            final service = services[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.height(4)),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Workpostingscreen()),
                  );
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSizes.width(16),
                  vertical: AppSizes.height(8),
                ),
                leading: Container(
                  width: AppSizes.width(50),
                  height: AppSizes.height(50),
                  decoration: BoxDecoration(
                    color: service.bgColor,
                    borderRadius: BorderRadius.circular(AppSizes.radius(12)),
                  ),
                  child: Icon(
                    service.icon,
                    size: AppSizes.iconSize(24),
                    color: Colors.black87,
                  ),
                ),
                title: Text(
                  service.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: AppSizes.font(16),
                    color: Colors.black87,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: AppSizes.iconSize(16),
                  color: AppColor.primaryColor1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radius(12)),
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: AppSizes.width(1),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ServiceItem {
  final String title;
  final IconData icon;
  final Color bgColor;

  const _ServiceItem(this.title, this.icon, this.bgColor);
}
