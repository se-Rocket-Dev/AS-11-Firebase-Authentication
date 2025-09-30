import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_providers.dart';
import '../utils/snack.dart';

class AuthForm extends StatefulWidget {
  final bool isLogin;
  final VoidCallback onToggle;
  final VoidCallback onForgot;

  const AuthForm({
    super.key,
    required this.isLogin,
    required this.onToggle,
    required this.onForgot,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();

  @override
  void dispose() {
    _emailC.dispose();
    _passC.dispose();
    super.dispose();
  }

  String? _emailV(String? v) {
    if (v == null || v.trim().isEmpty) return 'กรอกอีเมล';
    final re = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!re.hasMatch(v.trim())) return 'รูปแบบอีเมลไม่ถูกต้อง';
    return null;
  }

  String? _passV(String? v) {
    if (v == null || v.length < 6) return 'รหัสผ่านอย่างน้อย 6 ตัวอักษร';
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final email = _emailC.text.trim();
    final pass = _passC.text;
    final isLogin = widget.isLogin;

    String? err;
    if (isLogin) {
      err = await auth.signIn(email, pass);
    } else {
      err = await auth.signUp(email, pass);
    }

    if (!mounted) return; // ป้องกันใช้ context หลัง dispose

    if (err == null) {
      showOkSnack(context, isLogin ? 'เข้าสู่ระบบสำเร็จ' : 'สมัครสมาชิกสำเร็จ');
    } else {
      // ตรงนี้ปลอดภัยเพราะอยู่ในกิ่งที่ err != null แล้ว (non-null)
      showErrSnack(context, err);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthProvider>().loading;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _emailC,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'อีเมล'),
            validator: _emailV,
            autofillHints: const [AutofillHints.email],
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _passC,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'รหัสผ่าน'),
            validator: _passV,
            autofillHints: const [AutofillHints.password],
            onFieldSubmitted: (_) => loading ? null : _submit(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: loading ? null : _submit,
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
              child: loading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(widget.isLogin ? 'เข้าสู่ระบบ' : 'สมัครสมาชิก'),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: loading ? null : widget.onToggle,
                child: Text(widget.isLogin ? 'ไปที่ สมัครสมาชิก' : 'ไปที่ เข้าสู่ระบบ'),
              ),
              if (widget.isLogin)
                TextButton(
                  onPressed: loading ? null : widget.onForgot,
                  child: const Text('ลืมรหัสผ่าน?'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
