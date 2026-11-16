import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String _selectedLanguage = 'en'; // 'en', 'hi', 'mr', 'es', 'fr'
  String _selectedCurrency = 'INR (₹)';
  String _timeFormat = '12-hour (1:30 PM)';

  final List<Map<String, String>> _languages = [
    {
      'code': 'en',
      'name': 'English (United States / India)',
      'native': 'English',
      'flag': '🇬🇧',
    },
    {
      'code': 'hi',
      'name': 'Hindi (India)',
      'native': 'हिंदी',
      'flag': '🇮🇳',
    },
    {
      'code': 'mr',
      'name': 'Marathi (Maharashtra)',
      'native': 'मराठी',
      'flag': '🇮🇳',
    },
    {
      'code': 'es',
      'name': 'Spanish (Español)',
      'native': 'Español',
      'flag': '🇪🇸',
    },
    {
      'code': 'fr',
      'name': 'French (Français)',
      'native': 'Français',
      'flag': '🇫🇷',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Language & Regional Settings'),
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
          const Text(
            'Interface Language',
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
              children: _languages.asMap().entries.map((entry) {
                final idx = entry.key;
                final lang = entry.value;
                final isSelected = _selectedLanguage == lang['code'];
                final isLast = idx == _languages.length - 1;

                return Column(
                  children: [
                    ListTile(
                      leading: Text(
                        lang['flag']!,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(
                        lang['name']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      subtitle: Text(
                        lang['native']!,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryLight),
                      ),
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle_rounded,
                              color: AppColors.matchaGreen,
                              size: 22,
                            )
                          : null,
                      onTap: () {
                        setState(() => _selectedLanguage = lang['code']!);
                        HapticFeedback.lightImpact();
                      },
                    ),
                    if (!isLast) const Divider(height: 1),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),

          // Regional Formats
          const Text(
            'Currency & Financial Units',
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
                ListTile(
                  title: const Text('Default Currency Symbol', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: Text(_selectedCurrency, style: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
                  trailing: const Icon(Icons.arrow_drop_down_rounded, color: AppColors.primary),
                  onTap: () {
                    _selectCurrencyDialog(context);
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Time Display Standard', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14)),
                  subtitle: Text(_timeFormat, style: const TextStyle(color: AppColors.textSecondaryLight, fontSize: 12)),
                  trailing: const Icon(Icons.arrow_drop_down_rounded, color: AppColors.primary),
                  onTap: () {
                    _selectTimeFormatDialog(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          ElevatedButton(
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
                  content: Text('Regional and language preferences saved!'),
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Save Language Preferences'),
          ),
        ],
      ),
    );
  }

  void _selectCurrencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Select Currency Standard'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              setState(() => _selectedCurrency = 'INR (₹) • Indian Rupee');
              Navigator.pop(ctx);
            },
            child: const Text('INR (₹) • Indian Rupee'),
          ),
          SimpleDialogOption(
            onPressed: () {
              setState(() => _selectedCurrency = 'USD (\$) • US Dollar');
              Navigator.pop(ctx);
            },
            child: const Text('USD (\$) • US Dollar'),
          ),
          SimpleDialogOption(
            onPressed: () {
              setState(() => _selectedCurrency = 'EUR (€) • Euro');
              Navigator.pop(ctx);
            },
            child: const Text('EUR (€) • Euro'),
          ),
          SimpleDialogOption(
            onPressed: () {
              setState(() => _selectedCurrency = 'GBP (£) • British Pound');
              Navigator.pop(ctx);
            },
            child: const Text('GBP (£) • British Pound'),
          ),
        ],
      ),
    );
  }

  void _selectTimeFormatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Select Time Standard'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              setState(() => _timeFormat = '12-hour (1:30 PM)');
              Navigator.pop(ctx);
            },
            child: const Text('12-hour standard (1:30 PM)'),
          ),
          SimpleDialogOption(
            onPressed: () {
              setState(() => _timeFormat = '24-hour military (13:30)');
              Navigator.pop(ctx);
            },
            child: const Text('24-hour military (13:30)'),
          ),
        ],
      ),
    );
  }
}
