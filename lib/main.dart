import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickWork/core/constants/colors.dart';
import 'package:quickWork/firebase_options.dart';
import 'package:quickWork/presentations/cubit/auth/current-customer/current_customer_cubit.dart';
import 'package:quickWork/presentations/cubit/auth/signin/sigin_cubit.dart';
import 'package:quickWork/presentations/cubit/auth/trigger-otp/trigger_otp_cubit.dart';
import 'package:quickWork/presentations/cubit/technicians/approve-technician/approve_technician_cubit.dart';
import 'package:quickWork/presentations/cubit/technicians/delete-Technician/delete_technician_cubit.dart';
import 'package:quickWork/presentations/cubit/technicians/get-technicians-list/get_technicians_list_cubit.dart';
import 'package:quickWork/presentations/cubit/technicians/raise-technician-request/RaiseTechnicianRequestCubit.dart';
import 'package:quickWork/presentations/cubit/work-category/delete-work-category/delete_work_category_cubit.dart';
import 'package:quickWork/presentations/cubit/work-category/get-work-categories/get_work_categories_cubit.dart';
import 'package:quickWork/presentations/cubit/work-category/post-work/post_work_type_cubit.dart';
import 'package:quickWork/presentations/cubit/work-request/post-work-request/work_request_cubit.dart';
import 'package:quickWork/presentations/cubit/work-request/work-requests-list/get_work_requests_list_cubit.dart';
import 'package:quickWork/presentations/screens/auth/splash-screen/splashScreen.dart';
import 'core/constants/app_sizes.dart';
import 'core/network/injection.dart' as di;

@pragma('vm:entry-point')
// Firebase Background Message Handler
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully");
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  } catch (e) {
    print("Firebase initialization error: $e");
  }
  di.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => di.sl<LocationCubit>()),
        BlocProvider(create: (_) => di.sl<TriggerOtpCubit>()),
        BlocProvider(create: (_) => di.sl<SignInCubit>()),
        BlocProvider(create: (_) => di.sl<CurrentCustomerCubit>()),
        BlocProvider(create: (_) => di.sl<PostWorkTypeCubit>()),
        BlocProvider(create: (_) => di.sl<GetWorkCategoriesCubit>()),
        BlocProvider(create: (_) => di.sl<DeleteWorkCategoryCubit>()),
        BlocProvider(create: (_) => di.sl<WorkRequestCubit>()),
        BlocProvider(create: (_) => di.sl<RaiseTechnicianRequestCubit>()),
        BlocProvider(create: (_) => di.sl<DeleteTechnicianCubit>()),
        BlocProvider(create: (_) => di.sl<ApproveTechnicianCubit>()),
        BlocProvider(create: (_) => di.sl<GetTechniciansListCubit>()),
        BlocProvider(create: (_) => di.sl<GetWorkRequestsListCubit>()),
      ],
      child: QuickWorkApp(),
    ),
  );
}

class QuickWorkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppSizes.init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quick Work',
      theme: ThemeData(
        primaryColor: AppColor.primaryColor1,
        scaffoldBackgroundColor: AppColor.white,
      ),
      home: SplashScreen(),
    );
  }
}
