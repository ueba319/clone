import 'package:go_router/go_router.dart';
import 'package:router_test/detail_page.dart';
import 'package:router_test/home_page.dart';
import 'package:router_test/login_page.dart';
import 'package:router_test/sessions.dart';
import 'package:router_test/splash_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login/redirection',
      name: 'login-redirection',
      redirect: (context, state) async {
        if (await checkLoggedIn()) {
          return '/home';
        } else {
          return '/login';
        }
      },
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        restorationId: state.pageKey.value,
        child: const HomePage(),
      ),
    ),
    GoRoute(
      path: '/detail/:id',
      name: 'detail',
      builder: (context, state) => DetailPage(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        restorationId: state.pageKey.value,
        child: const LoginPage(),
      ),
      builder: (context, state) => const LoginPage(),
    ),
  ],
);
