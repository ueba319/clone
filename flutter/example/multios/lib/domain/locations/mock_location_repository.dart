import 'dart:async';

import './location_repository.dart';

class MockLocationRepository extends LocationRepository {
  /// 1) 位置情報を一度だけ取得します。
  @override
  Future<Location> get() async {
    return const Location(35, 135);
  }

  /// 2) 位置情報を常に監視します。(後ほど追加)
}
