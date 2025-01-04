import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:router_test/sessions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
        actions: [
          TextButton(
            onPressed: () async {
              await logout();
              if (context.mounted) context.go('/login');
            },
            child: const Text('ログアウト'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.push('/detail/A');
              },
              child: const Text('Aを閲覧する。'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/detail/B');
              },
              child: const Text('Bを閲覧する。'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/detail/C');
              },
              child: const Text('Cを閲覧する。'),
            ),
          ],
        ),
      ),
    );
  }
}
