import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/components/app_button.dart';
import '../../../core/components/app_card.dart';
import '../../../core/components/app_text_field.dart';
import '../../../core/components/offline_sync_indicator.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../data/repositories/tenant_settings_repository_impl.dart';

class TenantSettingsScreen extends ConsumerStatefulWidget {
  const TenantSettingsScreen({super.key});

  @override
  ConsumerState<TenantSettingsScreen> createState() => _TenantSettingsScreenState();
}

class _TenantSettingsScreenState extends ConsumerState<TenantSettingsScreen> {
  final _currencyController = TextEditingController(text: 'INR');
  final _timezoneController = TextEditingController(text: 'Asia/Kolkata');
  final _gstinController = TextEditingController(text: '27AABCA1234F1Z5');
  final _prefixController = TextEditingController(text: 'INV');
  bool _isSaving = false;

  @override
  void dispose() {
    _currencyController.dispose();
    _timezoneController.dispose();
    _gstinController.dispose();
    _prefixController.dispose();
    super.dispose();
  }

  void _loadExistingSettings() async {
    final identity = ref.read(currentIdentityNotifier);
    final repo = ref.read(tenantSettingsRepositoryProvider);
    final settings = await repo.getSettings(identity.tenant.id);
    if (settings != null && mounted) {
      setState(() {
        _currencyController.text = settings.currency;
        _timezoneController.text = settings.timezone;
        _gstinController.text = settings.gstin ?? '';
        _prefixController.text = settings.invoicePrefix;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadExistingSettings();
  }

  @override
  Widget build(BuildContext context) {
    final identity = ref.watch(currentIdentityNotifier);
    final repo = ref.watch(tenantSettingsRepositoryProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Tenant & Billing Settings'),
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.primary,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
          fontSize: 20,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: OfflineSyncIndicator(),
          ),
        ],
      ),
      body: ListView(
        padding: AppSpacing.paddingLg,
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  identity.tenant.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tenant ID: ${identity.tenant.id}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Fiscal & GST Configuration',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(height: 8),
          AppCard(
            child: Column(
              children: [
                AppTextField(
                  label: 'Operating Currency',
                  controller: _currencyController,
                  hint: 'e.g. INR',
                  prefixIcon: const Icon(Icons.currency_rupee_rounded),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Timezone',
                  controller: _timezoneController,
                  hint: 'e.g. Asia/Kolkata',
                  prefixIcon: const Icon(Icons.schedule_rounded),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'GSTIN (Goods and Services Tax ID)',
                  controller: _gstinController,
                  hint: '27AABCA1234F1Z5',
                  prefixIcon: const Icon(Icons.receipt_long_rounded),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Invoice Prefix (Offline series generator - ADR-D3)',
                  controller: _prefixController,
                  hint: 'INV',
                  prefixIcon: const Icon(Icons.tag_rounded),
                ),
                const SizedBox(height: 24),
                AppButton(
                  label: 'Save Configuration',
                  icon: Icons.check_circle_outline_rounded,
                  isLoading: _isSaving,
                  isFullWidth: true,
                  onPressed: () async {
                    setState(() => _isSaving = true);
                    try {
                      await repo.saveSettings(
                        tenantId: identity.tenant.id,
                        currency: _currencyController.text.trim(),
                        timezone: _timezoneController.text.trim(),
                        gstin: _gstinController.text.trim().isEmpty ? null : _gstinController.text.trim(),
                        invoicePrefix: _prefixController.text.trim().isEmpty ? 'INV' : _prefixController.text.trim(),
                      );
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Settings saved locally and queued for sync!')),
                        );
                      }
                    } finally {
                      if (mounted) setState(() => _isSaving = false);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
