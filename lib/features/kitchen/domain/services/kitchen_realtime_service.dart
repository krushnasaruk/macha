import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../../core/network/connectivity_service.dart';
import 'kitchen_alert_service.dart';

class KitchenRealtimeService {
  final ConnectivityService _connectivity;
  final KitchenAlertNotifier _alertNotifier;
  final Future<void> Function()? _onReconcile;

  final Set<String> _processedEventIds = {};
  Timer? _reconciliationTimer;
  StreamSubscription<bool>? _connectivitySub;
  bool _isReconciling = false;

  KitchenRealtimeService({
    required ConnectivityService connectivity,
    required KitchenAlertNotifier alertNotifier,
    Future<void> Function()? onReconcile,
    Duration reconciliationInterval = const Duration(seconds: 30),
  })  : _connectivity = connectivity,
        _alertNotifier = alertNotifier,
        _onReconcile = onReconcile {
    // Listen to connectivity changes to reconnect / reconcile immediately when online
    _connectivitySub = _connectivity.onConnectivityChanged.listen((isOnline) {
      if (isOnline) {
        debugPrint('[KitchenRealtime] Network online detected - reconciling kitchen orders');
        triggerReconciliation();
      }
    });

    // Setup periodic reconciliation
    _reconciliationTimer = Timer.periodic(reconciliationInterval, (_) {
      triggerReconciliation();
    });
  }

  /// Processes an incoming realtime event with duplicate suppression.
  /// Returns `true` if processed, or `false` if suppressed as a duplicate.
  bool handleRealtimeEvent({
    required String eventId,
    required String eventType, // e.g. 'order_created', 'order_status_updated'
    required Map<String, dynamic> payload,
  }) {
    if (_processedEventIds.contains(eventId)) {
      debugPrint('[KitchenRealtime] Suppressed duplicate event: $eventId');
      return false;
    }

    _processedEventIds.add(eventId);
    // Keep deduplication cache bounded to last 1000 events
    if (_processedEventIds.length > 1000) {
      _processedEventIds.remove(_processedEventIds.first);
    }

    if (eventType == 'order_created') {
      _alertNotifier.playNewOrderSound();
    }

    return true;
  }

  /// Manually triggers a reconciliation cycle.
  Future<void> triggerReconciliation() async {
    if (_isReconciling || _onReconcile == null) return;
    _isReconciling = true;
    try {
      await _onReconcile();
    } catch (e) {
      debugPrint('[KitchenRealtime] Reconciliation error: $e');
    } finally {
      _isReconciling = false;
    }
  }

  void dispose() {
    _reconciliationTimer?.cancel();
    _connectivitySub?.cancel();
  }
}
