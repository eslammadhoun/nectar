import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nectar/V2/Core/utils/network_connection/overlay_service.dart';

class NetworkViewModel extends ChangeNotifier {
  bool _isConnected = true;
  bool get isConnected => _isConnected;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  StreamSubscription<InternetConnectionStatus>? _internetSubscription;

  NetworkViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _updateConnectionStatus(
      await InternetConnectionChecker().hasConnection,
      forceNotify: true,
    );
    _monitorConnection();
  }

  void _monitorConnection() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      _,
    ) async {
      final connection = await InternetConnectionChecker().hasConnection;
      await _updateConnectionStatus(connection);
    });

    _internetSubscription = InternetConnectionChecker().onStatusChange.listen((
      status,
    ) async {
      await _updateConnectionStatus(
        status == InternetConnectionStatus.connected,
      );
    });
  }

  Future<void> _updateConnectionStatus(
    bool connection, {
    bool forceNotify = false,
  }) async {
    final changed = _isConnected != connection;
    _isConnected = connection;

    if (changed || forceNotify) {
      notifyListeners();
    }

    if (_isConnected) {
      OverlayService.hide();
    } else {
      OverlayService.show();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _internetSubscription?.cancel();
    super.dispose();
  }
}
