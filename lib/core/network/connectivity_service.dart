import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Contract for network connectivity checks.
abstract class ConnectivityService {
  bool get isOnline;
  Stream<bool> get onConnectivityChanged;
  void dispose();
}

/// Production implementation using connectivity_plus.
class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity;
  final _onlineController = StreamController<bool>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isOnline = true;

  ConnectivityServiceImpl([Connectivity? connectivity])
      : _connectivity = connectivity ?? Connectivity() {
    _init();
  }

  @override
  bool get isOnline => _isOnline;

  @override
  Stream<bool> get onConnectivityChanged => _onlineController.stream;

  void _init() {
    _subscription = _connectivity.onConnectivityChanged.listen(_updateStatus);
    _connectivity.checkConnectivity().then(_updateStatus);
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final online = results.any((r) => r != ConnectivityResult.none);
    if (_isOnline != online) {
      _isOnline = online;
      _onlineController.add(_isOnline);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _onlineController.close();
  }
}

/// Test/Offline fake implementation.
class FakeConnectivityService implements ConnectivityService {
  @override
  final bool isOnline;
  final _controller = StreamController<bool>.broadcast();

  FakeConnectivityService([this.isOnline = true]);

  @override
  Stream<bool> get onConnectivityChanged => _controller.stream;

  @override
  void dispose() {
    _controller.close();
  }
}

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityServiceImpl();
  ref.onDispose(service.dispose);
  return service;
});

final isOnlineProvider = StreamProvider<bool>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  return service.onConnectivityChanged;
});
