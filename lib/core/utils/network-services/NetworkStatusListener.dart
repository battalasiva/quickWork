import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkStatusListener extends StatefulWidget {
  final Widget child;

  const NetworkStatusListener({Key? key, required this.child}) : super(key: key);

  @override
  State<NetworkStatusListener> createState() => _NetworkStatusListenerState();
}

class _NetworkStatusListenerState extends State<NetworkStatusListener> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  bool? _isConnected;

  @override
  void initState() {
    super.initState();
    _checkInitialConnection();
    _subscription = Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _checkInitialConnection() async {
    bool hasInternet = await _hasInternet();
    setState(() {
      _isConnected = hasInternet;
    });
    _showSnackBar(hasInternet);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    bool hasInternet = await _hasInternet();
    if (_isConnected != null && _isConnected != hasInternet) {
      _showSnackBar(hasInternet);
    }
    setState(() {
      _isConnected = hasInternet;
    });
  }

  Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void _showSnackBar(bool isConnected) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          isConnected ? "Back Online" : "No Internet Connection",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: isConnected ? Colors.green : Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
