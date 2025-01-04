import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorites_provider.g.dart';

const _key = 'favorites';

// @riverpod
// Future<Set<String>> favorites(FavoritesRef ref) async {
//   return {'アニメ', 'グルメ'};
// }

@riverpod
class Favorites extends _$Favorites {
  @override
  FutureOr<Set<String>> build() async {
    final sp = await SharedPreferences.getInstance();
    final favorites = sp.getStringList(_key) ?? <String>[];
    return Set.from(favorites);
  }

  Future<void> addItem(String item) async {
    final set = state.value ?? {};
    set.add(item);
    await _saveSet(set);
  }

  Future<void> removeItem(String item) async {
    final set = state.value ?? {};
    set.remove(item);
    await _saveSet(set);
  }

  Future<void> _saveSet(Set<String> set) async {
    final sp = await SharedPreferences.getInstance();
    sp.setStringList(_key, set.toList(growable: false));

    state = AsyncData(set);
  }
}
