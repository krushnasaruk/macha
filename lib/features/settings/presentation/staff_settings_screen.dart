import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';

class StaffSettingsScreen extends StatefulWidget {
  const StaffSettingsScreen({super.key});

  @override
  State<StaffSettingsScreen> createState() => _StaffSettingsScreenState();
}

class _StaffSettingsScreenState extends State<StaffSettingsScreen> {
  final List<Map<String, dynamic>> _staffMembers = [
    {
      'name': 'Krushna Saruk',
      'role': 'Owner / General Manager',
      'pin': '**** (8888)',
      'status': 'On Duty',
      'avatar': 'K',
      'isClockedIn': true,
      'color': const Color(0xFF293D32),
    },
    {
      'name': 'Rahul Verma',
      'role': 'Head Barista & Shift Lead',
      'pin': '**** (1001)',
      'status': 'On Duty',
      'avatar': 'R',
      'isClockedIn': true,
      'color': const Color(0xFF8B5E3C),
    },
    {
      'name': 'Ananya Sen',
      'role': 'Cashier & Floor Associate',
      'pin': '**** (1002)',
      'status': 'Break',
      'avatar': 'A',
      'isClockedIn': true,
      'color': const Color(0xFFBC4749),
    },
    {
      'name': 'Vikram Joshi',
      'role': 'Kitchen Prep & KDS Chef',
      'pin': '**** (1003)',
      'status': 'On Duty',
      'avatar': 'V',
      'isClockedIn': true,
      'color': const Color(0xFF6A994E),
    },
    {
      'name': 'Pooja Nair',
      'role': 'Floor Waitstaff',
      'pin': '**** (1004)',
      'status': 'Off Shift',
      'avatar': 'P',
      'isClockedIn': false,
      'color': Colors.grey,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final activeCount = _staffMembers.where((s) => s['isClockedIn'] as bool).length;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Staff Management'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Shift Overview KPI card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.borderLight),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildKpiItem('Total Team', '${_staffMembers.length}', Icons.badge_outlined),
                Container(width: 1, height: 36, color: AppColors.borderLight),
                _buildKpiItem('Active On Shift', '$activeCount', Icons.timelapse_rounded, isGreen: true),
                Container(width: 1, height: 36, color: AppColors.borderLight),
                _buildKpiItem('Roles', '5 Tiers', Icons.security_rounded),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Team Roster Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Café Team Members & Terminals',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Text(
                '$activeCount Clocked In',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.matchaGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Staff Cards List
          ..._staffMembers.map((staff) {
            final isClocked = staff['isClockedIn'] as bool;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: (staff['color'] as Color).withOpacity(0.18),
                    child: Text(
                      staff['avatar'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: staff['color'] as Color,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          staff['name'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${staff['role']} • PIN ${staff['pin']}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isClocked ? const Color(0xFFEDF3E8) : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      staff['status'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isClocked ? const Color(0xFF293D32) : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 12),

          // Add Staff Member Button
          ElevatedButton.icon(
            icon: const Icon(Icons.person_add_alt_1_rounded),
            label: const Text('Add Staff Member to Terminal'),
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
              _showAddStaffSheet(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildKpiItem(String label, String value, IconData icon, {bool isGreen = false}) {
    return Column(
      children: [
        Icon(icon, size: 20, color: isGreen ? AppColors.matchaGreen : AppColors.primary),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isGreen ? AppColors.matchaGreen : AppColors.primary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondaryLight),
        ),
      ],
    );
  }

  void _showAddStaffSheet(BuildContext context) {
    final nameCtrl = TextEditingController();
    String selectedRole = 'Cashier & Barista';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enroll New Team Member',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'e.g. Maya Patel',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Role & Terminal Access',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Cashier & Barista', child: Text('Cashier & Barista (POS & Billing)')),
                  DropdownMenuItem(value: 'Kitchen Chef', child: Text('Kitchen Chef (KDS Prep Tickets)')),
                  DropdownMenuItem(value: 'Shift Manager', child: Text('Shift Manager (Inventory & Reports)')),
                  DropdownMenuItem(value: 'Floor Waiter', child: Text('Floor Waiter (Table Orders)')),
                ],
                onChanged: (val) => setSheetState(() => selectedRole = val!),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (nameCtrl.text.isNotEmpty) {
                    setState(() {
                      _staffMembers.add({
                        'name': nameCtrl.text.trim(),
                        'role': selectedRole,
                        'pin': '**** (1005)',
                        'status': 'On Duty',
                        'avatar': nameCtrl.text.trim()[0].toUpperCase(),
                        'isClockedIn': true,
                        'color': const Color(0xFF293D32),
                      });
                    });
                    Navigator.pop(ctx);
                    HapticFeedback.mediumImpact();
                  }
                },
                child: const Text('Add Member & Issue Terminal PIN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
