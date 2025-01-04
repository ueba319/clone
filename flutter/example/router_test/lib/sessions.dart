import 'package:shared_preferences/shared_preferences.dart';

/// ログイン処理
Future<void> login() async {
  final sp = await SharedPreferences.getInstance();
  sp.setBool('isLoggedIn', true);
}

/// ログアウト処理
Future<void> logout() async {
  final sp = await SharedPreferences.getInstance();
  sp.setBool('isLoggedIn', false);
}

/// ログイン判定
Future<bool> checkLoggedIn() async {
  final sp = await SharedPreferences.getInstance();
  return sp.getBool('isLoggedIn') ?? false;
}
