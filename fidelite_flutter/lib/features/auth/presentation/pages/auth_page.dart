import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../shop/presentation/widgets/shop_status_banner.dart';

/// Email/password sign-in, registration (with email verification), and
/// password reset. All flow logic and state come from [EmailAuthController]
/// -- this widget only renders whichever [EmailFlowScreen] is current and
/// forwards submissions to it. Styled with the app's own theme rather than
/// the package's generic pre-built widget, to match the rest of the app's
/// branding.
class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  late final EmailAuthController _controller;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = EmailAuthController(
      client: ref.read(serverpodClientProvider),
      onError: (error) => setState(() => _errorMessage = error.toString()),
    )..addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    setState(() {
      if (_controller.state != EmailAuthState.error) _errorMessage = null;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_controller.canNavigateBack)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: _controller.isLoading
                            ? null
                            : _controller.navigateBack,
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                  // The logo's own backdrop isn't transparent, so it's framed
                  // in its native ink-black habitat here rather than placed
                  // directly on the page background, which shifts between
                  // light/dark mode.
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ColoredBox(
                      color: AppColors.ink,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Image.asset(
                          'assets/branding/logo.png',
                          width: 220,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const ShopStatusBanner(),
                  const SizedBox(height: 16),
                  _buildScreen(context),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreen(BuildContext context) {
    final c = _controller;
    return switch (c.currentScreen) {
      EmailFlowScreen.login => _LoginForm(controller: c),
      EmailFlowScreen.startRegistration => _EmailOnlyForm(
        controller: c,
        title: 'Create an account',
        buttonLabel: 'Continue',
        onSubmit: c.startRegistration,
        footer: _SwitchModeLink(
          prompt: 'Already have an account?',
          actionLabel: 'Sign in',
          onPressed: () => c.navigateTo(EmailFlowScreen.login),
        ),
      ),
      EmailFlowScreen.verifyRegistration => _VerifyCodeForm(
        controller: c,
        subtitle:
            'We sent a verification code to ${c.emailController.text}.',
        onSubmit: c.verifyRegistrationCode,
      ),
      EmailFlowScreen.completeRegistration => _SetPasswordForm(
        controller: c,
        title: 'Choose a password',
        buttonLabel: 'Create account',
        onSubmit: c.finishRegistration,
      ),
      EmailFlowScreen.requestPasswordReset => _EmailOnlyForm(
        controller: c,
        title: 'Reset your password',
        buttonLabel: 'Send reset code',
        onSubmit: c.startPasswordReset,
        footer: _SwitchModeLink(
          prompt: 'Remembered it?',
          actionLabel: 'Sign in',
          onPressed: () => c.navigateTo(EmailFlowScreen.login),
        ),
      ),
      EmailFlowScreen.verifyPasswordReset => _VerifyCodeForm(
        controller: c,
        subtitle:
            'We sent a password reset code to ${c.emailController.text}.',
        onSubmit: c.verifyPasswordResetCode,
      ),
      EmailFlowScreen.completePasswordReset => _SetPasswordForm(
        controller: c,
        title: 'Choose a new password',
        buttonLabel: 'Reset password',
        onSubmit: c.finishPasswordReset,
      ),
    };
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({required this.controller});

  final EmailAuthController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Sign in', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 24),
        TextField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller.passwordController,
          obscureText: true,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(labelText: 'Password'),
          onSubmitted: (_) => controller.login(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () =>
                controller.navigateTo(EmailFlowScreen.requestPasswordReset),
            child: const Text('Forgot password?'),
          ),
        ),
        const SizedBox(height: 12),
        _SubmitButton(
          isLoading: controller.isLoading,
          label: 'Sign in',
          onPressed: controller.login,
        ),
        const SizedBox(height: 16),
        _SwitchModeLink(
          prompt: "Don't have an account?",
          actionLabel: 'Register',
          onPressed: () =>
              controller.navigateTo(EmailFlowScreen.startRegistration),
        ),
      ],
    );
  }
}

class _EmailOnlyForm extends StatelessWidget {
  const _EmailOnlyForm({
    required this.controller,
    required this.title,
    required this.buttonLabel,
    required this.onSubmit,
    required this.footer,
  });

  final EmailAuthController controller;
  final String title;
  final String buttonLabel;
  final Future<void> Function() onSubmit;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 24),
        TextField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(labelText: 'Email'),
          onSubmitted: (_) => onSubmit(),
        ),
        const SizedBox(height: 20),
        _SubmitButton(
          isLoading: controller.isLoading,
          label: buttonLabel,
          onPressed: onSubmit,
        ),
        const SizedBox(height: 16),
        footer,
      ],
    );
  }
}

class _VerifyCodeForm extends StatelessWidget {
  const _VerifyCodeForm({
    required this.controller,
    required this.subtitle,
    required this.onSubmit,
  });

  final EmailAuthController controller;
  final String subtitle;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Check your email',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        TextField(
          controller: controller.verificationCodeController,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(labelText: 'Verification code'),
          onSubmitted: (_) => onSubmit(),
        ),
        const SizedBox(height: 20),
        _SubmitButton(
          isLoading: controller.isLoading,
          label: 'Verify',
          onPressed: onSubmit,
        ),
      ],
    );
  }
}

class _SetPasswordForm extends StatelessWidget {
  const _SetPasswordForm({
    required this.controller,
    required this.title,
    required this.buttonLabel,
    required this.onSubmit,
  });

  final EmailAuthController controller;
  final String title;
  final String buttonLabel;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 24),
        TextField(
          controller: controller.passwordController,
          obscureText: true,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(labelText: 'Password'),
          onSubmitted: (_) => onSubmit(),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            controller.passwordRequirements
                .map((r) => r.description)
                .join(' · '),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const SizedBox(height: 16),
        _SubmitButton(
          isLoading: controller.isLoading,
          label: buttonLabel,
          onPressed: onSubmit,
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.isLoading,
    required this.label,
    required this.onPressed,
  });

  final bool isLoading;
  final String label;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(label),
      ),
    );
  }
}

class _SwitchModeLink extends StatelessWidget {
  const _SwitchModeLink({
    required this.prompt,
    required this.actionLabel,
    required this.onPressed,
  });

  final String prompt;
  final String actionLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Text(prompt),
        TextButton(onPressed: onPressed, child: Text(actionLabel)),
      ],
    );
  }
}
