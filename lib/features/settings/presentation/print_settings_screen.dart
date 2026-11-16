import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';

class PrintSettingsScreen extends StatefulWidget {
  const PrintSettingsScreen({super.key});

  @override
  State<PrintSettingsScreen> createState() => _PrintSettingsScreenState();
}

class _PrintSettingsScreenState extends State<PrintSettingsScreen> {
  String _selectedConnectionType = 'bluetooth'; // 'bluetooth', 'lan', 'usb'
  String _selectedPaperWidth = '80mm'; // '80mm', '58mm'
  bool _autoPrintReceipt = true;
  bool _autoPrintKot = true;
  bool _printQrCode = true;
  bool _printMascotFooter = true;
  bool _buzzerSound = false;
  final String _printerStatus = 'Connected: Star TSP100 (Thermal POS-80)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Thermal Printer Settings'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Status Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.borderLight),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
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
                    Icons.print_rounded,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Receipt Printer Hardware',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _printerStatus,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondaryLight,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Connection Type Section
          const Text(
            'Connection Interface',
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
                RadioListTile<String>(
                  title: const Text('Bluetooth (Wireless Mobile POS)'),
                  subtitle: const Text('Direct pairing with portable thermal printers'),
                  value: 'bluetooth',
                  groupValue: _selectedConnectionType,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _selectedConnectionType = val!),
                ),
                const Divider(height: 1),
                RadioListTile<String>(
                  title: const Text('Ethernet / LAN (Countertop Network)'),
                  subtitle: const Text('Reliable high-speed cable connection (192.168.1.100)'),
                  value: 'lan',
                  groupValue: _selectedConnectionType,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _selectedConnectionType = val!),
                ),
                const Divider(height: 1),
                RadioListTile<String>(
                  title: const Text('USB Direct (Desktop Terminal)'),
                  subtitle: const Text('Direct USB cable connection'),
                  value: 'usb',
                  groupValue: _selectedConnectionType,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _selectedConnectionType = val!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Paper Width
          const Text(
            'Paper Format',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Roll Width Standard',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: '80mm', label: Text('80 mm')),
                    ButtonSegment(value: '58mm', label: Text('58 mm')),
                  ],
                  selected: {_selectedPaperWidth},
                  onSelectionChanged: (val) =>
                      setState(() => _selectedPaperWidth = val.first),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Printing Automation Options
          const Text(
            'Automation & Receipt Content',
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
                  title: const Text('Auto-Print Customer Receipt'),
                  subtitle: const Text('Prints immediately upon order tender settlement'),
                  value: _autoPrintReceipt,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _autoPrintReceipt = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Print Kitchen Prep Ticket (KOT)'),
                  subtitle: const Text('Sends drink and food items to prep station printer'),
                  value: _autoPrintKot,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _autoPrintKot = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Print UPI QR Code on Bill'),
                  subtitle: const Text('Prints dynamic invoice QR for instant mobile scan & pay'),
                  value: _printQrCode,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _printQrCode = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Print Chef Barnaby Mascot Footer'),
                  subtitle: const Text('Adds friendly Café mascot graphic & thank-you note'),
                  value: _printMascotFooter,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _printMascotFooter = val),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Hardware Buzzer Chime'),
                  subtitle: const Text('Sounds thermal printer beep when receipt prints'),
                  value: _buzzerSound,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _buzzerSound = val),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Test Print Button
          ElevatedButton.icon(
            icon: const Icon(Icons.receipt_long_rounded),
            label: const Text('Test Print Sample Receipt'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            onPressed: () {
              HapticFeedback.mediumImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Test receipt sent to Star TSP100 thermal printer!'),
                  duration: Duration(seconds: 2),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
