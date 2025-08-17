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

// class YearDropdown extends StatelessWidget {
//   final List<String> years;
//   final String? selectedYear;
//   final Function(String?) onChanged;

//   const YearDropdown({
//     super.key,
//     required this.years,
//     required this.selectedYear,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BuildDropDownField(
//       label: 'Year',
//       items: years,
//       onChanged: onChanged,
//       value: selectedYear,
//     );
//   }
// }

// class MonthDropdown extends StatelessWidget {
//   final List<Map<String, dynamic>> months;
//   final String? selectedMonth;
//   final ValueChanged<int?> onChanged;

//   const MonthDropdown({
//     super.key,
//     required this.months,
//     required this.selectedMonth,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final monthNames = months.map((month) => month['name'] as String).toList();

//     return BuildDropDownField(
//       label: 'Month',
//       items: monthNames,
//       onChanged: (value) {
//         final selectedMonthData =
//             months.firstWhere((month) => month['name'] == value);
//         onChanged(selectedMonthData['index']);
//       },
//       value: selectedMonth,
//     );
//   }
// }
String getTeluguCategoryName(String category) {
  switch (category) {
    case 'Small Boiler':
      return 'చిన్న బ్రాయిలర్';
    case 'Big Boiler':
      return 'పెద్ద బ్రాయిలర్';
    case 'Natu Boiler':
      return 'నాటు బ్రాయిలర్';
    case 'Country Chicken':
      return 'దేశీ కోడి';
    case 'Skinless':
      return 'తీవ్రమైన కోడి (చర్మం లేని)';
    default:
      return category;
  }
}

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
