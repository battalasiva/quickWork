import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchPhoneCall(String phoneNumber) async {
  print("Launching phone call to: $phoneNumber");
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
}

String removeUnderscores(String input) {
  return input.replaceAll('_', ' ');
}

final months = [
  {'name': 'January', 'index': 1},
  {'name': 'February', 'index': 2},
  {'name': 'March', 'index': 3},
  {'name': 'April', 'index': 4},
  {'name': 'May', 'index': 5},
  {'name': 'June', 'index': 6},
  {'name': 'July', 'index': 7},
  {'name': 'August', 'index': 8},
  {'name': 'September', 'index': 9},
  {'name': 'October', 'index': 10},
  {'name': 'November', 'index': 11},
  {'name': 'December', 'index': 12},
];
final List<String> monthNames = months
    .map((month) => month['name'] as String)
    .toList();

String formatDate(
  String date, {
  bool dateTime = false,
  bool forPayload = false,
}) {
  try {
    final parsedDate = DateTime.parse(date);
    if (forPayload) {
      return DateFormat('yyyy-MM-dd').format(parsedDate);
    }
    return dateTime
        ? DateFormat('dd MMM yyyy hh:mm a').format(parsedDate)
        : DateFormat('dd MMM yyyy').format(parsedDate);
  } catch (e) {
    return date;
  }
}

String getTimeDifferenceMessage(String apiDate) {
  try {
    DateTime givenDate = DateTime.parse(apiDate).toLocal();
    DateTime now = DateTime.now();
    Duration difference = now.difference(givenDate);

    if (difference.inMinutes < 60) {
      return "Few minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago";
    } else {
      return DateFormat('dd MMM yyyy').format(givenDate);
    }
  } catch (e) {
    return "NA";
  }
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

String getMonthDifference(String startDate, String endDate) {
  DateTime start = DateTime.parse(startDate);
  DateTime end = DateTime.parse(endDate);

  int yearDiff = end.year - start.year;
  int monthDiff = (yearDiff * 12) + (end.month - start.month);

  return "$monthDiff Months";
}

dynamic launchEmail() async {
  try {
    Uri email = Uri(
      scheme: 'mailto',
      path: "harishtellaputta990@gmail.com",
      queryParameters: {'subject': "Quick Work"},
    );
    await launchUrl(email);
  } catch (e) {
    debugPrint(e.toString());
  }
}

shareFunction(String message) {
  SharePlus.instance.share(ShareParams(text: message));
}

String getGreetingMessage() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}

class ServiceCategory {
  final String name;
  final IconData icon;
  final Color color;

  const ServiceCategory(this.name, this.icon, this.color);
}

class ServiceConstants {
  static const List<String> categories = [
    'ELECTRICIAN',
    'PLUMBER',
    'CLEANER',
    'REPAIRS',
    'PAINTER',
    'CARPENTER',
    'APPLIANCE',
    'PEST_CONTROL',
    'GARDENER',
    'INTERIOR_DESIGNER',
    'MASON',
    'ROOFER',
    'HVAC',
    'FLOORING',
    'GLASS_WORKER',
    'MOVER',
    'VEHICLE_SERVICE',
    'IT_SUPPORT',
    'BEAUTY_SERVICE',
    'LAUNDRY',
    'SECURITY',
    'CCTV_INSTALLER',
    'WATER_SERVICE',
    'SOLAR_INSTALLER',
    'FURNITURE_ASSEMBLER',
    'LOCKSMITH',
    'HANDYMAN',
    'HOME_AUTOMATION',
  ];

