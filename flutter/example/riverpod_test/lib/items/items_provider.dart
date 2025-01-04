import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'items_provider.g.dart';

@riverpod
List<String> items(ItemsRef ref) {
  return [
    'アニメ',
    'グルメ',
    '不動産',
    'ニュース',
    'エンタメ',
    '教育',
    'ビジネス',
    '自動車',
    'バイク',
    '観光',
    '手芸',
  ];
}
