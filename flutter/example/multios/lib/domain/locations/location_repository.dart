import 'location.dart';

export 'location.dart';

abstract class LocationRepository {
  /// 1) 位置情報を一度だけ取得します。
  Future<Location> get();

  /// 2) 位置情報を常に監視します。(後ほど追加)
}
