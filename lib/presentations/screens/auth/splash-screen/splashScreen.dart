import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quickWork/core/constants/image_const.dart';
import 'package:quickWork/core/constants/text_keys.dart';
import 'package:quickWork/core/utils/local-storage/Shared_prefs.dart';
import 'package:quickWork/core/utils/push-notifications/PushNotificationServices.dart';
import 'package:quickWork/presentations/screens/auth/login/login.dart';
import 'package:quickWork/presentations/widgets/elements/BottomTabBase.dart';
import 'package:in_app_update/in_app_update.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;
  // NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    checkTokenAndNavigate();
    permissions();
    Future.delayed(const Duration(seconds: 2), () {
      checkForUpdate();
    });
  }

  permissions() async {
    // await Geolocator.requestPermission();
    // await notificationServices.requestNotificationPermissions();
  }

  void proceedWithAppFlow() {}

  Future<void> checkTokenAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));
    token = await SharedPrefsHelper.getString(AppKeys.authKey);
    // generateToken();
    print('Token: $token');

    if (token == null || token!.isEmpty) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => BottomTabNavigator()),
      );
    }
  }

  // Future<void> generateToken() async {
  //   await notificationServices.forgroundMessage();
  //   await notificationServices.firebaseInit(context);
  //   await notificationServices.setupInteractMessage(context);
  //   await notificationServices.isRefreshToken();
  //   String? token = await notificationServices.getDeviceToken();
  //   if (mounted && token != null) {
  //     print('FCM Token: $token');
  //     // fcmToken = token;
  //     // Future.microtask(() => sendFcmToken());
  //   }
  // }

  Future<void> checkForUpdate() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        showUpdateDialog(updateInfo);
      } else {
        proceedWithAppFlow();
      }
    } catch (e) {
      print("Error checking for update: $e");
      proceedWithAppFlow();
    }
  }

  void showUpdateDialog(AppUpdateInfo updateInfo) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Available'),
          content: Text(
            'A new version of the app is available. Please update to continue.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Future.delayed(const Duration(hours: 2), () {
                  showUpdateDialog(updateInfo);
                });
              },
              child: Text('Remind Me Later'),
            ),
            TextButton(
              onPressed: () {
                InAppUpdate.performImmediateUpdate()
                    .then((_) {
                      proceedWithAppFlow();
                    })
                    .catchError((e) {
                      print("Error performing update: $e");
                      proceedWithAppFlow();
                    });
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(child: Image.asset(meatspotlogo, fit: BoxFit.cover)),
        ],
      ),
    );
  }
}
