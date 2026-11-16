import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/identity/identity_models.dart';
import '../../../core/identity/identity_provider.dart';
import '../../../core/mascot/mascot_guided_tour.dart';
import '../../../core/theme/app_colors.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _cafeNameCtrl = TextEditingController(text: 'The Daily Brew & Bakery');
  final _ownerNameCtrl = TextEditingController(text: 'Alex Morgan');
  final _emailCtrl = TextEditingController(text: 'alex@dailybrew.cafe');
  final _passwordCtrl = TextEditingController(text: 'macha123');
  String _businessType = 'Specialty Coffee Shop';
  bool _agreeTerms = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _cafeNameCtrl.dispose();
    _ownerNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _createAccount() {
    setState(() => _isLoading = true);
    HapticFeedback.mediumImpact();

    // Switch role to Owner
    final devId = ref.read(identityProviderInstance);
    if (devId is DevIdentityProvider) {
      devId.switchRole(UserRole.owner);
    }

    // Automatically trigger Chef Barnaby Guided Tour walkthrough
    ref.read(isTourActiveProvider.notifier).state = true;
    ref.read(currentTourStepIndexProvider.notifier).state = 0;

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() => _isLoading = false);
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo & Header
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Λ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'MΛCHA',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.8,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Register your café terminal and start brewing',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Café Name
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderLight, width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _cafeNameCtrl,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Café / Business Name',
                        labelStyle: TextStyle(
                          color: AppColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        prefixIcon: Icon(Icons.storefront_rounded, color: AppColors.primary),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Owner Name
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderLight, width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _ownerNameCtrl,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Owner / Manager Full Name',
                        labelStyle: TextStyle(
                          color: AppColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        prefixIcon: Icon(Icons.person_outline_rounded, color: AppColors.primary),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Business Type Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderLight, width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _businessType,
                        isExpanded: true,
                        icon: const Icon(Icons.arrow_drop_down_rounded, color: AppColors.primary),
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'Specialty Coffee Shop',
                            child: Text('Specialty Coffee Shop'),
                          ),
                          DropdownMenuItem(
                            value: 'Bakery & Patisserie',
                            child: Text('Bakery & Patisserie'),
                          ),
                          DropdownMenuItem(
                            value: 'Quick-Service Bistro',
                            child: Text('Quick-Service Bistro'),
                          ),
                          DropdownMenuItem(
                            value: 'Artisan Food Truck',
                            child: Text('Artisan Food Truck'),
                          ),
                        ],
                        onChanged: (val) => setState(() => _businessType = val!),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Email Input
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderLight, width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Admin Email',
                        labelStyle: TextStyle(
                          color: AppColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        prefixIcon: Icon(Icons.email_outlined, color: AppColors.primary),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Password Input
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderLight, width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _passwordCtrl,
                      obscureText: true,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Terminal Master PIN / Password',
                        labelStyle: TextStyle(
                          color: AppColors.textSecondaryLight,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        prefixIcon: Icon(Icons.lock_outline_rounded, color: AppColors.primary),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Terms checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _agreeTerms,
                        activeColor: AppColors.primary,
                        onChanged: (val) => setState(() => _agreeTerms = val ?? true),
                      ),
                      const Expanded(
                        child: Text(
                          'I agree to the MΛCHA Terms & Offline-First Privacy Policy',
                          style: TextStyle(fontSize: 11, color: AppColors.textSecondaryLight),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Create Account Button
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 1,
                      ),
                      onPressed: _isLoading ? null : _createAccount,
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                            )
                          : const Text(
                              'Create Free Café Terminal →',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have a terminal? ',
                        style: TextStyle(fontSize: 13, color: AppColors.textSecondaryLight),
                      ),
                      GestureDetector(
                        onTap: () => context.go('/login'),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
