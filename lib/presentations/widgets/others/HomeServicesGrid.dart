import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return GridView.builder(
      itemCount: services.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final service = services[index];
        return Container(
          decoration: BoxDecoration(
            color: service.bgColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(service.icon, size: 28, color: Colors.black87),
              ),
              const SizedBox(height: 12),
              Text(
                service.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ServiceItem {
  final String title;
  final IconData icon;
  final Color bgColor;

  const _ServiceItem(this.title, this.icon, this.bgColor);
}