  static final Map<String, ServiceCategory> categoryMap = {
    'ELECTRICIAN': ServiceCategory(
      'Electrician',
      Icons.electrical_services,
      Color(0xFFFFE0B2),
    ),
    'PLUMBER': ServiceCategory('Plumber', Icons.plumbing, Color(0xFFCCE5FF)),
    'CLEANER': ServiceCategory(
      'Cleaner',
      Icons.cleaning_services,
      Color(0xFFE1BEE7),
    ),
    'REPAIRS': ServiceCategory('Repairs', Icons.handyman, Color(0xFFD1C4E9)),
    'PAINTER': ServiceCategory(
      'Painter',
      Icons.format_paint,
      Color(0xFFFFF9C4),
    ),
    'CARPENTER': ServiceCategory(
      'Carpenter',
      Icons.carpenter,
      Color(0xFFFFCDD2),
    ),
    'APPLIANCE': ServiceCategory(
      'Appliance Repair',
      Icons.build_circle,
      Color(0xFFFFF3E0),
    ),
    'PEST_CONTROL': ServiceCategory(
      'Pest Control',
      Icons.bug_report,
      Color(0xFFFFCDD2),
    ),
    'GARDENER': ServiceCategory('Gardener', Icons.grass, Color(0xFFA5D6A7)),
    'INTERIOR_DESIGNER': ServiceCategory(
      'Interior Designer',
      Icons.chair,
      Color(0xFFF8BBD0),
    ),
    'MASON': ServiceCategory('Mason', Icons.construction, Color(0xFFD7CCC8)),
    'ROOFER': ServiceCategory('Roofer', Icons.roofing, Color(0xFFB0BEC5)),
    'HVAC': ServiceCategory('AC Repair', Icons.ac_unit, Color(0xFFB2EBF2)),
    'FLOORING': ServiceCategory('Flooring', Icons.layers, Color(0xFFDCEDC8)),
    'GLASS_WORKER': ServiceCategory(
      'Glass Work',
      Icons.window,
      Color(0xFFE0F2F1),
    ),
    'MOVER': ServiceCategory(
      'Movers & Packers',
      Icons.local_shipping,
      Color(0xFFB3E5FC),
    ),
    'VEHICLE_SERVICE': ServiceCategory(
      'Vehicle Service',
      Icons.car_repair,
      Color(0xFFFFE0B2),
    ),
    'IT_SUPPORT': ServiceCategory(
      'IT Support',
      Icons.computer,
      Color(0xFFE1BEE7),
    ),
    'BEAUTY_SERVICE': ServiceCategory(
      'Beauty Service',
      Icons.face,
      Color(0xFFF8BBD0),
    ),
    'LAUNDRY': ServiceCategory(
      'Laundry',
      Icons.local_laundry_service,
      Color(0xFFC8E6C9),
    ),
    'SECURITY': ServiceCategory('Security', Icons.security, Color(0xFFFFCDD2)),
    'CCTV_INSTALLER': ServiceCategory(
      'CCTV Installation',
      Icons.videocam,
      Color(0xFFD1C4E9),
    ),
    'WATER_SERVICE': ServiceCategory(
      'Water Service',
      Icons.water_drop,
      Color(0xFFB2EBF2),
    ),
    'SOLAR_INSTALLER': ServiceCategory(
      'Solar Installation',
      Icons.solar_power,
      Color(0xFFFFF9C4),
    ),
    'FURNITURE_ASSEMBLER': ServiceCategory(
      'Furniture Assembly',
      Icons.chair_alt,
      Color(0xFFDCEDC8),
    ),
    'LOCKSMITH': ServiceCategory('Locksmith', Icons.lock, Color(0xFFB0BEC5)),
    'HANDYMAN': ServiceCategory('Handyman', Icons.handyman, Color(0xFFD1C4E9)),
    'HOME_AUTOMATION': ServiceCategory(
      'Home Automation',
      Icons.home_outlined,
      Color(0xFFE0F2F1),
    ),
  };

  static ServiceCategory getCategoryDetails(String category) {
    return categoryMap[category] ??
        ServiceCategory('Other', Icons.work, Color(0xFFE0E0E0));
  }

  static IconData getCategoryIcon(String category) {
    return getCategoryDetails(category).icon;
  }

  static Color getCategoryColor(String category) {
    return getCategoryDetails(category).color;
  }

  static String getCategoryName(String category) {
    return getCategoryDetails(category).name;
  }
}
