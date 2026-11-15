import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';

/// Performance metrics collector for frame rates and jank detection.
class FrameMetricsNotifier extends ChangeNotifier {
  int _totalFrames = 0;
  int _jankyFrames = 0;
  double _currentFps = 60.0;
  DateTime _lastFrameTime = DateTime.now();

  int get totalFrames => _totalFrames;
  int get jankyFrames => _jankyFrames;
  double get currentFps => _currentFps;
  double get jankPercentage =>
      _totalFrames == 0 ? 0.0 : (_jankyFrames / _totalFrames) * 100;

  void recordFrame(Duration frameDuration) {
    _totalFrames++;
    final ms = frameDuration.inMicroseconds / 1000.0;
    if (ms > 16.6) {
      _jankyFrames++;
    }

    final now = DateTime.now();
    final elapsedSec = now.difference(_lastFrameTime).inMicroseconds / 1000000.0;
    if (elapsedSec > 0.5) {
      _currentFps = (_totalFrames / elapsedSec).clamp(0.0, 120.0);
      _lastFrameTime = now;
      notifyListeners();
    }
  }

  void reset() {
    _totalFrames = 0;
    _jankyFrames = 0;
    _currentFps = 60.0;
    _lastFrameTime = DateTime.now();
    notifyListeners();
  }
}

final frameMetricsProvider = ChangeNotifierProvider<FrameMetricsNotifier>((ref) {
  final notifier = FrameMetricsNotifier();
  if (kDebugMode || kProfileMode) {
    SchedulerBinding.instance.addTimingsCallback((timings) {
      for (final timing in timings) {
        notifier.recordFrame(timing.totalSpan);
      }
    });
  }
  return notifier;
});

final uxHudVisibleProvider = StateProvider<bool>((ref) => false);
final simulatedLatencyMsProvider = StateProvider<int>((ref) => 0);

/// Floating Dev UX HUD overlay for profile & debug builds.
class UxHudOverlay extends ConsumerWidget {
  final Widget child;

  const UxHudOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!kDebugMode && !kProfileMode) {
      return child;
    }

    final isVisible = ref.watch(uxHudVisibleProvider);
    final metrics = ref.watch(frameMetricsProvider);
    final latency = ref.watch(simulatedLatencyMsProvider);

    return Stack(
      children: [
        child,
        if (isVisible)
          Positioned(
            top: 40,
            right: 16,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withOpacity(0.85),
              child: Container(
                width: 210,
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '⚡ UX METRICS HUD',
                          style: TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              ref.read(uxHudVisibleProvider.notifier).state = false,
                          child: const Icon(Icons.close, size: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'FPS: ${metrics.currentFps.toStringAsFixed(1)}',
                      style: TextStyle(
                        color: metrics.currentFps >= 55 ? Colors.greenAccent : Colors.orangeAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Jank: ${metrics.jankPercentage.toStringAsFixed(1)}% (${metrics.jankyFrames}/${metrics.totalFrames})',
                      style: TextStyle(
                        color: metrics.jankPercentage < 2 ? Colors.white70 : Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                    const Divider(color: Colors.white24, height: 16),
                    Text(
                      'Simulated Latency: ${latency}ms',
                      style: const TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                    Slider(
                      value: latency.toDouble(),
                      min: 0,
                      max: 2000,
                      divisions: 8,
                      activeColor: AppColors.primary,
                      onChanged: (val) => ref
                          .read(simulatedLatencyMsProvider.notifier)
                          .state = val.round(),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () => metrics.reset(),
                        child: const Text(
                          'Reset Metrics',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        // Mini toggle button in top corner
        Positioned(
          bottom: 12,
          right: 12,
          child: Opacity(
            opacity: 0.45,
            child: FloatingActionButton.small(
              heroTag: 'ux_hud_toggle',
              backgroundColor: Colors.black87,
              onPressed: () => ref
                  .read(uxHudVisibleProvider.notifier)
                  .update((visible) => !visible),
              child: const Icon(Icons.speed_rounded, size: 18, color: Colors.amberAccent),
            ),
          ),
        ),
      ],
    );
  }
}
