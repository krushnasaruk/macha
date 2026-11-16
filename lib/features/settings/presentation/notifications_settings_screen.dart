import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {
  bool _newOrderAlert = true;
  bool _kdsReadyAlert = true;
  bool _lowStockAlert = true;
  bool _offlineWarningAlert = true;
  bool _soundChime = true;
  bool _hapticFeedback = true;
  bool _dailySalesSummary = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Notifications & Alerts'),
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.primary,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header info card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.matchaGreen.withOpacity(0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_active_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Terminal Alert System',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Audio-visual chimes for counter & kitchen rush hours',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Operational Alerts
          const Text(
            'Operational Real-Time Alerts',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Incoming Order Ring', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: const Text('Rings terminal when table or counter order is placed', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
                  value: _newOrderAlert,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _newOrderAlert = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Kitchen Ready to Serve Chime', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: const Text('Alerts floor staff when prep is bumped from KDS', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
                  value: _kdsReadyAlert,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _kdsReadyAlert = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Low Stock & Safety Buffer Alert', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: const Text('Notifies when coffee beans, milk, or syrups run low', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
                  value: _lowStockAlert,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _lowStockAlert = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Offline Mode Indicator', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: const Text('Shows friendly offline indicator if WiFi disconnects', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
                  value: _offlineWarningAlert,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _offlineWarningAlert = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Audio & Sensory
          const Text(
            'Audio & Sensory Feedback',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Mechanical Keystroke Sound', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: const Text('Plays authentic mechanical typewriter audio when typing', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
                  value: _soundChime,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _soundChime = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Tactile Haptic Feedback', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: const Text('Vibrates subtly on order additions & cart buttons', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
                  value: _hapticFeedback,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _hapticFeedback = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('End of Shift Sales Summary', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: const Text('Sends daily revenue & drawer audit report at close', style: TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
                  value: _dailySalesSummary,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _dailySalesSummary = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Test Chime Button
          OutlinedButton.icon(
            icon: const Icon(Icons.volume_up_rounded),
            label: const Text('Play Sample Chime'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              HapticFeedback.heavyImpact();
              SystemSound.play(SystemSoundType.click);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sample notification chime played!'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
