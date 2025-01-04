import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_test/sessions.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('このアプリをご利用の方はログインください。'),
            ElevatedButton(
              onPressed: () async {
                await login();
                if (context.mounted) context.go('/login/redirection');
              },
              child: const Text('ログインする'),
            ),
          ],
        ),
      ),
    );
  }
}
