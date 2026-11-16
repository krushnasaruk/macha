import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';

class OffersSettingsScreen extends StatefulWidget {
  const OffersSettingsScreen({super.key});

  @override
  State<OffersSettingsScreen> createState() => _OffersSettingsScreenState();
}

class _OffersSettingsScreenState extends State<OffersSettingsScreen> {
  final List<Map<String, dynamic>> _activeOffers = [
    {
      'title': 'Happy Hours Espresso Rush',
      'code': 'HAPPY15',
      'discount': '15% Off',
      'detail': 'Applicable on all Hot Coffees & Specialty Brews (2:00 PM – 5:00 PM)',
      'isActive': true,
      'color': const Color(0xFF6A994E),
    },
    {
      'title': 'First Sip Welcome Perk',
      'code': 'MACHA50',
      'discount': '₹50 Flat Off',
      'detail': 'On min. order value ₹350 for new customers & members',
      'isActive': true,
      'color': const Color(0xFFBC4749),
    },
    {
      'title': 'Sweet Combo Treat',
      'code': 'COMBO249',
      'discount': 'Bundle Price ₹249',
      'detail': 'Artisanal Latte + French Strawberry Tart / Brownie',
      'isActive': true,
      'color': const Color(0xFF7B2CBF),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Offers & Rewards'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Loyalty Program Summary Banner
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF293D32), Color(0xFF1B2922)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.matchaGreen.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.loyalty_rounded,
                    color: AppColors.matchaGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MΛCHA Member Loyalty',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        '1 Stamp earned for every ₹100 spent • Free signature beverage on 10 stamps',
                        style: TextStyle(
                          color: Color(0xFFDCE6DF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Active Offers Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active Promotions & Promo Codes',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Text(
                '${_activeOffers.length} Active',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Cards List
          ..._activeOffers.map((offer) {
            final isEnabled = offer['isActive'] as bool;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isEnabled ? AppColors.borderLight : Colors.grey.shade300,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: (offer['color'] as Color).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          offer['code'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: offer['color'] as Color,
                          ),
                        ),
                      ),
                      Switch(
                        value: isEnabled,
                        activeColor: AppColors.primary,
                        onChanged: (val) {
                          setState(() {
                            offer['isActive'] = val;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    offer['title'] as String,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    offer['detail'] as String,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    offer['discount'] as String,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 12),

          // Add Promotion Button
          OutlinedButton.icon(
            icon: const Icon(Icons.add_circle_outline_rounded),
            label: const Text('Create New Promotion / Discount Code'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              _showAddPromoSheet(context);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showAddPromoSheet(BuildContext context) {
    final titleCtrl = TextEditingController();
    final codeCtrl = TextEditingController();
    final discountCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
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
              'Add New Promotion Code',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Promotion Name',
                hintText: 'e.g. Afternoon Tea Discount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: codeCtrl,
              decoration: const InputDecoration(
                labelText: 'Promo Code (Uppercase)',
                hintText: 'e.g. TEA20',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: discountCtrl,
              decoration: const InputDecoration(
                labelText: 'Discount Description',
                hintText: 'e.g. 20% Off on all Teas',
                border: OutlineInputBorder(),
              ),
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
                if (titleCtrl.text.isNotEmpty && codeCtrl.text.isNotEmpty) {
                  setState(() {
                    _activeOffers.add({
                      'title': titleCtrl.text.trim(),
                      'code': codeCtrl.text.trim().toUpperCase(),
                      'discount': discountCtrl.text.trim(),
                      'detail': 'Custom promotional campaign',
                      'isActive': true,
                      'color': const Color(0xFF293D32),
                    });
                  });
                  Navigator.pop(ctx);
                  HapticFeedback.mediumImpact();
                }
              },
              child: const Text('Save & Activate Offer'),
            ),
          ],
        ),
      ),
    );
  }
}
