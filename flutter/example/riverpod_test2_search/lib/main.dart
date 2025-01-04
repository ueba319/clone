import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test2_search/product_provider.dart';
import 'package:riverpod_test2_search/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  ThemeData _lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: settings.theme == 'Light' ? ThemeMode.light : ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          settings.language == 'English'
              ? 'RiverPod Sample App'
              : 'リバーポッド サンプル アプリ',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: const Column(
        children: [
          SearchBar(),
          Expanded(
            child: ProductList(),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends ConsumerWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    String labelText =
        settings.language == 'English' ? 'Search Products' : '商品を検索';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) => ref.read(productProvider.notifier).search(value),
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> products = ref.watch(productProvider);

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(products[index]),
        );
      },
    );
  }
}

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(settings.language == 'English' ? 'Settings' : '設定'),
      ),
      body: Column(
        children: [
          _buildLanguageTile(ref, settings),
          _buildThemeTile(ref, settings),
        ],
      ),
    );
  }

  ListTile _buildLanguageTile(WidgetRef ref, UserSettings settings) {
    return ListTile(
      title: Text(settings.language == 'English' ? 'Change Language' : '言語の変更'),
      trailing: Text(settings.language),
      onTap: () async {
        final newLanguage = settings.language == 'English' ? '日本語' : 'English';
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('language', newLanguage);
        ref.read(settingsProvider.notifier).updateLanguage(newLanguage);
      },
    );
  }

  ListTile _buildThemeTile(WidgetRef ref, UserSettings settings) {
    final themeText = settings.theme == 'Light'
        ? (settings.language == 'English' ? 'Light Mode' : 'ライトモード')
        : (settings.language == 'English' ? 'Dark Mode' : 'ダークモード');

    return ListTile(
      title: Text(settings.language == 'English' ? 'Change Theme' : 'テーマの変更'),
      trailing: Text(themeText),
      onTap: () async {
        final newTheme = settings.theme == 'Light' ? 'Dark' : 'Light';
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('theme', newTheme);
        ref.read(settingsProvider.notifier).updateTheme(newTheme);
      },
    );
  }
}
