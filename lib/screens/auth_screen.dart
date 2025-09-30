import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_providers.dart';
import '../utils/snack.dart';
import '../widgets/auth_form.dart';
import 'home_screen.dart';
import 'reset_password_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF2575FC), Color(0xFF6A11CB)], // ฟ้า -> ม่วง
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                elevation: 12,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: StreamBuilder(
                    stream: context.read<AuthProvider>().authChanges(),
                    builder: (ctx, snapshot) {
                      final user = context.read<AuthProvider>().currentUser;
                      if (user != null) {
                        // ป้องกันใช้ context หลัง dispose
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (ctx.mounted) {
                            Navigator.of(ctx).pushReplacementNamed(HomeScreen.route);
                            showOkSnack(ctx, 'ยินดีต้อนรับ ${user.email}');
                          }
                        });
                      }
                      return const _AuthSwitcher();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthSwitcher extends StatefulWidget {
  const _AuthSwitcher();

  @override
  State<_AuthSwitcher> createState() => _AuthSwitcherState();
}

class _AuthSwitcherState extends State<_AuthSwitcher> {
  bool isLogin = true;

  void toggle() => setState(() => isLogin = !isLogin);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(isLogin ? 'เข้าสู่ระบบ' : 'สมัครสมาชิก', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        AuthForm(
          isLogin: isLogin,
          onToggle: toggle,
          onForgot: () => Navigator.of(context).pushNamed(ResetPasswordScreen.route),
        ),
      ],
    );
  }
}
